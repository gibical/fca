import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mediaverse/app/common/utils/dio_inperactor.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/widgets/add_program_bottonsheet.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/widgets/destionation_show_page.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/widgets/tab/channel_conductor_tab.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/widgets/tab/channel_live_tab.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/widgets/tab/channel_programs_tab.dart';
import 'package:meta/meta.dart';

import '../../../../../gen/model/json/FromJsonGetChannelsLive.dart';
import '../../../../../gen/model/json/FromJsonGetChannelsShow.dart';
import '../../../../../gen/model/json/FromJsonGetProgramSchedules.dart';
import '../../../../../gen/model/json/FromJsonGetSchedules.dart';
import '../../../../../gen/model/json/v2/FromJsonGetContentFromExplore.dart';
import '../../../../common/app_config.dart';
import '../../../share_account/logic.dart';
import '../../tab/ChannalLiveController.dart';
import 'models/channel_tab_model.dart';

class MyChannelController extends GetxController {
  ChannelsModel mainChannelModel;
  List<ContentModel> videoContentModels = [];
 List<Destinations>  destinations = [];
  int selectedTabIndex = 0;
  List<LiveModel> livemodels = [];
  List<SchedulesModel> schedulesList = [];
  ValueKey mainLiveKey = ValueKey("${DateTime.now().millisecondsSinceEpoch}");

  MyChannelController(this.mainChannelModel);

  var isLoadingDeleteChannel = false.obs;
  var isLoadingAssets = false.obs;
  var isLoadingCreateProgram = false.obs;
  var isloadingStartProgram = false.obs;
  var isloadingAddSchedule = false.obs;
  var isloadingGetSchedule = false.obs;
  var isloadingAddDestionation = false.obs;
  var isChannelLiveStarted = false.obs;
  String lastEvent = "";

  PageController pageController = PageController();

  Timer? refreshTimer;

  @override
  void onInit() {
    super.onInit();

    getAllDestionation();
    getChannel();
    getAllSchedules();
    startPeriodicRefresh();
  }
  @override
  void onClose() {
    refreshTimer?.cancel();
    super.onClose();
  }

  List<ChannelTabModel> tabListModel = [
    ChannelTabModel("my_channel_1".tr, ChannelLiveTab()),
    ChannelTabModel("my_channel_2".tr, ChannelProgramsTab()),
    ChannelTabModel("my_channel_3".tr, DestionationTabWidget()),
    ChannelTabModel("my_channel_4".tr, ChannelConductorTab()),
  ];

