
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';



class ViewAllChannelController extends GetxController {
  List<dynamic> channels = [];
  List<dynamic> filteredChannels = [];
  bool isLoadingChannel = false;

  @override
  void onInit() {
    super.onInit();
    fetchChannelData();
  }



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
          'https://api.mediaverse.land/v2/channels?type=1';
      var response = await Dio().get(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      }));

      if (response.statusCode == 200) {
        channels = RxList<dynamic>.from(response.data);
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


}

