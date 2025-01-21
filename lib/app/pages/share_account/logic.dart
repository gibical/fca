import 'dart:convert';
import 'dart:developer';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import 'package:dio/dio.dart' as d;
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/pages/share_account/widgets/program_bottom_sheet.dart';
import 'package:mediaverse/app/pages/share_account/widgets/share_account_bottom_sheet.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetProfile.dart';
import 'package:mediaverse/gen/model/json/walletV2/FromJsonGetPrograms.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/channel/widgets/add_upcoming_card_widget.dart';
import 'package:mediaverse/app/pages/share_account/widgets/add_upcoming_widget.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetExternalAccount.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../gen/model/json/FromJsonGetAllChannels.dart';
import '../../../gen/model/json/FromJsonGetCalender.dart';
import '../../../gen/model/json/FromJsonGetChannels.dart';
import '../../../gen/model/json/FromJsonGetChannelsShow.dart';
import '../../../gen/model/json/FromJsonGetMesseges.dart';
import '../../../gen/model/json/FromJsonGetNewCountries.dart';
import '../../../gen/model/json/walletV2/FromJsonGetDestination.dart';
import '../../../gen/model/json/walletV2/FromJsonGetExternalAccount.dart';
import '../../common/RequestInterface.dart';
import '../../common/app_api.dart';
import '../../common/app_color.dart';
import '../../common/app_config.dart';
import '../../common/font_style.dart';
import '../../common/utils/dio_inperactor.dart';
import '../home/logic.dart';
import '../login/widgets/custom_register_button_widget.dart';
import '../signup/widgets/custom_text_field_form_register_widget.dart';
import 'state.dart';

class ShareAccountLogic extends GetxController implements RequestInterface {
  DateTime? selectedDates = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime viewMonth = DateTime.now();

  final _obj = ''.obs;
  List<CountryModel> countreisModel = [];
  List<String> countreisString = [];
  CountryModel? countryModel;
  String? languageModel;
  set obj(value) => _obj.value = value;

  get obj => _obj.value;
  RxBool isLoadingSendMain = false.obs;
  RxBool changeType = false.obs;
  RxBool changeType2 = false.obs;

  RxString typeString = "Archive".obs;
  List<CalenderModel> todayModels = [];
  SelectShareMode? selectShareMode;

