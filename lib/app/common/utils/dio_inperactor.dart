import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/common/app_route.dart';

class MediaVerseInterceptor extends Interceptor{
  RequestInterface requestInterface;
  int reqQode;
  MediaVerseInterceptor(this.requestInterface,this.reqQode,);


  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);

    print('MediaVerseInterceptor.onError = ${err.response!.statusCode} - ${err.response!.data}');

    requestInterface.onError(jsonEncode(err.response!.data), reqQode, err.response!.data.toString());
    if(err.response!.statusCode==406){
      Get.toNamed(PageRoutes.SIGNUP);
    }
  }
}