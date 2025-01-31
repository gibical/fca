import 'dart:developer';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/common/utils/upload_file_controller.dart';
import 'package:mediaverse/app/pages/share_account/logic.dart';
import 'package:meta/meta.dart';

import '../../../../../gen/model/json/FromJsonGetChannelsShow.dart';
import '../../../../../gen/model/json/FromJsonGetNewCountries.dart';
import '../../../../common/app_color.dart';
import '../../../../common/utils/dio_inperactor.dart';
import '../../../../widgets/country_picker.dart';

/// Controller for managing the addition of channels
class AddChannelController extends GetxController {
  final ImagePicker _picker = ImagePicker(); // Used to pick images from the gallery
  String? languageModel; // Selected language
  bool isEdit; // Determines if it's edit mode
  ChannelsModel? model; // Channel model to be edited if in edit mode

  // Text controllers for user input
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController desEditingController = TextEditingController();

  // Observables for UI state management
  var isPriaveContant = false.obs; // Private content toggle
  var isRecordable = false.obs; // Recordable toggle
  var isLoadingUploadFile = false.obs; // Loading state for file uploads
  var isShowImageFromPath = false.obs; // Whether an image is shown
  var isLoading = false.obs; // General loading state

  // Country-related data
  List<CountryModel> countreisModel = [];
  List<String> countreisString = [];
  CountryModel? selectedCountryModel;

  // File upload data
  String? fileid;
  String? filePath;

  // File upload controller
  UploadFileController _uploadFileController = Get.put(UploadFileController());

  // Constructor
  AddChannelController(this.isEdit, {this.model});

  @override
  void onReady() {
    super.onReady();
    getAllCountries(); // Fetch all available countries
    getAllLanguages(); // Fetch all available languages

    if(isEdit){
      nameEditingController.text =model!.name??"";
      desEditingController.text =model!.description??"";
      isPriaveContant.value = model!.isPrivate??false;
      isRecordable.value = model!.isRecordable??false;
      languageModel = model!.language??"";
      log('AddChannelController.onReady = ${model!.toJson()}');
    }
  }

  /// Picks an image and uploads it
  Future<void> pickAndUploadFile() async {
    filePath = await pickImage();

    if (filePath != null) {
      isLoadingUploadFile(true);
      fileid = await _uploadFileController.upload(filePath ?? "", (s, i) {});
      isLoadingUploadFile(false);

      if (fileid != null) {
        isShowImageFromPath(true);
        Constant.showMessege("add_channel_11".tr); // Success message
      }
    } else {
      Constant.showMessege("You Haven't pick image "); // Error message
    }
  }

  /// Picks an image from the gallery
  Future<String?> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      return pickedFile?.path;
    } catch (e) {
      Constant.showMessege("Error picking image: $e");
      return null;
    }
  }

  /// Fetches the list of all countries
  Future<void> getAllCountries() async {
    var dio = Dio();
    dio.interceptors.add(MediaVerseConvertInterceptor());

    try {
      var response = await dio.get(
        '${Constant.HTTP_HOST}countries',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
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

        if (isEdit) {
          try {
            selectedCountryModel = countreisModel.firstWhereOrNull((test)=>test.iso.toString().contains(model!.country.toString()));
          }  catch (e) {
            // TODO
          }
        }
        update();
      }
    } on DioError catch (e) {
      // Handle error (optional logging)
    }
  }

  /// Opens a bottom sheet to pick a country
  void pickCountry() async {
    CountryModel? model = await Get.bottomSheet(
      CountryPickerBottomSheet(countreisModel),
    );
    if (model != null) {
      selectedCountryModel = model;
      update();
    }
  }

  /// Opens a bottom sheet to pick a language
  void pickLanguage() async {
    String? model = await Get.bottomSheet(
      LangaugePickerBottomSheet(Constant.reversedLanguageMap),
    );
    if (model != null) {
      languageModel = model;
      update();
    }
  }

  /// Fetches the list of all languages
  Future<void> getAllLanguages() async {
    var dio = Dio();
    dio.interceptors.add(MediaVerseConvertInterceptor());
    dio.interceptors.add(CurlLoggerDioInterceptor());

    try {
      var response = await dio.get(
        '${Constant.HTTP_HOST}languages',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'X-App': '_Android',
          },
        ),
      );

      if (response.statusCode! >= 200 || response.statusCode! < 300) {
        Constant.reversedLanguageMap = response.data;
        update();
      }
    } on DioError catch (e) {
      // Handle error (optional logging)
    }
  }

  /// Saves the channel to the server
  Future<void> saveChannels() async {
    var dio = Dio();
    dio.interceptors.add(MediaVerseConvertInterceptor());

    if (selectedCountryModel != null && languageModel != null) {
      isLoading(true);
      Map<String, dynamic> body = {
        "name": nameEditingController.text,
        "description": desEditingController.text,
        "country_iso": selectedCountryModel!.iso,
        "language": languageModel!,
        "is_private": isPriaveContant.value ? 1 : 0,
        "is_recordable": isRecordable.value ? 1 : 0,
      };

      if (filePath != null&&!isEdit) body['thumbnails'] = fileid;

      var url = "channels";
      if (isEdit) {
        url += "/${model!.id}";
      }

      try {
        var response = await dio.request(
          '${Constant.HTTP_HOST}$url',
          data: body,
          options: Options(
            method: isEdit?"patch":"post",
            headers: {
              'Content-Type': 'application/json',
              'X-App': '_Android',
              'Authorization': 'Bearer ${GetStorage().read("token")}',
            },
          ),
        );
        isLoading(false);

        if (response.statusCode! >= 200 || response.statusCode! < 300) {
          try {
            Get.find<ShareAccountLogic>().getExternalAccount();
          }  catch (e) {
            // TODO
          }
          Get.back();
        } else {
          try {
            var message = response.data['message'];
            ScaffoldMessenger.of(Get.context!).showSnackBar(
              SnackBar(
                content: Text(
                  message,
                  style: TextStyle(color: AppColor.primaryDarkColor),
                ),
              ),
            );
          } catch (e) {
            print('AddChannelController.saveChannels error: $e');
          }
        }
      } on DioError catch (e) {
        print('AddChannelController.saveChannels DioError: ${e.requestOptions.uri}');
        isLoading(false);
      }
    } else {
      Constant.showMessege("alert_11".tr); // Error message for invalid input
    }
  }
}