  String selectShareModelName = "";
  String selectShareModeid = "";
  List<CalenderModel> filterCalenderByDate(List<CalenderModel> calendarList, DateTime targetDate) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    return calendarList.where((calenderModel) {
      if (calenderModel.time != null) {
        DateTime modelDateTime = DateTime.parse(calenderModel.time!);
        return dateFormat.format(modelDateTime) == dateFormat.format(targetDate);
      }
      return false;
    }).toList();
  }

  List<CalenderModel> models = [];
  var selectedAssetName = "".obs;
  String selectedAssetid = "";

  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _streamUrlEditingController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController _streamKeyEditingController = TextEditingController();

  TextEditingController addUpcomingTitle = TextEditingController();
  TextEditingController addUpcomingdes = TextEditingController();
  TextEditingController addUpcomingprivacy = TextEditingController(text: "Public");

  Programs? selectedAccoount;
  ExternalModel? selectedShareAccoount;
  Destinations? selectedDestinationAccoount;
  var isloading = true.obs;
  var isloadingTwitterApp = false.obs;
  var iscreateShareAccountloading = false.obs;
  var iscreateProgramloading = false.obs;
  var isBottomSheetloading = false.obs;
  List<ChannelsModel> channelModels = [];
  List<ExternalModel> externalList = [];
  List<Destinations> destinationModelList = [];
  late ApiRequster apiRequster;

  List<Destinations> destintionList = [];

  @override
  void onReady() {
    super.onReady();
    apiRequster = ApiRequster(this, develperModel: false);
    getExternalAccount();
    getExterNal();
    getAllCountries();
    getAllLanguages();
    getShareCustomAccounts();
  }

  Future<void> getAllCountries() async {
    var dio = Dio();
    dio.interceptors.add(MediaVerseConvertInterceptor());

    try {
      var response = await dio.get(
        '${Constant.HTTP_HOST}countries',
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'X-App': '_Android',
          },
        ),
      );

      if (response.statusCode! >= 200 || response.statusCode! < 300) {
        (response.data['data'] as List<dynamic>).forEach((element) {
          countreisModel.add(CountryModel.fromJson(element));
        });
        (countreisModel).forEach((element) {
          countreisString.add(element.title ?? "");
        });
        update();
      }
    } on DioError catch (e) {}
  }

  Future<void> getAllLanguages() async {
    var dio = Dio();
    dio.interceptors.add(MediaVerseConvertInterceptor());

    try {
      var response = await dio.get(
        '${Constant.HTTP_HOST}languages',
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'X-App': '_Android',
          },
        ),
      );

      if (response.statusCode! >= 200 || response.statusCode! < 300) {
        Constant.reversedLanguageMap = response.data;
        update();
      }
    } on DioError catch (e) {}
  }

  getExternalAccount() {
    apiRequster.request("profile/channels", ApiRequster.MHETOD_GET, 1, useToken: true);
  }

  getExterNal() {
    apiRequster.request("external-accounts", ApiRequster.MHETOD_GET, 4, useToken: true);
  }

  getShareCustomAccounts() {
    apiRequster.request("destinations", ApiRequster.MHETOD_GET, 5, useToken: true);
  }

  getShareSchedules() {
    apiRequster.request(
        "share-schedules?from=${formatDateTime(DateTime(viewMonth.year, viewMonth.month,))}&to=${formatDateTime(DateTime(viewMonth.year, viewMonth.month + 1,))}&",
        ApiRequster.MHETOD_GET, 3,
        useToken: true);
  }

  @override
  void onError(String content, int reqCode, bodyError) {
    if (reqCode == 500 || reqCode == 501) {
      iscreateProgramloading(false);
      Get.back();
    }

    try {
      var messege = jsonDecode(bodyError)['message'];
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text(
          messege,
          style: TextStyle(color: AppColor.primaryDarkColor),
        ),
      ));
    } catch (e) {}
  }

  @override
  void onStartReuqest(int reqCode) {}

  @override
  void onSucces(source, int reqCdoe) {
    switch (reqCdoe) {
      case 1:
        parseJsonFromMainList(source);
        break;
      case 3:
        parseJsonFromSchludes(source);
        break;
      case 4:
        parseJsonFromExternalAccount(source);
        break;
      case 5:
        parseJsonFromShareCustomAccounts(source);
        break;
      case 500:
        parseJsonFromCreateProgram(source);
        break;
      case 501:
        praseJsonFromAddDestination(source);
        break;
      case 503:
        praseJsonFromDeleteProgram(source);
        break;
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/drive',
      'https://www.googleapis.com/auth/youtube',
    ],
  );

  Future<void> signInWithGoogle() async {
    Get.back();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      String? token = googleAuth.accessToken;

      createChannelRequest([token ?? "", googleUser.email ?? ""], 1);
    } catch (error) {}
  }

  void deleteModel(Programs elementAt) {
    apiRequster.request("external-accounts/${elementAt.id}", ApiRequster.MHETOD_DELETE, 1, useToken: true);
  }

  void deleteShareModel(ExternalModel elementAt) {
    apiRequster.request("external-accounts/${elementAt.id}", ApiRequster.MHETOD_DELETE, 1, useToken: true);
  }

  void deleteDestinationModel(Destinations elementAt) {
    apiRequster.request("destinations/${elementAt.id}", ApiRequster.MHETOD_DELETE, 1, useToken: true);
  }

  void createChannelRequest(dynamic s, int i) async {
    iscreateShareAccountloading(true);

    var dio = Dio();
    var body;
    switch (i) {
      case 1:
        body = {"type": "google", "title": s[1], "access_token": s[0]};
        break;
      case 2:
        body = {"type": "x", "title": s[1], "access_token": s[0]};
        break;
      case 4:
        body = {
          "name": _nameEditingController.text,
          "type": "rtmp",
          "details": {"link": "${_streamUrlEditingController.text}/${_streamKeyEditingController.text}"}
        };
        break;
      default:
        body = {"type": 1, "title": s[1], "access_token": s[0]};
        break;
    }

    dio.interceptors.add(MediaVerseConvertInterceptor());
    dio.interceptors.add(CurlLoggerDioInterceptor());

    try {
      var response = await dio.post(
        '${Constant.HTTP_HOST}${(i == 1 || i == 2) ? "external-accounts" : "destinations"}',
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'X-App': '_Android',
          },
        ),
      );

      if (response.statusCode! >= 200 || response.statusCode! < 300) {
        if (i == 2) {
          isloadingTwitterApp(false);
          iscreateShareAccountloading(false);
          await launchUrlString(response.data['url']);
          getExterNal();
          getShareCustomAccounts();
        } else {
          iscreateShareAccountloading(false);

          getExterNal();
          getShareCustomAccounts();
        }
      } else {
        isloading(false);
      }
    } on DioError catch (e) {
      iscreateShareAccountloading(false);
    }
    _streamKeyEditingController.clear();
    _streamUrlEditingController.clear();
    _nameEditingController.clear();
  }

  void showAddProgramBottomSheet() {
    Get.toNamed(PageRoutes.ADDCHANNEL);
  }

  void showAccountType() async {
    await Get.bottomSheet(ShareAccountBottomSheet(this));
    getExterNal();
    getShareCustomAccounts();
  }

  void showRTSPform() {
    Get.bottomSheet(Container(
      width: 100.w,
      height: 45.h,
      decoration: BoxDecoration(
          color: AppColor.primaryLightColor,
          border: Border(
            left: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
            bottom: BorderSide(color: Colors.grey.withOpacity(0.3), width: 0.4),
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(25),
              child: Text(
                "share_19".tr,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            CustomTextFieldRegisterWidget(
                context: Get.context!,
                titleText: 'share_21'.tr,
                hintText: 'share_20'.tr,
                textEditingController: _nameEditingController,
                needful: true),
            CustomTextFieldRegisterWidget(
                context: Get.context!,
                titleText: 'share_22'.tr,
                hintText: 'share_23'.tr,
                textEditingController: _streamUrlEditingController,
                needful: true),
            CustomTextFieldRegisterWidget(
                context: Get.context!,
                titleText: 'share_24'.tr,
                hintText: 'share_25'.tr,
                textEditingController: _streamKeyEditingController,
                needful: true),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    createChannelRequest([], 4);
                  },
                  child: Obx(() {
                    return iscreateShareAccountloading.value
                        ? Lottie.asset("assets/${F.assetTitle}/json/Y8IBRQ38bK.json", height: 5.h)
                        : Text("share_26".tr,
                        style: FontStyleApp.bodyLarge.copyWith(
                          color: AppColor.whiteColor,
                          fontWeight: FontWeight.w300,
                        ));
                  }),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.sp)),
                      backgroundColor: AppColor.primaryLightColor),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void showAddUpComingBottomSheet() {
    Get.bottomSheet(AddUpComingClassWidget());
  }

  void parseJsonFromMainList(source) {
    channelModels = FromJsonGetAllChannels.fromJson(jsonDecode(source)).data ?? [];
    update();
    isloading(false);
  }

  void parseJsonFromSchludes(source) {
    models = FromJsonGetCalender.fromJson(jsonDecode(source)).data ?? [];
    if (selectedDates != null) {
      todayModels = filterCalenderByDate(models, selectedDates!);
    }
    update();
  }

  void setModelShareData(String string, model) {
    selectedAssetName.value = string;
    selectedAssetid = model.toString();
    update();
  }

  void setSelectedChannel(Programs elementAt) {
    selectedAccoount = elementAt;
    update();
  }

  void setSelectedShareChannel(ExternalModel elementAt) {
    selectedShareAccoount = elementAt;
    update();
  }

  void setSelectedDestiniation(Destinations elementAt) {
    if (getactiveDestinationModel(elementAt)) {
      destintionList.remove(elementAt);
    } else {
      destintionList.add(elementAt);
    }
    update();
  }

  bool getactiveDestinationModel(Destinations model) {
    return destintionList.toList().firstWhereOrNull((test) => test.id.toString().contains(model.id.toString())) != null;
  }
  bool getactiveDestinationModelFromList(List<Destinations> destintionLists,Destinations model) {
    return destintionLists.toList().firstWhereOrNull((test) => test.id.toString().contains(model.id.toString())) != null;
  }

  void onSelcetedDate(DateTime calenderDateTime) {
    getShareSchedules();

    if (selectedDates == (calenderDateTime)) {
      selectedDates == null;
    } else {
      selectedDates = calenderDateTime;
    }

    update();
  }

  void sendMainRequeast() async {
    if (selectedAssetid.length == 0) {
      Constant.showMessege("alert_5".tr);
      return;
    }
    if (selectedAccoount == null) {
      Constant.showMessege("alert_6".tr);
      return;
    }
    if (selectedDates == null) {
      Constant.showMessege("alert_7".tr);
      return;
    }
    if (typeString.value == "Share" && addUpcomingTitle.text.isEmpty) {
      Constant.showMessege("alert_8".tr);
      return;
    }
    var body = {
      "file": selectedAssetid,
      "account": selectedAccoount!.id ?? 0,
      "times": [formatDateTime(selectedDates!)]
    };
    if (typeString.value == "Share") {
      body['title'] = addUpcomingTitle.text;
      body['description'] = addUpcomingdes.text;
      body['privacy'] = addUpcomingprivacy.text.toLowerCase();
    }
    var url = "";
    switch (typeString.value) {
      case "Archive":
        url = "shares/google-drive";
        break;
      case "Share":
        url = "";
        break;
      case "Stream":
        url = "shares/stream";
        break;
    }

    try {
      isLoadingSendMain(true);
      final token = GetStorage().read("token");
      String apiUrl = '${Constant.HTTP_HOST}$url';
      var s = Dio();
      s.interceptors.add(MediaVerseConvertInterceptor());
      s.interceptors.add(CurlLoggerDioInterceptor());

      var header = {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      };
      var response = await s.post(apiUrl, options: Options(headers: header), data: body);

      isLoadingSendMain(false);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        getShareSchedules();
        Get.back();
        Constant.showMessege("alert_9".tr);
        update();
      } else {
        Get.back();

        Constant.showMessege(" alert_10".tr);
      }
    } catch (e) {
      Get.back();

      Constant.showMessege("alert_10".tr);
      isLoadingSendMain(false);
    }
  }

  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('y-MM-dd HH:mm:ss');
    return formatter.format(dateTime);
  }

  void sendRequestAddProgram(String name, bool isPrivate, bool isRecordable, bool isEdit, String id) {
    if (countryModel != null && languageModel != null) {
      iscreateProgramloading(true);
      Map<String, dynamic> body = {
        "name": name,
        "country_iso": countryModel!.iso,
        "language": languageModel!,
        "is_private": isPrivate ? 1 : 0,
        "is_recordable": isRecordable ? 1 : 0
      };

      var url = "channels";
      if (isEdit) {
        url += "/${id}";
      }
      apiRequster.request(url, isEdit ? ApiRequster.MHETOD_PUT : ApiRequster.MHETOD_POST, 500, body: body, useToken: true);
    } else {
      Get.back();
      Constant.showMessege("alert_11".tr);
    }
  }

  void parseJsonFromExternalAccount(source) {
    externalList = fromJsonGetExternalAccountFromJson(source).data ?? [];

    isloading(false);
    update();
  }

  void parseJsonFromShareCustomAccounts(source) {
    destinationModelList.clear();
    for (var action in (jsonDecode(source)['data'] as List)) {
      destinationModelList.add(Destinations.fromJson(action));
    }

    update();
  }

  void parseJsonFromCreateProgram(source) async {
    iscreateProgramloading(false);
    Get.back();
    isloading(true);
    getExternalAccount();
  }

  Future<bool> onAddDestinationToProgramRequest(prgoramID, destinationID, bool isLast) async {
    try {
      final token = GetStorage().read("token");
      String apiUrl = '${Constant.HTTP_HOST}programs/${prgoramID}/destinations/${destinationID}';

      var dio = Dio();

      dio.interceptors.add(MediaVerseConvertInterceptor());
      dio.interceptors.add(CurlLoggerDioInterceptor());

      var response = await dio.post(
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

      if (isLast) {
        iscreateProgramloading(false);
        Get.back();
        isloading(true);
        getExternalAccount();
      }
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  void onAddDestinationToProgram(id) {
    apiRequster.request("", ApiRequster.MHETOD_POST, 501);
  }

  void praseJsonFromAddDestination(source) {
    iscreateProgramloading(false);
    Get.back();
    isloading(true);
    getExternalAccount();
  }

  void deleteProgram(String? id) {
    apiRequster.request("channels/${id}", ApiRequster.MHETOD_DELETE, 503);
    Get.back();
    isloading(true);
    Future.delayed(Duration(seconds: 1)).then((s) {
      getExternalAccount();
    });
  }

  void praseJsonFromDeleteProgram(source) {
    iscreateProgramloading(false);
    Get.back();
    isloading(true);
    getExternalAccount();
  }

  void getTwitterAuth() async {
    isloadingTwitterApp(true);
    createChannelRequest("twitter", 2);
  }
}

enum SelectShareMode { stream, share }