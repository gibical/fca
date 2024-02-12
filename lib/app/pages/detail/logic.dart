import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mediaverse/app/pages/detail/widgets/youtube_bottomsheet.dart';
import 'package:video_player/video_player.dart';

import '../../common/app_config.dart';
import '../../common/utils/duraton_music_helper.dart';

class DetailController extends GetxController {
  //==================================== get Detail page =======================================//
  RxMap<String, dynamic>? videoDetails = RxMap<String, dynamic>();
  RxMap<String, dynamic>? imageDetails = RxMap<String, dynamic>();
  RxMap<String, dynamic>? musicDetails = RxMap<String, dynamic>();
  RxMap<String, dynamic>? textDetails = RxMap<String, dynamic>();

  //==================================== loading Detail page =======================================//
  RxBool isLoadingVideos = false.obs;
  RxBool isLoadingImages = false.obs;
  RxBool isLoadingMusic = false.obs;
  RxBool isLoadingText = false.obs;


  String id = Get.arguments['id'].toString();

  //==================================== for youtube share =======================================//
  bool isSeletedNow = true;
  bool isSeletedDate = false;
  DateTime dateTime = DateTime.now();
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController desEditingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    print('DetailController.onInit');
    fetchVideoData();
    fetchImageData();
    fetchMusicData();
    fetchTextData();



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
      isLoading.value = true;
      String apiUrl =
          'https://api.mediaverse.land/v2/$type/${Get.arguments['id']}';
      var response = await Dio().get(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      }));

      print('DetailController._fetchMediaData = ${response.statusCode}  - ${response.data}');
      if (response.statusCode == 200) {
        details?.value = RxMap<String, dynamic>.from(response.data);
        print(response.data);
      } else {
        // Handle errors
      }
    } catch (e) {
      // Handle errors
      print('DetailController._fetchMediaData = $e');
    } finally {
      isLoading.value = false;
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
      String apiUrl = 'https://api.mediaverse.land/v2/assets/${Get.arguments['id']}/comments';

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
      String apiUrl = 'https://api.mediaverse.land/v2/assets/comments';
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
      String apiUrl = 'https://api.mediaverse.land/v2/assets/$assetId/buy';

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


  void soundConvertToText() async{
    try {
      final token = GetStorage().read("token");

      String apiUrl =
          '${Constant.HTTP_HOST}convert/audio-text';
      var response = await Dio().post(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      }),data: {
        "audio":id
      });

      print('DetailController._fetchMediaData = ${response.statusCode}  - ${response.data}');
      if (response.statusCode == 200) {


        Constant.showMessege("Request Succesful : ${response.data['status']}");
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
  void soundTranslate() async{
    try {
      final token = GetStorage().read("token");

      String apiUrl =
          '${Constant.HTTP_HOST}translate/audio';
      var response = await Dio().post(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      }),data: {
        "audio":id
      });

      print('DetailController._fetchMediaData = ${response.statusCode}  - ${response.data}');
      if (response.statusCode == 200) {


        Constant.showMessege("Request Succesful : ${response.data['status']}");
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

  void sendShareYouTube() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) => BottomSheet(
        backgroundColor: Colors.black54,
        enableDrag: false,
        onClosing: () {},
        builder: (context) {
          return YoutubeShareBottomSheet(this);
        },
      ),
    );
  }

  void screenShotOfTheVideo() {}

  void videoConvertToAudio() async{
    try {
      final token = GetStorage().read("token");

      String apiUrl =
          '${Constant.HTTP_HOST}convert/video-audio';
      var response = await Dio().post(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      }),data: {
        "video": id
      });

      print('DetailController._fetchMediaData = ${response.statusCode}  - ${response.data}');
      if (response.statusCode == 200) {


        Constant.showMessege("Request Succesful : ${response.data['status']}");
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

}
