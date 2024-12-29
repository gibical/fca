import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/pages/detail/widgets/text_to_text.dart';
import 'package:mediaverse/app/pages/detail/widgets/youtube_bottomsheet.dart';
import 'package:mediaverse/app/pages/wallet/view.dart';
import 'package:mediaverse/app/pages/wrapper/logic.dart';
import 'package:mediaverse/gen/model/enums/post_type_enum.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../gen/model/json/FromJsonGetExternalAccount.dart';
import '../../common/app_color.dart';
import '../../common/app_config.dart';
import '../../common/utils/dio_inperactor.dart';
import '../../common/utils/duraton_music_helper.dart';
import '../plus_section/logic.dart';
import '../plus_section/widget/first_form.dart';

class DetailController extends GetxController {
  //==================================== get Detail page =======================================//
  RxMap<String, dynamic>? videoDetails = RxMap<String, dynamic>();
  RxMap<String, dynamic>? imageDetails = RxMap<String, dynamic>();
  RxMap<String, dynamic>? musicDetails = RxMap<String, dynamic>();
  RxMap<String, dynamic>? textDetails = RxMap<String, dynamic>();
  RxMap<String, dynamic>? detailss = RxMap<String, dynamic>();
  ScreenshotController screenshotController = ScreenshotController();
  List<ExternalAccountModel> externalAccountlist = [];

  int index ;
  int enableChannel = 0 ;

  DetailController(this.index);

  var asset_id  ="";
  var file_id  ="";
  //==================================== loading Detail page =======================================//
  RxBool isLoadingVideos = false.obs;
  RxBool isLoadingImages = false.obs;
  RxBool isLoadingMusic = false.obs;
  RxBool isLoadingText = false.obs;
  RxBool isLoadingChannel = true.obs;


  String id = Get.arguments['id'].toString();
  //String fileId = Get.arguments['file_id'].toString();
  String fileIdMusic = Get.arguments['file_id_music'].toString();

  //==================================== for youtube share =======================================//
  bool isSeletedNow = true;
  bool isSeletedDate = false;
  DateTime dateTime = DateTime.now();
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController desEditingController = TextEditingController();
  TextEditingController prefixEditingController = TextEditingController();
  TextEditingController reportEditingController = TextEditingController();
  RxBool isPrivateContent= true.obs;


  var isEditAvaiblae = false.obs;



  @override
  void onInit() {
    super.onInit();
    print('DetailController.onInit');
    isLoadingMusic.value = true;
    isLoadingImages.value = true;
    isLoadingVideos.value = true;
    isLoadingText.value = true;


    initFunction();

  }


  initFunction(){

    switch (index) {
      case 1:
        fetchTextData();
      case 2:
        fetchImageData();
      case 3:
        fetchMusicData();
      case 4:
        fetchVideoData();

      default:
        return '';
    }





  }
  //==================================== fetch data Detail page =======================================//
  void fetchVideoData() async {
    print('DetailController.onInit 1 ');

    await _fetchMediaData('videos', videoDetails, isLoadingVideos);
  }

  void fetchImageData() async {
    print('DetailController.onInit 2 ');

    await _fetchMediaData('images', imageDetails, isLoadingImages);
  }

  void fetchMusicData() async {
    await _fetchMediaData('audios', musicDetails, isLoadingMusic);
  }

  void fetchTextData() async {

    await _fetchMediaData('texts', textDetails, isLoadingText);
  }









  Future<void> _fetchMediaData(

      String type, RxMap<String, dynamic>? details, RxBool isLoading) async {
    try {

      final token = GetStorage().read("token");
      String apiUrl =
          '${Constant.HTTP_HOST}$type/${Get.arguments['id']}';
      print('DetailController._fetchMediaData = ${apiUrl}');
      var response = await Dio().get(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      }));

