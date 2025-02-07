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

/// Main controller for the 'Plus' page (creating various media posts).
class PlusLogic extends GetxController {
  final PlusState state = PlusState();

  /// A global key to reference a specific widget
  final GlobalKey containerKey = GlobalKey();

  /// Loading state for file uploads
  var isLoadingUploadFile = false.obs;

  /// Whether to show an image selected from camera or gallery
  var isShowImageFromPath = false.obs;
  var isFileUploaded = false.obs;

  /// Whether to show a file (text, video, etc.) selected
  var isShowFileFromPath = false.obs;

  late List<CameraDescription> _cameras;
  CameraController? controller; // Camera controller
  File? selectedFile; // The selected file

  // File upload data
  String? fileid;
  String? filePath;
  var aspectRatio = PlusAspectRatio.post.obs;

  // File upload controller
  UploadFileController _uploadFileController = Get.put(UploadFileController());

  // Text field controllers
  TextEditingController mainTextEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController desEditingController = TextEditingController();
  TextEditingController priceEditingController = TextEditingController();
  TextEditingController durationEditingController =
      TextEditingController(text: "add_asset_14".tr);

  /// List of subscription durations
  List<String> durationList = [
    "add_asset_15".tr,
    "add_asset_16".tr,
    "add_asset_17".tr,
  ];

  /// Indicates if audio recording was successfully completed
  bool isRecordingCompleted = false;

  /// Permissions needed for audio, photos, videos, storage, etc.
  var allPermission = [
    Permission.audio,
    Permission.photos,
    Permission.videos,
    Permission.manageExternalStorage,
  ];

  /// List of all countries
  List<CountryModel> countreisModel = [];

  /// List of countries as strings to display in the picker
  List<String> countreisString = [];

  /// Selected country model
  CountryModel? selectedCountryModel;

  /// Selected language
  String? languageModel;

  final ImagePicker _picker =
      ImagePicker(); // For picking an image from gallery

  /// Whether content is private
  var isPriaveContant = false.obs;

  /// License type (free, ownership, subscription)
  PlusLicence licence = PlusLicence.free;

  /// General loading state
  var isloading = false.obs;

  /// Loading state for text-only actions
  var isloadingText = false.obs;

  /// Whether to show the video recording time
  var isRecordingTimeVisible = false.obs;

  /// Observable string for recording time
  var recordingTime = ''.obs;

  /// Observable double for upload progress percentage
  var uploadFilePercent = 0.0.obs;

  Timer? _recordingTimer;
  Duration recordingDuration = Duration.zero;
  late Directory appDirectory;

  String uploadedFilePath = "";
  PostType postype;

  /// Audio recorder controller
  late final RecorderController recorderController;
  bool isRecording = false;

  /// A tag passed to this controller
  String tag;

  /// This variable holds the final price after multiplied by 100
  String _resultPrice = '';

  /// Constructor which receives a post type and a tag
  PlusLogic(this.postype, this.tag);

  /// Multiply the input price by 100
  void _multiplyBy100() {
    if (priceEditingController.text.isNotEmpty) {
      double? number = double.parse(priceEditingController.text);
      if (number != null) {
        _resultPrice = ((number.toInt()) * 100).toString();
      }
    }
  }

  /// Called immediately after the controller is allocated in memory.
  @override
  void onInit() {
    super.onInit();
    _checkPermissionAndNavigate();
    getAllCountries();
    getAllLanguages();
  }