  void getVideoAsset() async {
    isLoadingAssets.value = true;

    var dio = Dio();
    dio.interceptors.add(MediaVerseConvertInterceptor());
    var response = await Dio().get(
      "${Constant.HTTP_HOST}profile/assets",
      queryParameters: {"media_type": "video"},
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read("token")}',
          'Content-Type': 'application/json',
        },
      ),
    );
    if (response.statusCode == 200) {
      FromJsonGetContentFromExplore fromExplore =
          FromJsonGetContentFromExplore.fromJson(response.data);
      videoContentModels.clear();
      videoContentModels = fromExplore.data ?? [];
    }

    update();
    try {} catch (e) {
      // TODO
    }

    isLoadingAssets.value = false;
  }

  void addProgram(
      TextEditingController nameEditingController,
      TextEditingController sourceEditingController,
      ContentModel? model,
      SourceType? sourceType,
      bool isEdit,
      Programs? programModel) async {
    isLoadingCreateProgram.value = true;
    //debugger();
    try {
      if (nameEditingController.text.isEmpty) {
        Constant.showMessege("alert_14".tr);
        return;
      }

      if (sourceType == null) {
        Constant.showMessege("alert_14".tr);
        return;
      }
      var body = {
        "name": nameEditingController.text,
        "source": sourceType == SourceType.asset ? "file" : "rtmp"
      };

      if (sourceType == SourceType.asset) {
        body['value'] = model!.fileId ?? "";
      }

      String url = "";
      if (isEdit) {
        url = "programs/${programModel!.id}";
      } else {
        url = "channels/${mainChannelModel.id}/programs";
      }

      var dio = Dio();
      dio.interceptors.add(MediaVerseConvertInterceptor());
      print('MyChannelController.addProgram = ${body}');

      var response = await Dio().request(
        "${Constant.HTTP_HOST}${url}",
        data: body,
        options: Options(
          method: isEdit?"patch":"post",
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode! >= 200) {
        Constant.showMessege((isEdit?"alert_17":"alert_16").tr);
        Get.back();
        if(isEdit)Get.back();
        getChannel();
      }

      update();
    } on DioError catch (e) {
      Constant.showMessege(e.response!.data['message']);

    } catch (e) {
      // TODO
      isLoadingCreateProgram.value = false;
    }

    isLoadingCreateProgram.value = false;
  }

  void getChannel() async {
    var dio = Dio();
    dio.interceptors.add(MediaVerseConvertInterceptor());
    var response = await Dio().get(
      "${Constant.HTTP_HOST}channels/${mainChannelModel.id}",
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read("token")}',
          'Content-Type': 'application/json',
        },
      ),
    );
    if (response.statusCode! >= 200) {
     bool _lastChannelLiveStarted = isChannelLiveStarted.value;

      mainChannelModel = ChannelsModel.fromJson(response.data['data']);
      if((response.data['data']['last_event_type']).toString().contains("started")){
        isChannelLiveStarted(true);
      }else{
        isChannelLiveStarted(false);
      }
      if(_lastChannelLiveStarted !=isChannelLiveStarted.value){

        Get.find<ChannelMainVideoLiveController>( tag: "live-${mainChannelModel.id}").update();
      }
    }


    getChannelLives();
    update();
    try {} catch (e) {
      // TODO
    }
  }
  void getChannelLives() async {
    var dio = Dio();
    dio.interceptors.add(MediaVerseConvertInterceptor());
    var response = await Dio().get(
      "${Constant.HTTP_HOST}channels/${mainChannelModel.id}/lives",
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read("token")}',
          'Content-Type': 'application/json',
        },
      ),
    );
    if (response.statusCode! >= 200) {
      int lashLiveCount = livemodels.length;
      livemodels =
          FromJsonGetChannelsLive.fromJson(response.data).data ?? [];
      if(lashLiveCount != livemodels.length){
        Get.find<ChannelMainVideoLiveController>( tag: "live-${mainChannelModel.id}").update();

      }
    }

    update();
    try {} catch (e) {
      // TODO
    }
  }

  void deleteProgram(Programs program) {
    deleteChannelModelList(mainChannelModel.id!, program.id!);
    mainChannelModel.programs?.removeWhere(
            (test) => test.id.toString().contains(program.id.toString()));
    update();
  }


  Future<bool> deleteChannelModelList(String s, String t) async {
    var dio = Dio();

    dio.interceptors.add(MediaVerseConvertInterceptor());

    try {
      var response = await dio.delete(
        '${Constant.HTTP_HOST}programs/$t',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        if(kDebugMode)print('Request succeeded: ${response.statusCode}');
        return true;
      } else {
        print('Request failed: ${response.statusMessage}');
        return false;
      }
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      return false;
    }
  }
  Future<DateTime?> startProgram(Programs program) async {
    var dio = Dio();

    dio.interceptors.add(MediaVerseConvertInterceptor());

    isloadingStartProgram(true);

    try {
      var response = await dio.patch(
        '${Constant.HTTP_HOST}'"programs/${program.id}/start",
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('SingleChannelLogic.startProgram = ${response.data}');
      isloadingStartProgram(false);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        if(kDebugMode)print('Request succeeded: ${response.statusCode}');
        Constant.showMessege("alert_18".tr);
        return DateTime.now();
      } else {
        print('Request failed: ${response.statusMessage}');
        return null;
      }
    } on DioError catch (e) {
      isloadingStartProgram(false);

      print('DioError: ${e.message}');
      return null;
    }
  }

  Future<dynamic> addProgramSchedule(DateTime dateTime, Programs programs) async{
    var dio = Dio();

    dio.interceptors.add(MediaVerseConvertInterceptor());
    dio.interceptors.add(CurlLoggerDioInterceptor());

    isloadingAddSchedule(true);

    print('MyChannelController.addProgramSchedule = ${dateTime.toUtc()}');
    var body =  {
      "times": [
        DateFormat('y-MM-dd HH:mm:ss').format(dateTime.toUtc())
      ]
    };

    try {
      var response = await dio.post(
        '${Constant.HTTP_HOST}'"programs/${programs.id}/schedules",
        data:body,
        options: Options(

          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'application/json',
          },
        ),
      );

      isloadingAddSchedule(false);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        if(kDebugMode)print('Request succeeded: ${response.statusCode}');

        Get.back();
        Get.back();


        return true;
      } else {
        print('Request failed: ${response.statusMessage}');
        return null;
      }
    } on DioError catch (e) {
      isloadingAddSchedule(false);

      print('MyChannelController.addProgramSchedule = ${e.requestOptions.data} - ${e.response}');
      print('DioError: ${e.message}');
      return null;
    }
  }
  Future<List<ProgramSchedulesModel>> getProgramSchedule( Programs programs) async{
    var dio = Dio();

    dio.interceptors.add(MediaVerseConvertInterceptor());
    List<ProgramSchedulesModel> list = [];


    try {
      var response = await dio.get(
        '${Constant.HTTP_HOST}'"programs/${programs.id}/schedules",
        options: Options(

          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'application/json',
          },
        ),
      );


      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        if(kDebugMode)print('Request succeeded: ${response.statusCode} - ${jsonEncode(response.data)}');

        try{
          destinations.clear();
          (response.data['data'] as List).forEach((action){
            list.add(ProgramSchedulesModel.fromJson(action));
          });
          update();
        }catch(e){

        }
        return list;



      } else {
        print('Request failed: ${response.statusMessage}');
        return list;
      }
    } on DioError catch (e) {
      isloadingGetSchedule(false);

      print('DioError: ${e.message}');
      return list;
    }
  }
  addDestionation(TextEditingController _nameEditingController,TextEditingController _streamUrlEditingController, TextEditingController _streamKeyEditingController,
      bool isEdit,Destinations? des)async{
    isloadingAddDestionation(true);

    var dio = Dio();
    var body;
    body = {
      "name": _nameEditingController.text,
      "type": "rtmp",
      "details": {"link": "${_streamUrlEditingController.text}/${_streamKeyEditingController.text}"}
    };
    dio.interceptors.add(MediaVerseConvertInterceptor());
    dio.interceptors.add(CurlLoggerDioInterceptor());

    try {
      var response = await dio.request(
        '${Constant.HTTP_HOST}${"destinations"}${isEdit?"/${des!.id}":""}',
        data: body,
        options: Options(
          method: isEdit?"patch":"post",
          headers: {
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'X-App': '_Android',
          },
        ),
      );

      print('MyChannelController.addDestionation = ${response.data}');
      if (response.statusCode! >= 200 || response.statusCode! < 300) {

        if (!isEdit) {
          _streamKeyEditingController.clear();
          _streamUrlEditingController.clear();
          _nameEditingController.clear();

                 bool addDesToChannel = await addOrRemoveFromDestinationModelList(mainChannelModel.id.toString(), response.data['data']['id'],false);
          isloadingAddDestionation(false);

          if(addDesToChannel){

           Destinations destinations = Destinations.fromJson(response.data['data']);
           mainChannelModel.destinations.add(destinations);
           getAllDestionation();

           Constant.showMessege("my_channel_47".tr);
                 }else{
           Constant.showMessege("my_channel_48".tr);//

                 }
        }
       Get.back();
      } else {

      }
    } on DioError catch (e) {
      isloadingAddDestionation(false);

      Get.back();
      Constant.showMessege(e.response!.data['message']);

    }

  }

  Future<bool> addOrRemoveFromDestinationModelList(
      String channel, String destination,bool isDelete) async {
    var dio = Dio();

    dio.interceptors.add(MediaVerseConvertInterceptor());

    try {
      var response = await dio.request(
        '${Constant.HTTP_HOST}channels/$channel/destinations/$destination',
        options: Options(
          method: isDelete?"delete":"post",
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        if(kDebugMode)print('Request succeeded: ${response.statusCode}');
        return true;
      } else {
        print('Request failed: ${response.statusMessage}');
        return false;
      }
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      return false;
    }
  }
  Future<bool> deleteChannels(
      ) async {
    isLoadingDeleteChannel(true);
    var dio = Dio();

    dio.interceptors.add(MediaVerseConvertInterceptor());

    try {
      var response = await dio.delete(
        '${Constant.HTTP_HOST}channels/${mainChannelModel.id}',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'application/json',
          },
        ),
      );
      isLoadingDeleteChannel(false);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        if(kDebugMode)print('Request succeeded: ${response.statusCode}');
        Get.find<ShareAccountLogic>().channelModels.removeWhere((test)=>test.id.toString().contains(mainChannelModel.id.toString()));
        Get.find<ShareAccountLogic>().update();
        Get.back();
        return true;
      } else {
        print('Request failed: ${response.statusMessage}');
        return false;
      }
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      isLoadingDeleteChannel(false);

      return false;
    }
  }

  void removeDestionationFromChannel(Destinations value) {

    mainChannelModel.destinations.removeWhere((test)=>test.id.toString().contains(value.id.toString()));
    update();
    addOrRemoveFromDestinationModelList(mainChannelModel.id.toString(), value.id.toString(), true);
  }

  void startPeriodicRefresh() {
    refreshTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      getChannel();
    });
  }
  void switchTo(String liveID) async{
    var body = {
      "live_id":liveID
    };


    var dio = Dio();

    dio.interceptors.add(MediaVerseConvertInterceptor());

    isloadingGetSchedule(true);


    try {
      var response = await dio.post(
        '${Constant.HTTP_HOST}'"channels/${mainChannelModel.id}/switch",
        data: body,
        options: Options(

          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'application/json',
          },
        ),
      );

      isloadingGetSchedule(false);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        if(kDebugMode)print('Request succeeded: ${response.statusCode} - ${response.data}');
        Constant.showMessege("alert_19".tr);

        return response.data;



      } else {
        print('Request failed: ${response.statusMessage}');
        return null;
      }
    } on DioError catch (e) {
      isloadingGetSchedule(false);

      print('DioError: ${e.message}');
      return null;
    }
  }

  void getAllDestionation()async {



    var dio = Dio();

    dio.interceptors.add(MediaVerseConvertInterceptor());



    try {
      var response = await dio.get(
        '${Constant.HTTP_HOST}'"destinations",
        options: Options(

          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'application/json',
          },
        ),
      );


      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        if(kDebugMode)print('Request succeeded: ${response.statusCode} - ${response.data}');


        try{
          destinations.clear();
          (response.data['data'] as List).forEach((action){
            destinations.add(Destinations.fromJson(action));
          });
          update();
        }catch(e){

        }
        print('MyChannelController.getAllDestionation ${response.statusCode} - ${destinations.length} ');

        return response.data;



      } else {
        print('Request failed: ${response.statusMessage}');
        return null;
      }
    } on DioError catch (e) {

      print('DioError: ${e.message}');
      return null;
    }
  }
  void removeSchedule(String scheID)async {
    var dio = Dio();
    dio.interceptors.add(MediaVerseConvertInterceptor());
    try {
      var response = await dio.delete(
        '${Constant.HTTP_HOST}'"schedules/${scheID}",
        options: Options(

          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'application/json',
          },
        ),
      );


      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        if(kDebugMode)print('Request succeeded: ${response.statusCode} - ${response.data}');


        try{

        }catch(e){

        }
        print('MyChannelController.getAllDestionation ${response.statusCode} - ${destinations.length} ');

        return response.data;



      } else {
        print('Request failed: ${response.statusMessage}');
        return null;
      }
    } on DioError catch (e) {

      print('DioError: ${e.requestOptions.uri} ${e.message}');
      return null;
    }
  }

  bool getStatusToDestionation(Destinations value) {
    return mainChannelModel.destinations.any((test) => test.id == value.id);

  }

  void onSetDestionation(Destinations value, bool isEnable) {

    if(!isEnable){
      mainChannelModel.destinations.add(value);
    }else{
      mainChannelModel.destinations.removeWhere((values)=>values.id.toString().contains(value.id.toString()));

    }
    update();
    addOrRemoveFromDestinationModelList(mainChannelModel.id.toString(),value.id.toString(),isEnable);
  }

  void getAllSchedules()async {
    var dio = Dio();
    dio.interceptors.add(MediaVerseConvertInterceptor());
    var response = await Dio().get(
      "${Constant.HTTP_HOST}channels/${mainChannelModel.id}/schedules",
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read("token")}',
          'Content-Type': 'application/json',
        },
      ),
    );
    if (response.statusCode! >= 200) {
      schedulesList = FromJsonGetSchedules.fromJson(response.data).data??[];
      update();
    }


    update();
    try {} catch (e) {
      // TODO
    }
  }

  void onStopPressed()async {
    var dio = Dio();
    dio.interceptors.add(MediaVerseConvertInterceptor());
    var response = await Dio().patch(
      "${Constant.HTTP_HOST}programs/${mainChannelModel.program!.id}/stop",
      data: {

      },
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read("token")}',
          'Content-Type': 'application/json',
        },
      ),
    );
    if (response.statusCode! >= 200) {
      Constant.showMessege("alert_1".tr);
    }


    update();
    try {} catch (e) {
      // TODO
    }
  }

}
