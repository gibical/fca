import 'dart:convert';
import 'dart:developer';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:dio/dio.dart' as d;
import 'package:get_storage/get_storage.dart';
import 'package:gibical/app/pages/share_account/widgets/program_bottom_sheet.dart';
import 'package:gibical/gen/model/json/FromJsonGetProfile.dart';
import 'package:gibical/gen/model/json/walletV2/FromJsonGetPrograms.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:gibical/app/common/app_extension.dart';
import 'package:gibical/app/pages/channel/widgets/add_upcoming_card_widget.dart';
import 'package:gibical/app/pages/share_account/widgets/add_upcoming_widget.dart';
import 'package:gibical/gen/model/json/FromJsonGetExternalAccount.dart';
import 'package:sizer/sizer.dart';

import '../../../gen/model/json/FromJsonGetCalender.dart';
import '../../../gen/model/json/FromJsonGetMesseges.dart';
import '../../../gen/model/json/walletV2/FromJsonGetExternalAccount.dart';
import '../../common/RequestInterface.dart';
import '../../common/app_api.dart';
import '../../common/app_color.dart';
import '../../common/app_config.dart';
import '../../common/font_style.dart';
import '../../common/utils/dio_inperactor.dart';
import '../login/widgets/custom_register_button_widget.dart';
import '../signup/widgets/custom_text_field_form_register_widget.dart';
import 'state.dart';

