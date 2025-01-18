import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:chewie/chewie.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/common/utils/data_state.dart';
import 'package:mediaverse/app/pages/detail/widgets/player/player.dart';
import 'package:mediaverse/app/pages/detail/widgets/text_to_text.dart';
import 'package:mediaverse/app/pages/detail/widgets/youtube_bottomsheet.dart';
import 'package:mediaverse/app/pages/profile/logic.dart';
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
  String selectedAccountTitle = '';
  void selectAccountPublish(int index) {
    enableChannel = index;
    selectedAccountTitle = externalAccountlist[index].title ?? '';
    update();
  }
  bool isExpandedViewBodyText = false;
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
  var isSeletedDate = false.obs;
  var selectedDate = DateTime.now().obs;
  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    update();
  }
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
    fetchMediaComments();
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

    await _fetchMediaData('video', videoDetails, isLoadingVideos);

    initPlayerVideo('${videoDetails!['file']['url']}');
  }

  void fetchImageData() async {
    print('DetailController.onInit 2 ');

    await _fetchMediaData('image', imageDetails, isLoadingImages);
  }

  void fetchMusicData() async {
    await _fetchMediaData('audio', musicDetails, isLoadingMusic);
  }

  void fetchTextData() async {

    await _fetchMediaData('text', textDetails, isLoadingText);
  }








  final token = GetStorage().read("token");

  Future<void> _fetchMediaData(

      String type, RxMap<String, dynamic>? details, RxBool isLoading) async {
    try {

      String apiUrl =
          '${Constant.HTTP_HOST}assets/${Get.arguments['id']}' + '?${type}';
      print('DetailController._fetchMediaData355 = ${apiUrl}');
      var response = await Dio().get(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      }));

      print('object2323');
     log('DetailController._fetchMediaData111115 = ${response.statusCode}  - ${jsonEncode(response.data)} - ${response.data['media_type']}');
      if (response.statusCode == 200) {
        details?.value = RxMap<String, dynamic>.from(response.data['data']);
        detailss = RxMap<String, dynamic>.from(response.data['data']);
        asset_id= response.data['data']['id'].toString();
        file_id =response.data['data']['file_id'].toString();
        if(index==3){
        fileIdMusic =response.data['data']['file_id'].toString();

        }
        print('DetailController._fetchMediaData file_id = 1  = ${ response.data['data']['user_id']} = ${Get.find<WrapperController>().userid.toString()}');
       if(  response.data['data']['is_owned'] == true){
         isEditAvaiblae.value = true;
       }else{
         isEditAvaiblae.value = false;
       }
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


  var isLoadingDeleteAsset = false.obs;

  Future<void> deleteAsset({required  id}) async {
    final String url = '${Constant.HTTP_HOST}assets/${id}';

    try {
      isLoadingDeleteAsset.value = true;

      var response = await Dio().delete(
        url,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {

        Constant.showMessege("Asset deleted successfully");
        Get.back();
        Get.back();
        Get.find<ProfileControllers>().onGetProfileAssets();
      } else {

        Constant.showMessege("Failed to delete asset");


      }
    } catch (e) {


      Constant.showMessege("Error while deleting asset: $e");
    } finally {
      isLoadingDeleteAsset.value = false;
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
    //Get.bottomSheet(YoutubeShareBottomSheet(this,true),backgroundColor: AppColor.primaryDarkColor);
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

    String? language = await runCustomSelectBottomLanguageSheet(models: Constant.languages,);

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
    String? language = await runCustomSelectBottomLanguageSheet(models: Constant.languages,);

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

        if(Get.isBottomSheetOpen == true){
          Get.back();
        }
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

  Future<String?> runCustomSelectBottomLanguageSheet({
    required List<String> models,
    bool isSearchBox = true,
  }) async {
    List<String> filteredModels = List.from(models);
    final TextEditingController searchController = TextEditingController();

    return await Get.bottomSheet<String>(
      elevation: 0,
      StatefulBuilder(
        builder: (context, setState) {
          return Container(
            width: 100.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: "#0F0F26".toColor(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          RotatedBox(
                            quarterTurns: 2,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: SvgPicture.asset('assets/mediaverse/icons/arrow.svg'),
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Select a language',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 24),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      if (isSearchBox)
                        TextField(
                          controller: searchController,
                          onChanged: (query) {
                            setState(() {
                              filteredModels = models
                                  .where((item) => item
                                  .toLowerCase()
                                  .contains(query.toLowerCase()))
                                  .toList();
                            });
                          },
                          style: TextStyle(
                            decorationColor: Colors.transparent,
                            decoration: TextDecoration.none,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Search...',
                            hintStyle: TextStyle(color: '9C9CB8'.toColor()),
                            fillColor: '#17172E'.toColor(),
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                          ),
                        ),
                      SizedBox(height: isSearchBox ? 2.h : 0),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(bottom: 75),
                          itemCount: filteredModels.length,
                          itemBuilder: (context, index) {
                            final item = filteredModels[index];
                            return InkWell(
                              onTap: () {
                                Get.back(result: item);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 3.h,
                                    margin: EdgeInsets.symmetric(vertical: 6),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: '9C9CB8'.toColor(),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          item,
                                          style: TextStyle(
                                            color: '9C9CB8'.toColor(),
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }


  void translateText() async{

    String? language = await runCustomSelectBottomLanguageSheet(models: Constant.languages,);

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


  RxList<String> reportOptions = [
    "Annoying Content",
    "Sexually Explicit Content",
    "Racist Content",
    "Insult to Religion",
    "Insult to Politics",
    "Spread of Violence",
    "Spread of Child Abuse",
    "Bullying",
    "Inappropriate Content for Children",
    "Copyright Infringement  ",
    "Unauthorized Advertising",
    "Animal Abuse",
    "Other",
  ].obs;
  RxInt? selectedReportOption = 0.obs;


  ///

  var loadingReportDataSate = DataState<dynamic>().obs;
  ///
  void reportPost() async {
    try {
      loadingReportDataSate.value = DataState.loading();
      final token = GetStorage().read("token");

      String apiUrl = '${Constant.HTTP_HOST}reports';
      var s = Dio();
      s.interceptors.add(MediaVerseConvertInterceptor());


      String selectedOptionTitle = selectedReportOption != null
          ? reportOptions[selectedReportOption!.value]
          : '';

      String reportDescription =
      selectedOptionTitle.isNotEmpty ? '$selectedOptionTitle: ${reportEditingController.text}' : reportEditingController.text;

      print('DetailController._fetchMediaData = ${{
        "type": 1,
        "asset_id": asset_id,
        "description": reportDescription
      }}');

      var response = await s.post(
        apiUrl,
        options: Options(
          headers: {
            'accept': 'application/json',
            'X-App': '_Android',
            'Accept-Language': 'en-US',
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          "type": 1,
          "asset_id": asset_id,
          "description": reportDescription,
        },
      );

      reportEditingController.clear();
      print(' ${response.statusCode}  - ${response.data}');
      if (response.statusCode == 200 || response.statusCode == 201) {

        Constant.showMessege("alert_1".tr);
        loadingReportDataSate.value = DataState.success('Success');
        print(response.data);
      } else {
        // Handle errors
        // Constant.showMessege("Request Denied : ${response.data['status']}");
        loadingReportDataSate.value = DataState.error('error');
      }
    } catch (e) {
      // Handle errors
      // Constant.showMessege("Request Denied : ${e.toString()}");
      loadingReportDataSate.value = DataState.error('error :$e');
      print('DetailController._fetchMediaData = $e');
    } finally {
      // Optional: any cleanup or final actions
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
         selectAccountPublish(0);
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


  var loadingSendShareDataSate = DataState<dynamic>().obs;
  void onSendShareRequest(String type, {bool ifNowSend=false})async {

    loadingSendShareDataSate.value = DataState.loading();
    Map<String,dynamic> body = {
      "file_id": file_id,
      "external_account_id": externalAccountlist.elementAt(enableChannel).id.toString(),

    };
    print('DetailController.onSendYouTubeRequest = ${formatDateTime(selectedDate.value)}');
    if (!ifNowSend) {
      body["times"]= [
        formatDateTime( selectedDate.value)
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
      if (response.statusCode! == 200) {
        try {
          if(response.data['data']['details']['error']!=null){
            Constant.showMessege(" ${"alert_10".tr} = ${response.data['data']['details']['error']}");

          }

          Constant.showMessege('Success');

          loadingSendShareDataSate.value = DataState.success('Success');
        }  catch (e) {
          // TODO


          loadingSendShareDataSate.value = DataState.error('error : ${e}');

        }
        Get.back();
        update();
      } else {
        // Handle errors
        Get.back();
        loadingSendShareDataSate.value = DataState.error('error --- ');
        Constant.showMessege("alert_10".tr);

      }
    } on DioException catch (e) {//
      // Handle errors
      Get.back();

      Constant.showMessege("alert_10".tr);
      loadingSendShareDataSate.value = DataState.error('error : ${e}');
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


  //new Player Logic
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  final ValueNotifier<bool> isPlayingNotifier = ValueNotifier(true);
  Rx<Duration> currentPosition = const Duration().obs;
  RxBool showIconPlayPause = false.obs;

  RxBool loadingVideo = true.obs;

  //method
  void updatePlayPauseState() {
    isPlayingNotifier.value = videoPlayerController!.value.isPlaying;
    currentPosition.value = videoPlayerController!.value.position;

    if (showIconPlayPause.value) {
      Future.delayed(const Duration(seconds: 1), () {
        showIconPlayPause.value = false;
      });
    }
  }

  initPlayerVideo(String? url) async {
    if (videoPlayerController != null) {
      videoPlayerController?.removeListener(updatePlayPauseState);
      chewieController?.dispose();
      await videoPlayerController?.dispose();
      videoPlayerController = null;
      chewieController = null;
    }
    loadingVideo.value = true;

    WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
        videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
            url ?? 'https://www.taxmann.com/emailer/images/CompaniesAct.mp4'));

        videoPlayerController?.initialize().then(
              (value) {
            chewieController = ChewieController(
              videoPlayerController: videoPlayerController!,
              autoPlay: true,
              looping: false,
              showControlsOnInitialize: true,
              allowFullScreen: true,
              allowedScreenSleep: false,
              allowMuting: true,
              allowPlaybackSpeedChanging: false,
              customControls:
              CustomControls(isPlayingNotifier: isPlayingNotifier),
              materialProgressColors: ChewieProgressColors(
                playedColor: Colors.red,
                handleColor: Colors.red,
                backgroundColor: Colors.grey,
                bufferedColor: Colors.lightGreen,
              ),
            );
            loadingVideo.value = false;
          },
        );
        videoPlayerController?.addListener(updatePlayPauseState);
      },
    );
  }
}
