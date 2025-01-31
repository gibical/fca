import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:camera/camera.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/pages/plus/widgets/perimisson_bottom_sheet.dart';
import 'package:mediaverse/app/pages/plus/widgets/plus_audio_recording.dart';
import 'package:mediaverse/app/pages/plus/widgets/plus_camera_screen.dart';
import 'package:mediaverse/gen/model/enums/post_type_enum.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toastification/toastification.dart';
import '../../../gen/model/json/FromJsonGetNewCountries.dart';
import '../../common/app_config.dart';
import '../../common/app_route.dart';
import '../../common/utils/dio_inperactor.dart';
import '../../common/utils/upload_file_controller.dart';
import '../../widgets/country_picker.dart';
import 'state.dart';

class PlusLogic extends GetxController {
  final PlusState state = PlusState();
  final GlobalKey containerKey = GlobalKey();
  var isLoadingUploadFile = false.obs; // Loading state for file uploads
  var isShowImageFromPath = false.obs; // Whether an image is shown
  var isShowFileFromPath = false.obs; // Whether an image is shown
  late List<CameraDescription> _cameras;
  CameraController? controller;
  File? selectedFile;

  // File upload data
  String? fileid;
  String? filePath;
  PlusAspectRatio aspectRatio = PlusAspectRatio.post;
  UploadFileController _uploadFileController = Get.put(UploadFileController());
  TextEditingController mainTextEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController desEditingController = TextEditingController();
  TextEditingController priceEditingController = TextEditingController();
  TextEditingController durationEditingController =
      TextEditingController(text: "add_asset_14".tr);
  List<String> durationList = [
    "add_asset_15".tr,
    "add_asset_16".tr,
    "add_asset_17".tr,
  ];
  bool isRecordingCompleted = false;

  var allPermission = [
    Permission.audio,
    Permission.photos,
    Permission.videos,
    Permission.manageExternalStorage,
  ];
  List<CountryModel> countreisModel = [];
  List<String> countreisString = [];
  CountryModel? selectedCountryModel;
  String? languageModel; // Selected language
  final ImagePicker _picker =
      ImagePicker(); // Used to pick images from the gallery
  var isPriaveContant = false.obs; // Private content toggle
  PlusLicence licence = PlusLicence.free;
  var isloading = false.obs;
  var isloadingText = false.obs;
  var isRecordingTimeVisible = false.obs;
  var recordingTime = ''.obs;
  var uploadFilePercent = 0.0.obs;

  Timer? _recordingTimer;
  Duration recordingDuration = Duration.zero;
  late Directory appDirectory;

  String uploadedFilePath = "";
  PostType postype;
  late final RecorderController recorderController;
  bool isRecording = false;

  String tag;

  PlusLogic(this.postype, this.tag);

  String _resultPrice = '';

  void _multiplyBy100() {
    if (priceEditingController.text.isNotEmpty) {
      double? number = double.parse(priceEditingController.text);
      if (number != null) {
        _resultPrice = ((number.toInt()) * 100).toString();
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    _checkPermissionAndNavigate();

    getAllCountries();
    getAllLanguages();
  }

  void _startRecordingTimer() {
    recordingDuration = Duration.zero;

    _recordingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      recordingDuration += Duration(seconds: 1);
      update();
    });
  }

  String getFormattedRecordingDuration() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(recordingDuration.inHours);
    final minutes = twoDigits(recordingDuration.inMinutes.remainder(60));
    final seconds = twoDigits(recordingDuration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  void _stopRecordingTimer() {
    _recordingTimer?.cancel();
    recordingDuration = Duration.zero;
  }

  void startOrStopRecording() async {
    print('PlusLogic.startOrStopRecording 1 ');
    try {
      if (isRecording) {
        _stopRecordingTimer();
        print('PlusLogic.startOrStopRecording 2 ');

        recorderController.reset();
        print('PlusLogic.startOrStopRecording 3 ');

        final path = await recorderController.stop(false);
        print('PlusLogic.startOrStopRecording 4 ');

        if (path != null) {
          isRecordingCompleted = true;
          debugPrint(path);
          uploadedFilePath = path ?? "";
          print('PlusLogic.startOrStopRecording 5 ');

          debugPrint("Recorded file size: ${File(path).lengthSync()}");
        }
      } else {
        print('PlusLogic.startOrStopRecording 6 ');

        await _getDir();
        _startRecordingTimer();
        print('PlusLogic.startOrStopRecording 7 ${uploadedFilePath}');

        await recorderController.record(path: uploadedFilePath!);
        print('PlusLogic.startOrStopRecording 8 ');
      }
    } catch (e) {
      print('PlusLogic.startOrStopRecording');
      debugPrint(e.toString());
    } finally {
      isRecording = !isRecording;
      update();
    }
  }

  Future<String> _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    uploadedFilePath =
        "${appDirectory.path}/recording-${DateTime.now().millisecondsSinceEpoch}.m4a";

    return "";
  }