class ShareAccountLogic extends GetxController implements RequestInterface {
  DateTime? selectedDates= DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,);
  DateTime viewMonth= DateTime.now();

  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
  RxBool isLoadingSendMain = false.obs;
  RxBool changeType = false.obs;
  RxBool changeType2 = false.obs;

  RxString typeString = "Archive".obs;
  List<CalenderModel > todayModels = [];

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

  List<CalenderModel>  models = [];
  var selectedAssetName = "".obs;
  String selectedAssetid = "";

  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _streamUrlEditingController = TextEditingController();
  TextEditingController _streamKeyEditingController = TextEditingController();


  TextEditingController addUpcomingTitle = TextEditingController();
  TextEditingController addUpcomingdes = TextEditingController();
  TextEditingController addUpcomingprivacy = TextEditingController(text: "Public");

  ProgramModel? selectedAccoount;
  ExternalModel? selectedShareAccoount;
  var isloading = true.obs;
  var isBottomSheetloading = false.obs;
  List<ProgramModel> list = [];
  List<ExternalModel> externalList = [];
  late ApiRequster apiRequster;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    apiRequster = ApiRequster(this,develperModel: true);
    getExternalAccount();
    getExterNal();
    getShareSchedules();
  }

  getExternalAccount(){
    apiRequster.request("programs", ApiRequster.MHETOD_GET, 1,useToken: true);
  }


  getExterNal(){
    apiRequster.request("external-accounts", ApiRequster.MHETOD_GET, 4,useToken: true);

  }
  getShareCustomAccounts(){
    apiRequster.request("destinations", ApiRequster.MHETOD_GET, 4,useToken: true);

  }
  getShareSchedules(){
    print('ShareAccountLogic.getShareSchedules = ${viewMonth}');
    apiRequster.request("share-schedules?from=${formatDateTime(DateTime(viewMonth.year,viewMonth.month,))}&to=${formatDateTime(DateTime(viewMonth.year,viewMonth.month+1,))}&", ApiRequster.MHETOD_GET, 3,useToken: true);
  }

  @override
  void onError(String content, int reqCode, bodyError) {
    // TODO: implement onError
    try{
      var messege = jsonDecode(bodyError)['message'];
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(messege,
        style: TextStyle(color: AppColor.primaryDarkColor),)));

    }catch(e){

    }
  }

  @override
  void onStartReuqest(int reqCode) {
    // TODO: implement onStartReuqest
  }

  @override
  void onSucces(source, int reqCdoe) {
    // TODO: implement onSucces

    switch(reqCdoe){
      case 1:
        parseJsonFromMainList(source);
        break;
      case 3:
        parseJsonFromSchludes(source);
        break;
      case 4:
        parseJsonFromExternalAccount(source);
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
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn(

      );
      final GoogleSignInAuthentication googleAuth = await googleUser !.authentication;

      String? token = googleAuth.accessToken; // Save the token to send to your backend

  //    debugger();
      print("Google ID Token: $token");
      createChannelRequest([token??"",googleUser.email??""],1);

    } catch (error) {
      print('Error signing in: $error');
    }
  }
  void deleteModel(ProgramModel elementAt) {
    apiRequster.request("external-accounts/${elementAt.id}", ApiRequster.MHETOD_DELETE, 1,useToken: true);
  }
  void deleteShareModel(ExternalModel elementAt) {
    apiRequster.request("external-accounts/${elementAt.id}", ApiRequster.MHETOD_DELETE, 1,useToken: true);
  }

  void createChannelRequest(dynamic s, int i) async{
    isloading(true);

    var dio = Dio();
    var body ;
    switch(i){
      case 1:
        body = {
          "type": 1,
          "title": s[1],
          "access_token": s[0]
        };
        break;
      case 4:
        body = {
          "type": 4,
          "title": _emailEditingController.text,
          "stream_url": _streamUrlEditingController.text,
          "stream_key": _streamKeyEditingController.text
        };
        break;
      default:
        body = {
          "type": 1,
          "title": s[1],
          "access_token": s[0]
        };
        break;
    }

    print('ShareAccountLogic.sendIDTokenToServer = ${body}');
    dio.interceptors.add(MediaVerseConvertInterceptor());

    try {
      var response = await dio.post(
        '${Constant.HTTP_HOST}external-accounts',
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'X-App': '_Android',
          },
        ),

      );

      if (response.statusCode! >= 200||response.statusCode! < 300) {
        print('==================================================================================================');
        print('External Account Create successfully = ${response.data}');
        print('==================================================================================================');


        getExternalAccount();



      } else {
        isloading(false);

        print('Failed to upload file: ${response.statusMessage}');
      }
    } on DioError catch (e) {
      isloading(false);

      print('DioError: ${e.message}');
    }
    _streamKeyEditingController.clear();
    _streamUrlEditingController.clear();
    _emailEditingController.clear();


  }

  void showAddProgramBottomSheet() {
    Get.bottomSheet(ProgramBottomSheet(this));
  }
  void showAccountType() {
    Get.bottomSheet(Container(
      width: 100.w,
      padding: EdgeInsets.all(4.w
      ),
      height: 25.h,
      decoration: BoxDecoration(
          color: "3b3a5a".toColor(),
          border: Border(
            left: BorderSide(
                color: Colors.grey.withOpacity(0.3),
                width: 1),
            bottom: BorderSide(
                color: Colors.grey.withOpacity(0.3),
                width: 0.4),
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("share_16".tr,style: TextStyle(
              color: Colors.white,fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 3.h,),
          Container(
            width: 100.w,
            height: 6.h,
            decoration: BoxDecoration(
                color: "2f2f3b".toColor(),
                borderRadius: BorderRadius.circular(10)
            ),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)

              ),
              padding: EdgeInsets.zero,
              onPressed: (){
                signInWithGoogle();
              },
              child: Center(
                child: Text("share_17".tr,style: TextStyle(
                    color: Colors.white,fontWeight: FontWeight.bold
                ),),
              ),
            ),
          ),
          SizedBox(height: 1.5.h,),

        ],
      ),
    ));
  }
  void showRTSPform() {
    Get.bottomSheet(Container(
      width: 100.w,

      height: 45.h,
      decoration: BoxDecoration(
          color: "3b3a5a".toColor(),
          border: Border(
            left: BorderSide(
                color: Colors.grey.withOpacity(0.3),
                width: 1),
            bottom: BorderSide(
                color: Colors.grey.withOpacity(0.3),
                width: 0.4),
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(25),
              child: Text("share_19".tr,style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.bold
              ),),
            ),
            CustomTextFieldRegisterWidget(
                context: Get.context!,
                titleText: 'share_21'.tr,
                hintText: 'share_20'.tr,
                textEditingController:_emailEditingController,
                needful: true),
            CustomTextFieldRegisterWidget(
                context: Get.context!,
                titleText: 'share_22'.tr,
                hintText: 'share_23'.tr,
                textEditingController:_streamUrlEditingController,
                needful: true),
            CustomTextFieldRegisterWidget(
                context: Get.context!,
                titleText: 'share_24'.tr,
                hintText: 'share_25'.tr,
                textEditingController:_streamKeyEditingController,
                needful: true),
            Padding(
              padding: const EdgeInsets.only(left: 25 , right: 25),
              child: SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    Get.back();
                    createChannelRequest([], 4);
                  },
                  child: Text(
                      "share_26".tr,
                      style: FontStyleApp.bodyLarge.copyWith(
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.w300,
                      )
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.sp)
                      ),
                      backgroundColor:AppColor.primaryLightColor

                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    ));
  }

  void showAddUpComingBottomSheet(){
    Get.bottomSheet(AddUpComingClassWidget());
  }

  void parseJsonFromMainList(source) {
    log('ShareAccountLogic.parseJsonFromMainList = ${source}');
    list = FromJsonGetPrograms.fromJson(jsonDecode(source)).data??[];
    isloading(false);
  }

  void parseJsonFromSchludes(source) {

 //   debugger();
    models = FromJsonGetCalender.fromJson(jsonDecode(source)).data??[];
    if (selectedDates!=null) {
      todayModels = filterCalenderByDate(models, selectedDates!);
    }
    update();
    print('ShareAccountLogic.parseJsonFromSchludes = ${models.length}');
  }

  void setModelShareData(String string, model) {
    selectedAssetName.value = string;
    selectedAssetid = model.toString();
    update();

  }

  void setSelectedChannel(ProgramModel elementAt) {
    selectedAccoount=elementAt;
    update();
  }
  void setSelectedShareChannel(ExternalModel elementAt) {
    selectedShareAccoount=elementAt;
    update();
  }

  void onSelcetedDate(DateTime calenderDateTime) {
    getShareSchedules();

    if (selectedDates==(calenderDateTime)) {
       selectedDates==null;
    } else {
      selectedDates =calenderDateTime;
    }

    update();
    print('ShareAccountLogic.onSelcetedDate = ${todayModels}');
  }


  void sendMainRequeast()async{
    if(
    selectedAssetid.length==0
    ){
      Constant.showMessege("Please select Asset");
      return;
    }
    if(
    selectedAccoount==null
    ){
      Constant.showMessege("Please select Account");
      return;
    }
    if(
    selectedDates==null
    ){
      Constant.showMessege("Please select Time");
      return;
    }
    if(
    typeString.value =="Share"&&addUpcomingTitle.text.isEmpty
    ){
      Constant.showMessege("Please Input the Title");
      return;
    }
    var body = {
      "file": selectedAssetid,
      "account": selectedAccoount!.id??0,
      "times": [
       formatDateTime(selectedDates!)
      ]
    };
    if(typeString.value=="Share"){
      body['title'] = addUpcomingTitle.text;
      body['description'] = addUpcomingdes.text;
      body['privacy'] = addUpcomingprivacy.text.toLowerCase();
    }
    var url = "";
    switch(typeString.value){
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

    print('ShareAccountLogic.sendMainRequeast =${body}');

    try {
      isLoadingSendMain(true);
      final token = GetStorage().read("token");
      String apiUrl =
          '${Constant.HTTP_HOST}$url';
      print('DetailController._fetchMediaData = ${apiUrl}');
      var s = Dio();
      s.interceptors.add(MediaVerseConvertInterceptor());
        s.interceptors.add(CurlLoggerDioInterceptor());

      var header =  {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      };
      var response = await s.post(apiUrl, options: Options(headers:header),data: body);

      log('DetailController._fetchMediaData11111 = ${response.statusCode}  - ${jsonEncode(response.data)} - ${response.data['media_type']}');
      isLoadingSendMain(false);

      if (response.statusCode! >= 200&&response.statusCode! <300) {
        // externalAccountlist = FromJsonGetExternalAccount.fromJson(response.data??[]).data??[];

        getShareSchedules();
        Get.back();
        Constant.showMessege("Your Upcoming Event Successfully Created");
        update();
      } else {
        // Handle errors
        Get.back();

        Constant.showMessege(" You Have error");

      }
    } catch (e) {
      // Handle errors
      Get.back();

      Constant.showMessege(" You Have error");
      isLoadingSendMain(false);

      print('DetailController._fetchMediaData = $e');
    } finally {
      //isLoading.value = false;
      print('DetailController._fetchMediaData file_id = 3');

    }

  }
  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('y-MM-dd HH:mm:ss'); // Use 'y' for year, 'MM' for zero-padded month, 'dd' for zero-padded day
    return formatter.format(dateTime);
  }

  void sendRequestAddProgram() {
   var body = {
     "source": "publishers",
     "name":"adwdaaswd",
     "details": {

     }
   };
   apiRequster.request("programs", ApiRequster.MHETOD_POST, 500,body: body);
  }

  void parseJsonFromExternalAccount(source) {
    log('ShareAccountLogic.parseJsonFromExternalAccount = ${source}');
    externalList = fromJsonGetExternalAccountFromJson(source).data??[];
    update();
  }
}