import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/common/app_route.dart';

class MediaVerseInterceptor extends Interceptor{
  RequestInterface requestInterface;
  int reqQode;
  MediaVerseInterceptor(this.requestInterface,this.reqQode,);


  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);

    print('MediaVerseInterceptor.onError = ${err.response!.statusCode} - $reqQode - ${err.response!.data} - ${err.requestOptions.uri}');

    requestInterface.onError(jsonEncode(err.response!.data), reqQode, err.response!.data.toString());
    if(err.response!.statusCode==406){
      Get.toNamed(PageRoutes.SIGNUP);
    }
  }
}


class MediaVerseConvertInterceptor extends Interceptor{


  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);

    print('MediaVerseInterceptor.onError = ${err.response!.statusCode} - ${err.response!.data}');


    try {
      Constant.showMessege(err.response!.data['message']);
    }  catch (e) {
      // TODO
    }
    if(err.response!.statusCode==406){
      Get.toNamed(PageRoutes.SIGNUP);
    }
  }
}