     log('DetailController._fetchMediaData11111 = ${response.statusCode}  - ${jsonEncode(response.data)} - ${response.data['media_type']}');
      if (response.statusCode == 200) {
        details?.value = RxMap<String, dynamic>.from(response.data['data']);
        detailss = RxMap<String, dynamic>.from(response.data['data']);
        asset_id= response.data['data']['asset_id'].toString();
        file_id =response.data['data']['file_id'].toString();
        if(index==3){
        fileIdMusic =response.data['data']['file_id'].toString();

        }
        print('DetailController._fetchMediaData file_id = 1  = ${file_id}= ${!file_id.toString().contains("null")}');
        isEditAvaiblae= response.data['data']['user_id'].toString().contains(Get.find<WrapperController>().userid.toString()).obs;
        print('DetailController._fetchMediaData file_id = 2');


      } else {
        // Handle errors
      }
    } catch (e) {
      // Handle errors
      print('DetailController._fetchMediaData = $e');
    } finally {
      isLoading.value = false;
      print('DetailController._fetchMediaData file_id = 3');

    }
  }




  String getTypeString(int type) {
    switch (type) {
      case 1:
        return 'Text';
      case 2:
        return 'Image';
      case 3:
        return 'Audio';
      case 4:
        return 'Video';

      default:
        return '';
    }
  }













  //==================================== play Music Detail page =======================================//
  final player = AudioPlayer();
  bool isPlaying = false;
  playSong(dynamic musicUrl) async {
    await player.setUrl(musicUrl);
    player.play();
    player.positionStream.listen((event) {
      Duration temp = event as Duration;
      DurationMusic.position = temp;
      update();
    });

    if (player.duration != null) {
      DurationMusic.duration = player.duration!;
    }
  }

  void toggleMusic(musicUrl) {
    if (isPlaying) {
      player.pause();
    } else {
      playSong(musicUrl);

    }
    isPlaying = !isPlaying;
    update();
  }

  sliderMetode(value)  {
    final seekPosition = Duration(seconds: value.toInt());
    player.seek(seekPosition);
  }

  
  
  
  
