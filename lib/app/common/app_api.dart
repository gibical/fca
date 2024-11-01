import 'dart:convert';
import 'dart:io';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart' as gt;

import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/utils/dio_inperactor.dart';
import 'dart:io' as IO;
import 'RequestInterface.dart';
import 'app_config.dart';

class ApiRequster {
  static const int SEND_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;
  static const int CONNECT_TIMEOUT = 10000;

  static gt.Dio _create() {
    gt.Dio dio = gt.Dio();
    // 全局属性：请求前缀、连接超时时间、响应超时时间
    gt.BaseOptions options = gt.BaseOptions(
        sendTimeout: const Duration(seconds: SEND_TIMEOUT),
        connectTimeout: const Duration(seconds: CONNECT_TIMEOUT),
        receiveTimeout: const Duration(seconds: RECEIVE_TIMEOUT),
        receiveDataWhenStatusError: true);
    dio = gt.Dio(options);

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      //这一段是解决https抓包的问题
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
      return null;
      //设置花瓶的代理ip
    };
    return dio;
  }

  final RequestInterface _requestInterface;
  final bool develperModel;

  ApiRequster(this._requestInterface, {this.develperModel = false}) {
    _create();
  }

  static int MHETOD_GET = 1;
  static int MHETOD_POST = 2;
  static int MHETOD_DELETE = 4;
  static int MHETOD_PATCH = 3;
  static int MHETOD_PUT = 5;
  String mainUrl = Constant.HTTP_HOST;

  final encoding = Encoding.getByName('utf-8');

  static final staticHeaders = {
    'accept': 'application/json',
    'Content-Type': 'application/json',
    'X-App': '_Android',
    'Accept-Language': 'en-US',
  };

  void request(String endPointUrl, int reqMode, int reqCode,
      {bool daynamicUrl = false, body, bool useToken = false}) async {
    final box = GetStorage();


    if (develperModel) print("request Code is $reqCode started ");

    _requestInterface.onStartReuqest(reqCode);

    final headers = staticHeaders;

    if (useToken) {
      var box = GetStorage();
      headers['Authorization'] = "Bearer " + box.read("token");
    }
    if (develperModel) print("request Code Headers $reqCode = ${headers} ");

    Uri uri = Uri.parse((daynamicUrl ? endPointUrl : mainUrl + endPointUrl).trim());

    if (develperModel)
      if (develperModel) {
        print("uri  $reqCode = $uri   = $useToken");
      }

    if (develperModel) print('ApiRequster.request 0 1 = $headers');

    gt.Dio dio = gt.Dio(gt.BaseOptions(headers: headers,));
    dio.interceptors.add(MediaVerseInterceptor(_requestInterface,reqCode));
    dio.interceptors.add(CurlLoggerDioInterceptor());
    if (!kIsWeb) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (IO.HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    try {
      switch (reqMode) {
        case 1:
          try {
            if (develperModel) print('ApiRequster.request 2 1');

            var response = await dio.get(
              daynamicUrl ? endPointUrl : mainUrl + endPointUrl,
            );
            if (develperModel) print('ApiRequster.request 2 2');

            if (develperModel) print("uri  $reqCode = $uri");
            if (develperModel) print('ApiRequster.request 2 3');

            final statusCode = response.statusCode;
            if (develperModel) print('ApiRequster.request 2 4');

            if (response.statusCode == 200 || response.statusCode == 201) {
              String responseBody = response.data.toString();
              if (develperModel)
                if (develperModel) {
                  print("onSucces body $reqCode = ${jsonEncode(response.data)}");
                }
              _requestInterface.onSucces(jsonEncode(response.data), reqCode);
            } else {
              if (develperModel)
                if (develperModel) {
                  print("onError Body $reqCode = " + response.data);
                }
              _requestInterface.onError(
                  statusCode.toString(), reqCode, jsonEncode(response.data));
            }
          } catch (e) {
            if (develperModel) print(e);

          }

          break;
        case 2:
          var response = await gt.Dio(gt.BaseOptions(
            headers: headers,
          )).post(
            daynamicUrl ? endPointUrl : mainUrl + endPointUrl,
            data: body,
          );
          if (develperModel) print("uri  $reqCode = $uri");

          final statusCode = response.statusCode;
          if (develperModel) print('ApiRequster.request $reqCode - $statusCode = $body');
          if (response.statusCode == 200 || response.statusCode == 201) {
            try {
              String responseBody = response.data.toString();
              if (develperModel)
                if (develperModel) {
                  print("onSucces body $reqCode = ${jsonEncode(response.data)}");
                }
              _requestInterface.onSucces(jsonEncode(response.data), reqCode);
            }  catch (e) {
              // TODO

              print('ApiRequster.request _requestInterface.onSucces catch');
              String responseBody = response.data.toString();

              _requestInterface.onSucces(responseBody, reqCode);

            }
          } else {
            _requestInterface.onError(
                statusCode.toString(), reqCode, jsonEncode(response.data));
            if (develperModel)
              if (develperModel) {
                print("onError Body $reqCode = " + response.data);
              }
          }
          break;
        case 3:
          var response = await gt.Dio(gt.BaseOptions(
            headers: headers,
          )).patch(
            daynamicUrl ? endPointUrl : mainUrl + endPointUrl,
            data: jsonEncode(body),
          );
          if (develperModel) print("uri  $reqCode = $uri");

          final statusCode = response.statusCode;
          if (response.statusCode == 200 || response.statusCode == 201) {
            String responseBody = response.data.toString();
            if (develperModel)
              if (develperModel) {
                print("onSucces body $reqCode = ${jsonEncode(response.data)}");
              }
            _requestInterface.onSucces(jsonEncode(response.data), reqCode);
          } else {
            _requestInterface.onError(
                statusCode.toString(), reqCode, jsonEncode(response.data));
            if (develperModel)
              if (develperModel) {
                print("onError Body $reqCode = " + response.data);
              }
          }
          break;
        case 5:
          var response = await gt.Dio(gt.BaseOptions(
            headers: headers,
          )).put(
            daynamicUrl ? endPointUrl : mainUrl + endPointUrl,
            data: jsonEncode(body),
          );
          if (develperModel) print("uri  $reqCode = $uri");

          final statusCode = response.statusCode;
          if (response.statusCode == 200 || response.statusCode == 201) {
            String responseBody = response.data.toString();
            if (develperModel)
              if (develperModel) {
                print("onSucces body $reqCode = ${jsonEncode(response.data)}");
              }
            _requestInterface.onSucces(jsonEncode(response.data), reqCode);
          } else {
            _requestInterface.onError(
                statusCode.toString(), reqCode, jsonEncode(response.data));
            if (develperModel)
              if (develperModel) {
                print("onError Body $reqCode = " + response.data);
              }
          }
          break;
        case 4:
          var response = await gt.Dio(gt.BaseOptions(
            headers: headers,
          )).delete(
            daynamicUrl ? endPointUrl : mainUrl + endPointUrl,
            data: jsonEncode(body),
          );
          if (develperModel) print("uri  $reqCode = $uri");

          final statusCode = response.statusCode;
          if (response.statusCode == 200 || response.statusCode == 201) {
            String responseBody = response.data.toString();
            if (develperModel)
              if (develperModel) {
                print("onSucces body $reqCode = ${jsonEncode(response.data)}");
              }
            _requestInterface.onSucces(jsonEncode(response.data), reqCode);
          } else {
            _requestInterface.onError(
                statusCode.toString(), reqCode, jsonEncode(response.data));
            if (develperModel)
              if (develperModel) {
                print("onError Body $reqCode = " + response.data);
              }
          }
          break;
      }
    } on gt.DioError catch (ex) {
      // Constant.showMessege(ex.toString());

      if (develperModel) print('ApiRequster.request 2 ');
      try {
        _requestInterface.onError(ex.response!.statusCode.toString(), reqCode,
            jsonEncode(ex.response!.data));
        if (develperModel)
          if (develperModel) {
            print("onError Body $reqCode = " + ex.response!.data);
          }
      } catch (e) {
        // TODO
        if (develperModel) print('ApiRequster.request 2= $e ');
        if (develperModel)
          if (develperModel) {
            print('ApiRequster.request 2= ${ex.response!.statusCode} ');
          }
        if (develperModel)
          if (develperModel) {
            print(
              'ApiRequster.request 2= ${ex.response!.data} - ${ex.requestOptions.data} - ${ex.response!.statusCode}');
          }
        _requestInterface.onError(e.toString(), reqCode, ex.requestOptions.data);
        if (develperModel) print("onError catch = $e");
      }
    } catch (e) {
      if (develperModel) print('ApiRequster.request 3 ');

      // TODO
      if (develperModel) print('ApiRequster.request 1= $e');
      _requestInterface.onError(e.toString(), reqCode, "null");
      if (develperModel) print("onError catch = $e");
    }
  }

  Future<String> _getTokenFromSharedPrefence() async {
    final box = GetStorage();

    String? token = box.read("token") ?? "";
    return token ?? "";
  }

  static void showErrorLog(String content, String bodyError) {
    var messege = jsonDecode(bodyError)['message'];
   // Constant.showErrorMessege("$messege");
  }
}
