import 'dart:async';
import 'dart:convert';
import 'dart:developer' as s;

import 'package:country_code_picker/country_code_picker.dart';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/common/app_api.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/gen/model/enums/login_enum.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetCountriesModel.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetLogin.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetNewCountries.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../gen/model/json/FromJsonGetLoginV2.dart';
import '../../common/app_color.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController implements RequestInterface {
  final String clientId = "9ddd87cf-12ac-464b-8fbb-874e88a10b98";
  final String redirectUri = "oauth://mediaverse.global/redirect";
  final String authUrl = '${F.apiurl.substring(0, F.apiurl.lastIndexOf("/") - 2)}oauth/authorize';
  final String tokenUrl = '${F.apiurl.substring(0, F.apiurl.lastIndexOf("/") - 2)}oauth/token';

  late ApiRequster apiRequster;
  var code = CountryModel.fromJson(jsonDecode("""{
    "iso": "FR",
    "name": "France",
    "title": "France",
    "calling_code": "+33",
    "dialing_code": "+33",
    "continent": "Europe",
    "stripe_supported": 1
  }""")).obs;
  var timeLeft = 30.obs;
  Timer? _timer;
  var box = GetStorage();
  LoginEnum loginEnum;
  List<CountryModel> countries = [];
  TextEditingController eTextEditingControllerPhone = TextEditingController();
  TextEditingController eTextEditingControllerUsername = TextEditingController();
  TextEditingController eTextEditingControllerEmail = TextEditingController();
  TextEditingController eTextEditingControllerPassword = TextEditingController();
  TextEditingController eTextEditingControllerOTP = TextEditingController();
  var isloading = false.obs;
  var isloadingTwitter = false.obs;
  var isloadingCustomLogin = false.obs;
  String twitterLoginState = "";

  LoginController(this.loginEnum);

  @override
  void onInit() {
    super.onInit();
    apiRequster = ApiRequster(this, develperModel: true);
    getCountries();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (timeLeft.value == 0) {
        _timer?.cancel();
        timeLeft.value = 0;
        update();
      } else {
        timeLeft.value--;
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<String> generateCodeVerifier() async {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';
    final random = Random.secure();
    return List.generate(128, (_) => chars[random.nextInt(chars.length)]).join();
  }

  Future<String> generateCodeChallenge(String codeVerifier) async {
    final bytes = utf8.encode(codeVerifier);
    final digest = sha256.convert(bytes);
    return base64Url.encode(digest.bytes).replaceAll('=', '');
  }

  String generateAuthUrl(String codeChallenge) {
    final uri = Uri.parse(authUrl).replace(queryParameters: {
      'client_id': clientId,
      'redirect_uri': redirectUri,
      'response_type': 'code',
      'scope': '',
      'code_challenge': codeChallenge,
      'code_challenge_method': 'S256',
    });
    return uri.toString();
  }

  Future<Map<String, dynamic>> exchangeCodeForToken(String codeValue, String codeVerifier) async {
    isloadingCustomLogin(true);
    final response = await http.post(
      Uri.parse(tokenUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'authorization_code',
        'client_id': clientId,
        'code': codeValue,
        'redirect_uri': redirectUri,
        'code_verifier': codeVerifier,
      },
    );
    isloadingCustomLogin(false);
    if (response.statusCode == 200) {
      s.log('LoginController.exchangeCodeForToken = ${response.body}');
      box.write("islogin", true);
      box.write("token", jsonDecode(response.body)['access_token']);

      Get.offAllNamed(PageRoutes.WRAPPER);
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to exchange code for token');
    }
  }

  Future<void> initiateLogin(BuildContext context) async {
    isloadingCustomLogin(true);
    final codeVerifier = await generateCodeVerifier();
    final codeChallenge = await generateCodeChallenge(codeVerifier);
    await box.write('codeVerifier', codeVerifier);
    final url = generateAuthUrl(codeChallenge);
    isloadingCustomLogin(false);
    final codeValue = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => _OAuthWebView(url),
      ),
    );
    if (codeValue != null) {
      await getToken(codeValue);
    }
  }

  Future<Map<String, dynamic>> getToken(String codeValue) async {
    final codeVerifier = box.read<String>('codeVerifier');
    if (codeVerifier == null) {
      throw Exception('Code verifier not found');
    }
    return await exchangeCodeForToken(codeValue, codeVerifier);
  }

  requestLogin() {
    isloading(true);
    switch (loginEnum) {
      case LoginEnum.phone:
        if (eTextEditingControllerPhone.text.isEmpty || eTextEditingControllerPassword.text.isEmpty) {
          Constant.showMessege("alert_11".tr);
          isloading(false);
          break;
        }
        _getPhoneReuqest();
        break;
      case LoginEnum.username:
        if (eTextEditingControllerUsername.text.isEmpty || eTextEditingControllerPassword.text.isEmpty) {
          Constant.showMessege("Please fill out the form".tr);
          isloading(false);
          break;
        }
        _getUseranmeReuqest();
        break;
      case LoginEnum.SMS:
        if (eTextEditingControllerPhone.text.isEmpty) {
          Constant.showMessege("Please fill out the form".tr);
          isloading(false);
          break;
        }
        _getOTPReuqest();
        break;
    }
  }

  void _getPhoneReuqest() {
    var body = {
      "cellphone": code.value.dialingCode! + eTextEditingControllerPhone.text,
      "password": eTextEditingControllerPassword.text
    };
    apiRequster.request("auth/sign-in", ApiRequster.MHETOD_POST, 1, body: body);
  }

  void _getUseranmeReuqest() {
    var body = {"password": eTextEditingControllerPassword.text};
    if (!eTextEditingControllerUsername.text.isEmail) {
      body['username'] = eTextEditingControllerUsername.text;
    } else {
      body['email'] = eTextEditingControllerUsername.text;
    }
    apiRequster.request("auth/sign-in", ApiRequster.MHETOD_POST, 1, body: body);
  }

  void _getOTPReuqest() {
    var body = {"cellphone": (code.value.dialingCode ?? "") + eTextEditingControllerPhone.text};
    apiRequster.request("auth/otp/request", ApiRequster.MHETOD_POST, 2, body: body);
  }

  void getOTPSumbit() {
    isloading(true);
    var body = {
      "cellphone": "${code.value.dialingCode}${eTextEditingControllerPhone.text}",
      "otp": eTextEditingControllerOTP.text
    };
    apiRequster.request("auth/otp/submit", ApiRequster.MHETOD_POST, 1, body: body);
  }

  void sendIDTokenToServer(String s) {
    apiRequster.request("auth/google", ApiRequster.MHETOD_POST, 1, body: {"access_token": s});
  }

  void getCountries() {
    apiRequster.request("countries", ApiRequster.MHETOD_GET, 4);
  }

  void getTwitterLogin() {
    isloadingTwitter(true);
    apiRequster.request("auth/x/url", ApiRequster.MHETOD_GET, 3);
  }

  void getTwitterAccessToken() {
    isloadingTwitter(true);
    apiRequster.request("auth/x", ApiRequster.MHETOD_POST, 1, body: {"state": twitterLoginState});
  }

  void peaseJsonFromGetTwitterAuth(source) async {
    twitterLoginState = jsonDecode(source)['state'];
    await launchUrlString(jsonDecode(source)['url']);
  }

  void twiiterButtonVisiable() {
    if (isloadingTwitter.isTrue) {
      getTwitterAccessToken();
    }
  }

  void peaseJsonFromGetCountries(source) {
    countries = FromJsonGetNewCountries.fromJson(jsonDecode(source)).data ?? [];
  }

  void peaseJsonFromGetPhoneOTP(source) {
    try {
      timeLeft = (jsonDecode(source)['expires_after'] as int).obs;
      startTimer();
    } catch (e) {}
    update();
    if (!Get.currentRoute.contains(PageRoutes.OTP)) {
      Get.toNamed(PageRoutes.OTP, arguments: [this]);
    }
  }

  void praseJsonFromGetLogin(source) {
    box.write("islogin", true);
    FromJsonGetLoginV2 getLogin = FromJsonGetLoginV2.fromJson(jsonDecode(source));
    box.write("token", getLogin.token ?? "");
    box.write("userid", getLogin.user!.id.toString());
    Get.offAllNamed(PageRoutes.WRAPPER);
  }

  @override
  void onError(String content, int reqCode, bodyError) {
    isloadingTwitter(false);
    isloading(false);
    try {
      var messege = jsonDecode(bodyError)['message'];
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text(messege, style: TextStyle(color: AppColor.primaryDarkColor)),
        ),
      );
    } catch (e) {}
  }

  @override
  void onStartReuqest(int reqCode) {}

  @override
  void onSucces(source, int reqCdoe) {
    isloading(false);
    switch (reqCdoe) {
      case 1:
        praseJsonFromGetLogin(source);
        break;
      case 2:
        peaseJsonFromGetPhoneOTP(source);
        break;
      case 3:
        peaseJsonFromGetTwitterAuth(source);
        break;
      case 4:
        peaseJsonFromGetCountries(source);
        break;
    }
  }
}

class _OAuthWebView extends StatefulWidget {
  final String url;
  const _OAuthWebView(this.url);

  @override
  State<_OAuthWebView> createState() => _OAuthWebViewState();
}

class _OAuthWebViewState extends State<_OAuthWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (navReq) {
            if (navReq.url.startsWith("oauth://mediaverse.global/redirect")) {
              final uri = Uri.parse(navReq.url);
              final code = uri.queryParameters['code'];
              Navigator.of(context).pop(code);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }
}