//==================================== get comment Detail page =======================================//
  var isLoadingComment = true.obs;
  RxMap<String, dynamic>? commentsData = RxMap<String, dynamic>();
  Future<void> fetchMediaComments() async {
    try {
      final token = GetStorage().read("token");
      isLoadingComment.value = true;
      String apiUrl = '${Constant.HTTP_HOST}assets/${Get.arguments['id']}/comments';

      var response = await Dio().get(
        apiUrl,
        options: Options(
          headers: {
            'accept': 'application/json',
            'X-App': '_Android',
            'Accept-Language': 'en-US',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        commentsData?.value = RxMap<String, dynamic>.from(response.data);
        print(response.data);
      } else {
        // Handle errors
      }
    } catch (e) {
      // Handle errors
    } finally {
      isLoadingComment.value = false;
    }
  }







//==================================== post comment Detail page =======================================//
  final TextEditingController commentTextController = TextEditingController();

  void postComment() async {
    try {
      final token = GetStorage().read("token");
      String apiUrl = '${Constant.HTTP_HOST}assets/comments';
      var response = await Dio().post(
        apiUrl,
        data: {
          "asset_id": Get.arguments['id'],
          "body": commentTextController.text
        },
        options: Options(
          headers: {
            'accept': 'application/json',
            'X-App': '_Android',
            'Accept-Language': 'en-US',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
      } else {

      }
    } catch (e) {

      print("$e");

    }
  }


//==================================== buy asset Detail page =======================================//

  void buyAsset(int assetId) async {
    try {
      final token = GetStorage().read("token");
      String apiUrl = '${Constant.HTTP_HOST}assets/$assetId/buy';

      var dio = Dio();


      var response = await dio.patch(
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

      if (response.statusCode == 204) {

        print('Asset purchased successfully.');
      } else {

        print('Failed to purchase the asset.');
      }
    } catch (e) {

      print('Error: $e');

    }
  }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    player.stop();

  }



  //=========================================== Sound Convert ===========================================//
  void soundTranslate() async{

  //  String language =await _runCustomSelectBottomSheet(Constant.languages, "Select Language");
   // String loclae = Constant.languageMap[language]??"";
    try {
      final token = GetStorage().read("token");

      String apiUrl =
          '${Constant.HTTP_HOST}tasks/audio-translate-text';
      var s = Dio();
      s.interceptors.add(MediaVerseConvertInterceptor());

      print('DetailController.soundTranslate = ${fileIdMusic}');
      var response = await s.post(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      }),data: {
        "file":fileIdMusic
      });

      print('DetailController._fetchMediaData = ${response.statusCode}  - ${response.data}');
      if (response.statusCode == 200) {


        Constant.showMessege("alert_1".tr);
        print(response.data);
      } else {
        // Handle errors
       // Constant.showMessege("Request Denied : ${response.data['status']}");

      }
    } catch (e) {
      // Handle errors
   //   Constant.showMessege("Request Denied : ${e.toString()}");

      print('DetailController._fetchMediaData = $e');
    } finally {

    }
  }
  void soundConvertToText() async{
    try {
      final token = GetStorage().read("token");

      String apiUrl =
          '${Constant.HTTP_HOST}jobs/audio-text';
      var s = Dio();
      s.interceptors.add(MediaVerseConvertInterceptor());
      s.interceptors.add(CurlLoggerDioInterceptor());

      print('DetailController.soundConvertToText = ${fileIdMusic}');
      var response = await s.post(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      }),data: {
        "file":fileIdMusic
      });

      print('DetailController.soundConvertToText');

      if (response.statusCode == 200) {


        Constant.showMessege("alert_1".tr);
        print(response.data);
      } else {
        // Handle errors
       // Constant.showMessege("Request Denied : ${response.data['status']}");

      }
    } catch (e) {
      // Handle errors
     // Constant.showMessege("Request Denied : ${e.toString()}");

      print('DetailController._fetchMediaData = $e');
    } finally {

    }
  }
  //=========================================== Sound Convert ===========================================//






  //=========================================== Share Youtube Logic ===========================================//
  void sendShareYouTube() {
    Get.bottomSheet(YoutubeShareBottomSheet(this,true),backgroundColor: AppColor.primaryDarkColor);
  }
  //=========================================== Share Youtube Logic ===========================================//


  //=========================================== ScreenShot(Video To Image) Logic ===========================================//
  int secondsTimeVideoToImage = 0;
  void videoConvertToImage() async{

    final token = GetStorage().read("token");

    try {

      String apiUrl =
          '${Constant.HTTP_HOST}tasks/video-image';
      var response = await Dio().post(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      }),data: {
        "file": file_id,
        "second":secondsTimeVideoToImage
      });

      if (response.statusCode == 200) {


        Constant.showMessege("alert_1".tr);

        print(response.data);
      } else {
        // Handle errors
        Constant.showMessege("Request Denied  ");

      }
    } catch (e) {
      // Handle errors
      Constant.showMessege("Request Denied : ${e.toString()}");

      print('DetailController._fetchMediaData = $e');
    } finally {

    }
  }


  void videoConvertToAudio() async{

    print(file_id);
    try {
      final token = GetStorage().read("token");

      String apiUrl =
          '${Constant.HTTP_HOST}tasks/video-audio';
      var response = await Dio().post(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      }),data: {
        "file": file_id
      });

      if (response.statusCode == 200) {


        Constant.showMessege("alert_1".tr);

        print(response.data);
      } else {
        // Handle errors
        Constant.showMessege("Request Denied : ${response.data['status']}");

      }
    } catch (e) {
      // Handle errors
      Constant.showMessege("Request Denied : ${e.toString()}");

      print('DetailController._fetchMediaData = $e');
    } finally {

    }
  }



  //=========================================== Text Convert ===========================================//
  void textToImage() async{
    print('DetailController.textToImage = ${{
      "file": file_id,
      "asset_id": asset_id,
      "size": "1024x1024"

    }}');
    try {
      final token = GetStorage().read("token");

      String apiUrl =
          '${Constant.HTTP_HOST}tasks/text-image';
      var s = Dio();
      s.interceptors.add(MediaVerseConvertInterceptor());
      var response = await s. post(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      },),data: {
        "file": file_id,
        "size": "1024x1024"

      },);

      print('DetailController._fetchMediaData = ${response.statusCode}  - ${response.data}');
      if (response.statusCode == 200) {


        Constant.showMessege("alert_1".tr);

      } else {
        // Handle errors
       // Constant.showMessege("Request Denied : ${response.data['status']}");

      }
    } catch ( e) {
      // Handle errors
     // Constant.showMessege("Request Denied : ${e.toString()}");

      print('DetailController._fetchMediaData = $e');
    } finally {

    }
  }

  void textToAudio() async{

    String language =await _runCustomSelectBottomSheet(Constant.languages, "Select Language");
    String loclae = Constant.languageMap[language]??"";
    try {
      final token = GetStorage().read("token");

      String apiUrl =
          '${Constant.HTTP_HOST}tasks/text-audio';
      var s = Dio();
      s.interceptors.add(MediaVerseConvertInterceptor());
      var response = await s. post(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      },),data: {
        "file": file_id,
        "language": loclae

      },);

      print('DetailController._fetchMediaData = ${response.statusCode}  - ${response.data}');
      if (response.statusCode == 200) {


        Constant.showMessege("alert_1".tr);

      } else {
        // Handle errors
        //Constant.showMessege("Request Denied : ${response.data['status']}");

      }
    } catch ( e) {
      // Handle errors
      // Constant.showMessege("Request Denied : ${e.toString()}");

      print('DetailController._fetchMediaData = $e');
    } finally {

    }
  }
  void videoDubbing() async{

    String language =await _runCustomSelectBottomSheet(Constant.languages, "Select Language");
    String loclae = Constant.languageMap[language]??"";
    try {
      final token = GetStorage().read("token");

      String apiUrl =
          '${Constant.HTTP_HOST}tasks/video-dubbing';
      var s = Dio();
      s.interceptors.add(MediaVerseConvertInterceptor());
      var response = await s. post(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      },),data: {
        "file": file_id,
        "language": loclae

      },);

      print('DetailController._fetchMediaData = ${response.statusCode}  - ${response.data}');
      if (response.statusCode == 200) {


        Constant.showMessege("alert_1".tr);

      } else {
        // Handle errors
        //Constant.showMessege("Request Denied : ${response.data['status']}");

      }
    } catch ( e) {
      // Handle errors
      // Constant.showMessege("Request Denied : ${e.toString()}");

      print('DetailController._fetchMediaData = $e');
    } finally {

    }
  }
  void translateText() async{

    String language =await _runCustomSelectBottomSheet(Constant.languages, "Select Language");
    String loclae = Constant.languageMap[language]??"";
    try {
      final token = GetStorage().read("token");

      String apiUrl =
          '${Constant.HTTP_HOST}tasks/text-translate';
      var s = Dio();
      s.interceptors.add(MediaVerseConvertInterceptor());
      var response = await s. post(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      },),data: {
        "file": file_id,
        "language": loclae
      },);


      print('DetailController._fetchMediaData = ${response.statusCode}  - ${response.data}');
      if (response.statusCode == 200) {


        Constant.showMessege("alert_1".tr);
        print(response.data);
      } else {
        // Handle errors
     //   Constant.showMessege("Request Denied : ${response.data['status']}");

      }
    } catch ( e) {
      // Handle errors
     // Constant.showMessege("Request Denied : ${e.toString()}");

      print('DetailController._fetchMediaData = $e');
    } finally {

    }
  }
  void textToText() async{
 var s =   await Get.bottomSheet(TextToTextWidget(this),isScrollControlled: true,backgroundColor: "000033".toColor());

 if(s!=null&&s){

   try {
     final token = GetStorage().read("token");

     String apiUrl =
         '${Constant.HTTP_HOST}tasks/text-text';
     var s = Dio();
     s.interceptors.add(MediaVerseConvertInterceptor());
     print('DetailController.textToText = ${
         {
           "file": file_id,
           "prefix": prefixEditingController.text
         }
     } - ${apiUrl}');

     var response = await s. post(apiUrl, options: Options(headers: {
       'accept': 'application/json',
       'X-App': '_Android',
       'Accept-Language': 'en-US',
       'Authorization': 'Bearer $token',
     },),data: {
       "file": file_id,
       "prefix": prefixEditingController.text
     },);

        print('DetailController._fetchMediaData = ${response.statusCode}  - ${response.data}');
     if (response.statusCode == 200) {


       Constant.showMessege("alert_1".tr);

       print(response.data);
     } else {
       // Handle errors
       //   Constant.showMessege("Request Denied : ${response.data['status']}");

     }
   } catch ( e) {
     // Handle errors
     // Constant.showMessege("Request Denied : ${e.toString()}");

     print('DetailController._fetchMediaData = $e');
   } finally {

   }
 }
 prefixEditingController.clear();
  }
  //=========================================== Text Convert ===========================================//






  Future<String> _runCustomSelectBottomSheet(List<String> models, String title)async {
  var sxz =  await Get.bottomSheet(Container(
      width: 100.w,
      height: 50.h,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
          color: "474755".toColor(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          SizedBox(height: 3.h,),
          Expanded(child: ListView.builder(itemBuilder: (s,p){
            return InkWell(
              onTap: (){
                try {
                 return Get.back(result: models.elementAt(p));

                }  catch (e) {
                  // TODO
                }
                Get.back();
              },
              child: Container(
                width: 100.w,
                height: 4.h,
                margin: EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(models.elementAt(p),style: TextStyle(
                        color: Colors.white.withOpacity(0.4)
                    ),),
                    SizedBox(height: 5,),
                    Container(
                      width: 100.w,
                      height: 1,
                      color: Colors.white.withOpacity(0.15),
                    )
                  ],
                ),
              ),
            );
          },itemCount: models.length,))
        ],
      ),
    ));
   return sxz.toString();
  }




  ///
  void reportPost()async {
    try {
      final token = GetStorage().read("token");

      String apiUrl =
          '${Constant.HTTP_HOST}reports';
      var s = Dio();
      s.interceptors.add(MediaVerseConvertInterceptor());
      print('DetailController._fetchMediaData =${{
        "type": 1,
        "asset_id": asset_id,
        "description": reportEditingController.text
      }} ');
      var response = await s. post(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      },),data: {
      "type": 1,
      "asset_id": asset_id,
      "description": reportEditingController.text
      });

      reportEditingController.clear();
      print(' ${response.statusCode}  - ${response.data}');
      if (response.statusCode == 200||response.statusCode == 201) {


        Constant.showMessege("alert_1".tr);
        print(response.data);
      } else {
        // Handle errors
        //   Constant.showMessege("Request Denied : ${response.data['status']}");

      }
    } catch ( e) {
      // Handle errors
      // Constant.showMessege("Request Denied : ${e.toString()}");

      print('DetailController._fetchMediaData = $e');
    } finally {

    }
  }

  void sendToEditProfile(PostType type)async {

   await Get.toNamed(PageRoutes.EDITPROFILE,arguments: [this,type]);

   initFunction();
  }

  Future<void> fetchChannels(
      ) async {
    try {
      final token = GetStorage().read("token");
      String apiUrl =
          '${Constant.HTTP_HOST}external-accounts';
      print('DetailController._fetchMediaData = ${apiUrl}');
      var response = await Dio().get(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      }));

      log('DetailController._fetchMediaData11111 = ${response.statusCode}  - ${jsonEncode(response.data)} - ${response.data['media_type']}');
      if (response.statusCode! >= 200&&response.statusCode! <300) {
        isLoadingChannel(false);
        externalAccountlist = FromJsonGetExternalAccount.fromJson(response.data??[]).data??[];

        update();
      } else {
        // Handle errors
      }
      log('DetailController._fetchMediaData11111 = ${externalAccountlist.length}');

    } catch (e) {
      isLoadingChannel(false);

      // Handle errors
      print('DetailController._fetchMediaData = $e');
    } finally {
      isLoadingChannel(false);

      //isLoading.value = false;
      print('DetailController._fetchMediaData file_id = 3');

    }
  }

  void onSendShareRequest(String type)async {
    Map<String,dynamic> body = {
      "file_id": file_id,
      "external_account_id": externalAccountlist.elementAt(enableChannel).id.toString(),

    };
    print('DetailController.onSendYouTubeRequest = ${formatDateTime( isSeletedNow?DateTime.now():dateTime)}');
    if(!isSeletedNow){
      body["times"]= [
    formatDateTime( isSeletedNow?DateTime.now():dateTime)
    ];

    }

    if(type=="youtube"){
      body['title'] = titleEditingController.text;
      body['description'] = desEditingController.text;
      body['privacy'] = isPrivateContent.value?"private":"public";

    }
    body['type'] =type;

    var url ="shares";

    try {
      final token = GetStorage().read("token");
      String apiUrl =
          '${Constant.HTTP_HOST}$url';
      var s = Dio();
     // s.interceptors.add(MediaVerseConvertInterceptor());
     s.interceptors.add(CurlLoggerDioInterceptor());

      var header =  {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      };
      var response = await s.post(apiUrl, options: Options(headers:header),data: body);

      log('DetailController._fetchMediaData11111 = ${response.statusCode}  - ${jsonEncode(response.data)} - ${response.data['media_type']}');
      if (response.statusCode! >= 200&&response.statusCode! <300) {
        try {
          if(response.data['data']['details']['error']!=null){
            Constant.showMessege(" ${"alert_10".tr} = ${response.data['data']['details']['error']}");

          }
        }  catch (e) {
          // TODO
          //Constant.showMessege("${youtubeMode?"Send To YouTube":"Archive to Drive"} Sucssefuly");
        }
        Get.back();
        update();
      } else {
        // Handle errors
        Get.back();

        Constant.showMessege("alert_10".tr);

      }
    } on DioException catch (e) {//
      // Handle errors
      Get.back();

      Constant.showMessege("alert_10".tr);

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
}