  initAudio() {
    try {
      recorderController = RecorderController()
        ..androidEncoder = AndroidEncoder.aac
        ..androidOutputFormat = AndroidOutputFormat.mpeg4
        ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
        ..sampleRate = 44100;
    }  catch (e) {
      // TODO
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    controller?.dispose();
    recorderController.dispose();
    super.onClose();
  }

  Future<bool> _checkAllPermissions() async {
    final statuses = await Future.wait(allPermission.map((p) => p.status));
    return statuses.every((s) => s.isGranted);
  }

  Future<void> requestPermissions() async {
    bool result = false;

    final statuses = await allPermission.request();
    PermissionStatus? permissionGrantedAudio;
    PermissionStatus? permissionGrantedVideo;
    PermissionStatus? permissionGrantedPhoto;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      int androidVersion = androidInfo.version.sdkInt;
      if (androidVersion <= 32) {
        /// Android 12-
        if (!await Permission.storage.isGranted) {
          PermissionStatus status = await Permission.storage.request();
          if (status.isGranted) {
            result = true;
          }
        } else {
          print("permission already granted");
          result = true;
        }
      } else {
        /// Android 13+
        Map<Permission, PermissionStatus> permissions =
            await allPermission.request();
        permissionGrantedAudio = permissions[Permission.audio]!;
        permissionGrantedVideo = permissions[Permission.videos]!;
        permissionGrantedPhoto = permissions[Permission.photos]!;
        if (permissionGrantedAudio == PermissionStatus.granted &&
            permissionGrantedVideo == PermissionStatus.granted &&
            permissionGrantedPhoto == PermissionStatus.granted) {
          print('Permissions granted');
        }
      }
    } else {
      /// IOS - similar to Android 12-
      if (!await Permission.storage.isGranted) {
        PermissionStatus status = await Permission.storage.request();
        if (status.isGranted) {
          result = true;
        }
      } else {
        result = true;
      }
    }
    if (statuses.values.every((s) => s.isGranted)) {
      result = true;
    } else {
      //Get.bottomSheet(PerimissonBottomSheet(this), isScrollControlled: true);
    }
    if (result) {
      Get.back();
    }
  }

