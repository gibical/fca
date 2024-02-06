

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LiveController extends GetxController{
  RxMap<String, dynamic>? liveDetails = RxMap<String, dynamic>();
  RxBool isLoadingLive = false.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchLiveData();
    selectedIndex = 0;
  }

  void fetchLiveData() async {
    await _getLive( liveDetails, isLoadingLive);
  }


  Future<void> _getLive(

   RxMap<String, dynamic>? details, RxBool isLoading) async {
    try {

      final token = GetStorage().read("token");
      isLoading.value = true;
      String apiUrl =
          'https://api.mediaverse.land/v2/channels/${Get.arguments['channelId']}';
      var response = await Dio().get(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      }));

      if (response.statusCode == 200) {
        details?.value = RxMap<String, dynamic>.from(response.data);
        print(response.data);
      } else {
        // Handle errors
      }
    } catch (e) {
      // Handle errors
    } finally {
      isLoading.value = false;
    }
  }











  int selectedIndex = -1;
  List<bool> isSelectedList = [false, false, true];
  List<String> titles = ['2', '3', '5'];
  int getTimeRecord(int idx) {
    switch (idx) {
      case 0:
        return 60;
      case 1:
        return 120;
      case 2:
        return 180;
      default:
        return 0;
    }
  }

  var isLoadingRecord = false.obs;
  var isSuccessRecord = false.obs;

  void postTimeRecord(int channelId) async {
    try {
      isLoadingRecord.value = true;

      final token = GetStorage().read("token");
      String apiUrl = 'https://api.mediaverse.land/v2/edit/channel/record';
      var response = await Dio().post(
        apiUrl,
        data: {
          "channel": channelId,
          "length": getTimeRecord(selectedIndex),
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
        isSuccessRecord.value = true;
        Get.snackbar('Success', "Recording..." ,
        backgroundColor: Colors.green,
          icon: Icon(Icons.fiber_smart_record_sharp)
        );

      } else {
        print("statusCode: ${response.statusCode}");
        isSuccessRecord.value = false;
        Get.snackbar('Error', "Try again!" ,
            backgroundColor: Colors.red,
            icon: Icon(Icons.info)
        );
      }
    } catch (e) {
      print("$e");
      isSuccessRecord.value = false;

      Get.snackbar('Error', "Try again!" ,
          backgroundColor: Colors.red,
          icon: Icon(Icons.info)
      );
    } finally {
      isLoadingRecord.value = false;
    }
  }

}



