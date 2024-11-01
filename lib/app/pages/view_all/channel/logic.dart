
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/app_config.dart';

import '../../../../gen/model/json/FromJsonGetAllVideos.dart';



class ViewAllChannelController extends GetxController {
  List<dynamic> channels = [];
  List<dynamic> filteredChannels = [];
  List<dynamic> videos = [];
  List<dynamic> images = [];
  bool isLoadingChannel = false;

  var isloading = false.obs;
  int page = 1;

  bool isNextPageAvailabe = false;
  @override
  void onInit() {
    page = 1;
    super.onInit();
   switch(type){
     case 1:
       fetchChannelData();
       break;
     case 2:
       featchVideos();
       break;
     case 3:
       featchImages("images");
       break;
     case 4:
       featchImages("audios");
       break;
     case 5:
       featchImages("texts");
       break;
   }
  }
  int type;


  ViewAllChannelController(this.type);

  bool busy=false;
  showFilterAppBar(){
    busy =!busy;
    update();
  }

  Future<void> fetchChannelData() async {
    try {
      final token = GetStorage().read("token");
      isLoadingChannel = true;
      update();
      String apiUrl =
          '${Constant.HTTP_HOST}channels?type=1';
      var response = await Dio().get(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      }));

      if (response.statusCode == 200) {
        channels = RxList<dynamic>.from(response.data['data']);
        filteredChannels = List.from(channels);
      } else {
      }
    } catch (e) {
      print('$e');
    } finally {
      isLoadingChannel = false;
      update();
    }
  }

  void filterChannels(String query) {
    if (query.isNotEmpty) {
      filteredChannels = channels.where((channel) {
        final title = channel['title'] as String;
        final language = channel['language'] as String;
        final country = channel['country'] as String;
        return title.toLowerCase().contains(query.toLowerCase()) ||
            language.toLowerCase().contains(query.toLowerCase()) || country.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      filteredChannels = List.from(channels);
    }
    update();
  }

  void featchVideos() async{
    isloading(true);
    try {
      final token = GetStorage().read("token");
      isLoadingChannel = true;
      update();
      String apiUrl =
          '${Constant.HTTP_HOST}videos?page=${page}';
      var response = await Dio().get(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      }));

      print('ViewAllChannelController.featchVideos = ${response.data}');
        isloading(false);
      if (response.statusCode == 200) {

        videos = response.data['data'];
      //  videos = FromJsonGetAllVideos.fromJson(response.data).data??[];
        isNextPageAvailabe = false;
        update();
      } else {
      }
    } catch (e) {
      isloading(false);

      print('$e');
    } finally {
      isLoadingChannel = false;
      update();
    }
  }

  void featchImages(String method) async{
    isloading(true);
    try {
      final token = GetStorage().read("token");
      String apiUrl =
          '${Constant.HTTP_HOST}${method}?page=${page}';
      var response = await Dio().get(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      }));

      print('ViewAllChannelController.featchVideos = ${response.data}');
      isloading(false);
      if (response.statusCode == 200) {

        images = response.data['data'];
        isNextPageAvailabe = FromJsonGetAllVideos.fromJson(response.data).nextPageUrl!=null;
        update();
      } else {
      }
    } catch (e) {
      isloading(false);

      print('$e');
    } finally {
      isLoadingChannel = false;
      update();
    }
  }



}

