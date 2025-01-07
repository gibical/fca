import 'dart:convert';
import 'dart:math';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../flavors.dart';
import '../../../gen/model/json/FromJsonGetLoginV2.dart';
import '../../common/app_config.dart';
import '../../common/app_route.dart';
import '../../common/utils/dio_inperactor.dart';
import 'state.dart';

class AuthLogic extends GetxController {
  final AuthState state = AuthState();
  final String clientId = "${F.oAuthCliendID}";
  final String redirectUri = "oauth://mediaverse.global/redirect";
  final String authUrl = '${F.apiurl.substring(0, F.apiurl.lastIndexOf("/") - 2)}oauth/authorize';
  final String tokenUrl = '${F.apiurl.substring(0, F.apiurl.lastIndexOf("/") - 2)}oauth/token';
  var box = GetStorage();
  String twitterLoginState = "";

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
    state.isloadingOAuth(true);
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
    state.isloadingOAuth(false);
    if (response.statusCode == 200) {
      box.write("islogin", true);
      box.write("token", jsonDecode(response.body)['access_token']);

      Get.offAllNamed(PageRoutes.WRAPPER);
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to exchange code for token');
    }
  }

  Future<void> initiateLogin(BuildContext context) async {
    state.isloadingOAuth(true);
    final codeVerifier = await generateCodeVerifier();
    final codeChallenge = await generateCodeChallenge(codeVerifier);
    await box.write('codeVerifier', codeVerifier);
    final url = generateAuthUrl(codeChallenge);
    state.isloadingOAuth(false);
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

  Future<bool> onGoogleAuthRequest(String s) async {
    try {
      final token = GetStorage().read("token");
      String apiUrl = '${Constant.HTTP_HOST}auth/google';
      var dio = Dio();
      dio.interceptors.add(MediaVerseConvertInterceptor());
      dio.interceptors.add(CurlLoggerDioInterceptor());
      var response = await dio.post(
        apiUrl,
        data: {"access_token": s},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'X-App': '_Android',
            'Accept-Language': 'en-US',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        box.write("islogin", true);
        FromJsonGetLoginV2 getLogin = FromJsonGetLoginV2.fromJson(response.data);
        box.write("token", getLogin.token ?? "");
        box.write("userid", getLogin.user!.id.toString());
        Get.offAllNamed(PageRoutes.WRAPPER);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn(

      );
      final GoogleSignInAuthentication googleAuth = await googleUser!
          .authentication;

      String? token = googleAuth
          .accessToken; // Save the token to send to your backend

      print("Google ID Token: $token");
      onGoogleAuthRequest(token ?? "");
    } catch (error) {
      print('Error signing in: $error');
    }
  }

  void _googleLogIn() async {
    signInWithGoogle();
    // oAuthFunction();
  }

  void getTwitterLogin() async {
    state.isloadingX(true);
    try {
      final token = GetStorage().read("token");
      String apiUrl = '${Constant.HTTP_HOST}auth/x/url';
      var dio = Dio();
      dio.interceptors.add(MediaVerseConvertInterceptor());
      dio.interceptors.add(CurlLoggerDioInterceptor());
      var response = await dio.get(
        apiUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'X-App': '_Android',
            'Accept-Language': 'en-US',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        peaseJsonFromGetTwitterAuth(response.data);
      }
    } catch (e) {}
    state.isloadingX(false);
  }

  void peaseJsonFromGetTwitterAuth(source) async {
    twitterLoginState = source['state'];
    await launchUrlString(source['url']);
  }
  void getTwitterAccessToken() async {

    try {
      final token = GetStorage().read("token");
      String apiUrl = '${Constant.HTTP_HOST}auth/x';
      var dio = Dio();
      dio.interceptors.add(MediaVerseConvertInterceptor());
      dio.interceptors.add(CurlLoggerDioInterceptor());
      var response = await dio.post(
        apiUrl,
        data: {"state": twitterLoginState},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'X-App': '_Android',
            'Accept-Language': 'en-US',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        box.write("islogin", true);
        FromJsonGetLoginV2 getLogin = FromJsonGetLoginV2.fromJson(response.data);
        box.write("token", getLogin.token ?? "");
        box.write("userid", getLogin.user!.id.toString());
        Get.offAllNamed(PageRoutes.WRAPPER);
      }
    } catch (e) {}
    state.isloadingX(false);
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