  /// Start the audio recording timer
  void _startRecordingTimer() {
    recordingDuration = Duration.zero;
    _recordingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      recordingDuration += Duration(seconds: 1);
      update();
    });
  }

  /// Format the audio recording duration to HH:MM:SS
  String getFormattedRecordingDuration() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(recordingDuration.inHours);
    final minutes = twoDigits(recordingDuration.inMinutes.remainder(60));
    final seconds = twoDigits(recordingDuration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  /// Stop the audio recording timer
  void _stopRecordingTimer() {
    _recordingTimer?.cancel();
  }

  /// Start or stop audio recording
  void startOrStopRecording() async {
    print('PlusLogic.startOrStopRecording 1 ');
    try {
      if (isRecording) {
        // If currently recording, stop it
        _stopRecordingTimer();

        recorderController.reset();

        final path = await recorderController.stop(false);

        if (path != null) {
          isRecordingCompleted = true;
          debugPrint(path);
          uploadedFilePath = path;

          debugPrint("Recorded file size: ${File(path).lengthSync()}");
        }
      } else {
        // If not recording, start it
        recordingDuration = Duration.zero;

        await _getDir();
        _startRecordingTimer();
        await recorderController.record(path: uploadedFilePath);
      }
    } catch (e) {
      print('PlusLogic.startOrStopRecording $e');
      debugPrint(e.toString());
    } finally {
      // Toggle the recording state
      isRecording = !isRecording;
      update();
    }
  }

  /// Retrieve the directory path for saving audio files
  Future<String> _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    uploadedFilePath =
        "${appDirectory.path}/recording-${DateTime.now().millisecondsSinceEpoch}.m4a";
    return "";
  }

  /// Initialize the audio recorder
  void initAudio() {
    try {
      recorderController = RecorderController()
        ..androidEncoder = AndroidEncoder.aac
        ..androidOutputFormat = AndroidOutputFormat.mpeg4
        ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
        ..sampleRate = 44100;
    } catch (e) {
      // Error initializing recorder
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  /// Dispose the camera controller and recorder controller upon closing
  @override
  void onClose() {
    controller?.dispose();
    recorderController.dispose();
    super.onClose();
  }

  /// Check if all required permissions are granted
  Future<bool> _checkAllPermissions() async {
    final statuses = await Future.wait(allPermission.map((p) => p.status));
    return statuses.every((s) => s.isGranted);
  }

  /// Request permissions from the user
  Future<void> requestPermissions() async {
    bool result = false;
    final statuses = await allPermission.request();

    PermissionStatus? permissionGrantedAudio;
    PermissionStatus? permissionGrantedVideo;
    PermissionStatus? permissionGrantedPhoto;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      int androidVersion = androidInfo.version.sdkInt;

      // For devices running Android 12 or lower
      if (androidVersion <= 32) {
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
        // For Android 13 or higher
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
      // For iOS (similar to Android 12 and lower)
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
      // Show bottom sheet if permissions are not granted
      // Get.bottomSheet(PerimissonBottomSheet(this), isScrollControlled: true);
    }

    // If permissions are now granted, close the bottom sheet
    if (result) {
      Get.back();
    }
  }

  /// Initialize the camera
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

  /// Check permissions and navigate accordingly
  void _checkPermissionAndNavigate() async {
    if (await _checkAllPermissions()) {
      // Permissions are already granted
    } else {
      // Show bottom sheet to request permissions
      Get.bottomSheet(PerimissonBottomSheet(this), isScrollControlled: true);
    }
  }

  /// Start recording video
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

  /// Stop recording video
  Future<void> stopVideoRecording() async {
    if (controller == null) return;
    if (!controller!.value.isRecordingVideo) return;

    try {
      XFile video = await controller!.stopVideoRecording();
      uploadedFilePath = video.path;

      isRecordingTimeVisible.value = false;
      _stopVideoRecordingTimer();

      // After stopping, go back to the main page and upload the file
      Get.offNamed(PageRoutes.PLUS, arguments: [this]);
      uploadFile();

      update();
    } catch (e) {
      print('Error stopping video recording: $e');
    }
  }

  /// Capture a picture with the camera
  Future<XFile?> takePicture() async {
    if (controller == null || !controller!.value.isInitialized) return null;
    if (controller!.value.isTakingPicture) return null;

    try {
      final XFile file = await controller!.takePicture();
      uploadedFilePath = file.path;
      update();

      // After capturing the picture, go back to the main page and upload the file
      Get.offNamed(PageRoutes.PLUS, arguments: [this]);
      uploadFile();

      return file;
    } on CameraException catch (e) {
      print('Error taking picture: ${e.description}');
      return null;
    }
  }

  /// Start the video recording timer
  void _startVideoRecordingTimer() {
    recordingDuration = Duration.zero;
    _recordingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      recordingDuration += Duration(seconds: 1);
      recordingTime.value = _formatDuration(recordingDuration);
      update();
    });
  }

  /// Stop the video recording timer
  void _stopVideoRecordingTimer() {
    _recordingTimer?.cancel();
    recordingDuration = Duration.zero;
    recordingTime.value = '';
  }

  /// Format the duration to 00:00:00
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  /// Start or stop media (video) recording
  void startOrStopMediaRecording() {
    if (isRecordingTimeVisible.value) {
      stopVideoRecording();
    } else {
      startVideoRecording();
    }
  }

  /// Select file from the gallery (video or image) using InstaAssetPicker
  void selectFileFromGallery(bool isImage) {
    final theme = InstaAssetPicker.themeData(AppColor.primaryLightColor);

    InstaAssetPicker.pickAssets(
      maxAssets: 1,
      pickerConfig: InstaAssetPickerConfig(
        themeColor: AppColor.primaryLightColor,
        skipCropOnComplete: true,
        closeOnComplete: true,
      ),
      Get.context!,
      requestType: isImage ? RequestType.image : RequestType.video,
      onPermissionDenied: (s, p) {
        print('PlusLogic.selectFileFromGallery onPermissionDenied');
      },
      onCompleted: (s) {
        s.listen((onData) async {
          if (onData.data.isNotEmpty) {
            var file = await onData.data.first.selectedData.asset.originFile;
            uploadedFilePath = file!.path;

            // Return to the PLUS page and upload
            Get.offNamed(PageRoutes.PLUS, arguments: [this]);
            uploadFile();
            update();
          }
        });
      },
    );
  }

  /// Pick an image from the gallery using the ImagePicker and upload it
  Future<void> pickAndUploadFile() async {
    try {
      filePath = await pickImage();
    } catch (e) {
      print('PlusLogic.pickAndUploadFile = $e');
    }

    if (uploadedFilePath.length > 2) {
      isLoadingUploadFile(true);
      fileid = await _uploadFileController.upload(
        uploadedFilePath ?? "",
        (s, i) {},
      );
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

  /// Fetch all countries from the server
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

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        (response.data['data'] as List<dynamic>).forEach((element) {
          countreisModel.add(CountryModel.fromJson(element));
        });

        for (var element in countreisModel) {
          countreisString.add(element.title ?? "");
        }
        update();
      }
    } on DioError catch (e) {
      // Handle error
    }
  }

  /// Show bottom sheet for country selection
  void pickCountry() async {
    CountryModel? model = await Get.bottomSheet(
      CountryPickerBottomSheet(countreisModel),
    );
    if (model != null) {
      selectedCountryModel = model;
      update();
    }
  }

  /// Show bottom sheet for language selection
  void pickLanguage() async {
    String? model = await Get.bottomSheet(
      LangaugePickerBottomSheet(Constant.reversedLanguageMap),
    );
    if (model != null) {
      languageModel = model;
      update();
    }
  }

  /// Fetch all languages from the server
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

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        Constant.reversedLanguageMap = response.data;
        update();
      }
    } on DioError catch (e) {
      // Handle error
    }
  }

  /// Pick an image from the gallery using ImagePicker
  Future<String?> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      return pickedFile?.path;
    } catch (e) {
      Constant.showMessege("Error picking image: $e");
      return null;
    }
  }

  /// Upload a file (audio, video, image, text) to the server
  Future<String?> uploadFile() async {
    fileid = null;
    fileid = await _uploadFileController.upload(
      uploadedFilePath,
      (s, p) {
        uploadFilePercent.value = (s * 100) / p;
      },
    );

    if (fileid != null) {
      isFileUploaded(true);
      toastification.show(
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        title: Text("add_asset_6".tr),
        description: Text("add_asset_7".tr),
        alignment: Alignment.topLeft,
        autoCloseDuration: const Duration(seconds: 4),
        primaryColor: const Color(0xff0f0f26),
        backgroundColor: const Color(0xffffffff),
        foregroundColor: const Color(0xffffffff),
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
        primaryColor: const Color(0xff0f0f26),
        backgroundColor: const Color(0xffffffff),
        foregroundColor: const Color(0xffffffff),
        boxShadow: lowModeShadow,
        dragToClose: true,
      );
    }
    return fileid;
  }

  /// Return the corresponding license text for the provided enum
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

  /// Send the main request to create a post on the server
  void sendMainRequest() async {
    isloading(true);
    _multiplyBy100();
    var box = GetStorage();

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
      "length": "10",
      "forkability_status": isPriaveContant.value ? "1" : "2",
      "commenting_status": 1,
      "tags": []
    };
    if (selectedCountryModel != null) {
      body['country'] = countreisModel
              .firstWhere(
                (element) => element.iso
                    .toString()
                    .contains(selectedCountryModel?.iso ?? ""),
              )
              .iso ??
          "";
    }

    if(languageModel!=null){
      body['language'] = languageModel;
    }

    // If license type is not 1, it means it's not free and needs a price
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

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        sendToAssetPage(response.data['data']['id']);
      }
    } on DioError catch (e) {
      // Handle error
    }
  }

  /// Convert the selected license option to the required string
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

  /// Get the subscription period in days based on user selection
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

  /// After successful creation of the post, navigate the user to the details page
  void sendToAssetPage(id) {
    try {
      String route = PageRoutes.DETAILIMAGE;
      switch (postype) {
        case PostType.text:
          route = PageRoutes.DETAILTEXT;
          break;
        case PostType.image:
          route = PageRoutes.DETAILIMAGE;
          break;
        case PostType.audio:
          route = PageRoutes.DETAILMUSIC;
          break;
        case PostType.video:
          route = PageRoutes.DETAILVIDEO;
          break;
        case PostType.channel:
          // Optional handling
          break;
      }
      Get.toNamed(
        route,
        arguments: {'id': id, 'idAssetMedia': 'idAssetMedia'},
        preventDuplicates: false,
      );
    } catch (e) {
      print('FirebaseController.sendToAssetPage = $e');
    }
  }

  /// Get the media type based on the post type
  getMediaType() {
    switch (postype) {
      case PostType.image:
        return "image";
      case PostType.video:
        return "video";
      case PostType.audio:
        return "audio";
      case PostType.text:
        return "text";
      case PostType.channel:
        return "channel";
    }
  }

  /// Get allowed file extensions based on the post type
  getallowedExtensionsByPostType() {
    switch (postype) {
      case PostType.image:
        return ['png', 'jpg', 'jpeg'];
      case PostType.video:
        return ['mp4'];
      case PostType.audio:
        return ['mp3', 'm4a'];
      case PostType.text:
        return ['txt'];
      case PostType.channel:
        return [];
    }
  }

  /// Request permission and pick a file from the device using FilePicker
  Future<void> pickFileWithPermissionCheck() async {
    _pickFile();
  }

  /// Pick a file with FilePicker
  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: getallowedExtensionsByPostType(),
    );

    try {
      isShowFileFromPath.value = true;
      selectedFile = File(result!.files.first.path ?? "");
      uploadedFilePath = selectedFile!.path;
      update();
    } catch (e) {
      // Error picking file
    }
  }

  /// After picking a file, navigate back to the main form
  void goToMainForm() {
    uploadFile();
    Get.offNamed(PageRoutes.PLUS, arguments: [this]);
  }

  /// Save a string to a temporary .txt file and return the file path
  Future<String> saveStringToTxtFile(String stringData) async {
    print('PlusSectionLogic.saveStringToTxtFile = $stringData');
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/fileName.txt';
    final file = File(filePath);
    await file.writeAsString(stringData);
    return filePath;
  }

  /// Create a text file from user input and upload it
  void createTextAndUploadFile() async {
    isloadingText(true);

    // If user hasn't already chosen a text file, create one from the input
    if (isShowFileFromPath.isFalse) {
      uploadedFilePath =
          await saveStringToTxtFile(mainTextEditingController.text);
    }

    await uploadFile();
    isloadingText(false);

    // Navigate back to the main form after upload
    Get.offNamed(PageRoutes.PLUS, arguments: [this]);
  }
}

/// Defines the aspect ratio for media: post or story
enum PlusAspectRatio { post, story }

/// Defines the license types: free, ownership or subscribe
enum PlusLicence {
  free,
  ownership,
  subscreibe,
}