  void initCamera() async {
    _cameras = await availableCameras();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller!.initialize().then((_) {
      update();
    }).catchError((e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            break;
          default:
            break;
        }
      }
    });
  }

  void _checkPermissionAndNavigate() async {
    if (await _checkAllPermissions()) {
    } else {
      Get.bottomSheet(PerimissonBottomSheet(this), isScrollControlled: true);
    }
  }

  Future<void> startVideoRecording() async {
    if (controller == null || !controller!.value.isInitialized) return;
    if (controller!.value.isRecordingVideo) return;
    try {
      await controller!.startVideoRecording();
      isRecordingTimeVisible.value = true;
      _startVideoRecordingTimer();
      update();
    } catch (e) {
      print('Error starting video recording: $e');
    }
  }

  Future<void> stopVideoRecording() async {
    if (controller == null) return;
    if (!controller!.value.isRecordingVideo) return;
    try {
      XFile video = await controller!.stopVideoRecording();
      uploadedFilePath = video.path;
      isRecordingTimeVisible.value = false;
      _stopVideoRecordingTimer();

      Get.offNamed(PageRoutes.PLUS, arguments: [this]);      uploadFile();
      update();
    } catch (e) {
      print('Error stopping video recording: $e');
    }
  }

  Future<XFile?> takePicture() async {
    if (controller == null || !controller!.value.isInitialized) return null;
    if (controller!.value.isTakingPicture) return null;
    try {
      final XFile file = await controller!.takePicture();
      uploadedFilePath = file.path;
      update();
      Get.offNamed(PageRoutes.PLUS, arguments: [this]);
      uploadFile();
      return file;
    } on CameraException catch (e) {
      print('Error taking picture: ${e.description}');
      return null;
    }
  }

  void _startVideoRecordingTimer() {
    recordingDuration = Duration.zero;
    _recordingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      recordingDuration += Duration(seconds: 1);
      recordingTime.value = _formatDuration(recordingDuration);
      update();
    });
  }

  void _stopVideoRecordingTimer() {
    _recordingTimer?.cancel();
    recordingDuration = Duration.zero;
    recordingTime.value = '';
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  void startOrStopMediaRecording() {
    if (isRecordingTimeVisible.value) {
      stopVideoRecording();
    } else {
      startVideoRecording();
    }
  }

  void selectFileFromGallery(bool isImage) {
    final theme = InstaAssetPicker.themeData(AppColor.primaryLightColor);
    InstaAssetPicker.pickAssets(
      maxAssets: 1,
      pickerConfig: InstaAssetPickerConfig(
        themeColor: AppColor.primaryLightColor,skipCropOnComplete: true,closeOnComplete: true,
      ),
      Get.context!,
      requestType: isImage ? RequestType.image : RequestType.video,
      onPermissionDenied: (s, p) {
        print('PlusLogic.selectFileFromGallery onPermissionDenied');
      },

      onCompleted: (s) {
        print('PlusLogic.selectFileFromGallery ${s}');
        s.listen((onData) async {
          //var file =await onData.data.first.selectedData.asset.file;

          if (onData.data.isNotEmpty) {
            var file = await onData.data.first.selectedData.asset.originFile;
            uploadedFilePath = file!.path;
            Get.offNamed(PageRoutes.PLUS, arguments: [this]);
            uploadFile();
            update();
          }
        });
      },
    );
  }

  /// Picks an image and uploads it
  Future<void> pickAndUploadFile() async {
    try {
      filePath = await pickImage();
    } catch (e) {
      // TODO
      print('PlusLogic.pickAndUploadFile = ${e}');
    }

    if (uploadedFilePath.length > 2) {
      isLoadingUploadFile(true);
      fileid =
          await _uploadFileController.upload(uploadedFilePath ?? "", (s, i) {});
      isLoadingUploadFile(false);

      if (fileid != null) {
        isShowImageFromPath(true);
        Constant.showMessege("add_channel_11".tr); // Success message
      }
    } else {
      Constant.showMessege("You Haven't pick image "); // Error message
    }
    update();
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

  pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      return pickedFile?.path;
    } catch (e) {
      Constant.showMessege("Error picking image: $e");
      return null;
    }
  }

  Future<String?> uploadFile() async {
    fileid == null;
    fileid = await _uploadFileController.upload(uploadedFilePath, (s, p) {
      uploadFilePercent.value = (s * 100) / p;
    });

    if (fileid != null) {
      toastification.show(
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        title: Text("add_asset_6".tr),
        description: Text("add_asset_7".tr),
        alignment: Alignment.topLeft,
        autoCloseDuration: const Duration(seconds: 4),
        primaryColor: Color(0xff0f0f26),
        backgroundColor: Color(0xffffffff),
        foregroundColor: Color(0xffffffff),
        boxShadow: lowModeShadow,
        dragToClose: true,
      );
    } else {
      toastification.show(
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        title: Text("add_asset_8".tr),
        description: Text("add_asset_9".tr),
        alignment: Alignment.topLeft,
        autoCloseDuration: const Duration(seconds: 4),
        primaryColor: Color(0xff0f0f26),
        backgroundColor: Color(0xffffffff),
        foregroundColor: Color(0xffffffff),
        boxShadow: lowModeShadow,
        dragToClose: true,
      );
    }
    return fileid;
  }

  String getLicenceText(PlusLicence li) {
    switch (li) {
      case PlusLicence.free:
        return "add_asset_10".tr;

      case PlusLicence.ownership:
        return "add_asset_11".tr;
      case PlusLicence.subscreibe:
        return "add_asset_12".tr;
      default:
        return "";
    }
  }

  void sendMainRequest() async {
    isloading(true);
    _multiplyBy100();
    var box = GetStorage();

    print('PlusLogic.sendMainRequest = ${countreisModel.length}');
    var body = {
      "file_id": fileid,
      "name": nameEditingController.text,
      "user": box.read("userid"),
      "license_type": _getPlanByDropDown(),
      "subscription_period": getSubscrptioonPeriod(),
      "description": desEditingController.text,
      "lat": 0,
      "lng": 0,
      "type": 1,
      "media_type": getMediaType(),
      // "genre": genreController.text,
      "length": "10",
      //"language": Constant.languageMap[languageController.text],
      "country": countreisModel
              .firstWhere((element) => element.iso
                  .toString()
                  .contains(selectedCountryModel!.iso ?? ""))
              .iso ??
          "",
      "forkability_status": isPriaveContant.value ? "1" : "2",
      "commenting_status": 1,
      "tags": []
    };
    if (!_getPlanByDropDown().toString().contains("1")) {
      body['price'] = _resultPrice;
      print(_resultPrice);
    }

    print('PlusSectionLogic.sendMainRequest = ${jsonEncode(body)}');

    var dio = Dio();
    dio.interceptors.add(MediaVerseConvertInterceptor());
    dio.interceptors.add(CurlLoggerDioInterceptor());

    try {
      var response = await dio.post(
        '${Constant.HTTP_HOST}assets',
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'application/json',
            'X-App': '_Android',
          },
        ),
      );

      if (response.statusCode! >= 200 || response.statusCode! < 300) {
        sendToAssetPage(response.data['data']['id']);
      }
    } on DioError catch (e) {
      // Handle error (optional logging)
    }
  }

  String getSubscrptioonPeriod() {
    switch (durationEditingController.text) {
      case "1 Month":
        return "30";
      case "1 Year":
        return "365";
      case "Unlimited":
        return "100000000000";

      default:
        return "24";
    }
  }

  void sendToAssetPage(id) {
    try {
      String route = PageRoutes.DETAILIMAGE;
      switch (postype) {
        case PostType.text:
          route = PageRoutes.DETAILTEXT;
        case PostType.image:
          route = PageRoutes.DETAILIMAGE;
        case PostType.audio:
          route = PageRoutes.DETAILMUSIC;
        case PostType.video:
          route = PageRoutes.DETAILVIDEO;
        case PostType.channel:
        // TODO: Handle this case.
      }

      Get.toNamed(route,
          arguments: {'id': id, 'idAssetMedia': 'idAssetMedia'},
          preventDuplicates: false);
    } catch (e) {
      // TODO
      print('FirebaseController.sendToAssetPage = ${e}');
    }
  }

  getMediaType() {
    switch (postype) {
      case PostType.image:
        // TODO: Handle this case.
        return "image";
      case PostType.video:
        // TODO: Handle this case.
        return "video";

      case PostType.audio:
        // TODO: Handle this case.
        return "audio";

      case PostType.text:
        // TODO: Handle this case.
        return "text";

      case PostType.channel:
        // TODO: Handle this case.
        return "channel";
    }
  }

  _getPlanByDropDown() {
    switch (licence) {
      case PlusLicence.free:
        return "1";
      case PlusLicence.ownership:
        return "2";
      case PlusLicence.subscreibe:
        return "3";
    }
  }

  Future<void> pickFileWithPermissionCheck() async {
    _pickFile();
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: getallowedExtensionsByPostType(),
    );
    try {
      isShowFileFromPath.value=true;
      selectedFile = File(result!.files.first.path??"");
      uploadedFilePath =selectedFile!.path;
      update();
    }  catch (e) {
      // TODO
    }
  }

  getallowedExtensionsByPostType() {
    switch (postype) {
      case PostType.image:
        return ['png', 'jpg', 'jpeg'];
      case PostType.video:
        return [
          'mp4',
        ];
      case PostType.audio:
        // TODO: Handle this case.
        return ['mp3', "m4a"];

      case PostType.text:
        return [
          'txt',
        ];

      case PostType.channel:
      // TODO: Handle this case.
    }
  }

  void goToMainForm() {
    uploadFile();
    Get.offNamed(PageRoutes.PLUS, arguments: [this]);  }

  Future<String> saveStringToTxtFile(String stringData) async {
    print('PlusSectionLogic.saveStringToTxtFile = ${stringData}');
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/fileName.txt';
    final file = File(filePath);
    await file.writeAsString(stringData);
    return filePath;
  }

  void createTextAndUploadFile() async {
    isloadingText(true);
    if (isShowFileFromPath.isFalse) {
      uploadedFilePath =
          await saveStringToTxtFile(mainTextEditingController.text);
    }

    await uploadFile();
    isloadingText(false);
    Get.offNamed(PageRoutes.PLUS, arguments: [this]);
  }
}

enum PlusAspectRatio { post, story }

enum PlusLicence {
  free,
  ownership,
  subscreibe,
}
