import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';

import '../app_config.dart';
import 'dio_inperactor.dart';

class UploadFileController extends GetxController {


  String fileid ="";

  Future<String?> upload(String file_src ,Function(int count, int total) _onSendProgress)async{
    var dio = d.Dio();
    var formData = d.FormData.fromMap({
      'file': await d.MultipartFile.fromFile(file_src,
          filename: 'uploadfile'),

    });
   // print('PlusSectionLogic.uploadFileWithDio = ${imageOutPut} - ${_getFilePathFromMediaEnum()} - ${formData.fields}');

    dio.interceptors.add(MediaVerseConvertInterceptor());

    log(GetStorage().read("token"));
    try {
      var response = await dio.post(
        '${Constant.HTTP_HOST}files',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'multipart/form-data',
            'X-App': '_Android',
          },
        ),
        onSendProgress: _onSendProgress,
      );

      if (response.statusCode! >= 200||response.statusCode! < 300) {
        print('==================================================================================================');
        print('File uploaded successfully = ${response.data}');
        print('==================================================================================================');

        fileid =response.data['data']['id'];


        return fileid;



      } else {
        print('Failed to upload file: ${response.statusMessage}');
        return null;
      }
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      return null;

    }
  }

}