import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dioLib;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

import 'ApiService.dart';

enum HttpMethod { get, post, delete, put }

typedef VoidOnCallBackUpload = void Function(int total, int process);

int timeOut = 30000;

class HttpHelper {
  static Future<dioLib.Response> requestApi(String url, dynamic params, HttpMethod httpMethod, bool auth, bool body,
      {bool cache = false, int countRequest = 1}) async {
    callRequest:
    dioLib.Response response;
    dioLib.Options options;
    var dio = new dioLib.Dio();
    dio.options.connectTimeout = timeOut; //5s
    dio.options.receiveTimeout = timeOut;
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
    ));
    var headers = Map<String, dynamic>();
    if (auth) {
      var token = ApiService.ACCESS_TOKEN;
      var userID = ApiService.USER_ID;
      headers["Authorization"] = token; //ApiServic
    }
    print(jsonEncode(params));
    if (body) {
      options = dioLib.Options(
        headers: headers,
        contentType: Headers.jsonContentType,
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        },
      );
    }

    try {
      ///GET
      if (httpMethod == HttpMethod.get) {
        response = await dio.get(
          url,
          queryParameters: params,
          options: options,
        );
      }

      ///POST
      if (httpMethod == HttpMethod.post) {
        response = await dio.post(
          url,
          data: params,
          options: options,
        );
      }

      ///PUT
      if (httpMethod == HttpMethod.put) {
        response = await dio.put(
          url,
          data: params,
          options: options,
        );
      }

      //DELETE
      if (httpMethod == HttpMethod.delete) {
        response = await dio.delete(
          url,
          data: params,
          options: options,
        );
      }
    } catch (ex) {
      print("=======Lỗi try catch api=====");
      print(ex.toString());
      response = new dioLib.Response(statusCode: 696969);
    }

    //await new Future.delayed(const Duration(milliseconds: 300));
    return response;
  }

  static Future<dioLib.Response> requestApiJsonValue(
    String url,
    dynamic params,
    HttpMethod httpMethod,
    bool auth,
    bool body,
  ) async {
    dioLib.Response response;
    dioLib.Options options;
    var dio = new dioLib.Dio();
    dio.options.connectTimeout = timeOut; //5s
    dio.options.receiveTimeout = timeOut;
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
    ));
    var headers = Map<String, String>();
    if (auth) {
      var token = ApiService.ACCESS_TOKEN;
      var userID = ApiService.USER_ID;
      headers["X-Auth-Token"] = token; //ApiService
      headers["X-User-Id"] = userID; //ApiService
    }

//    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//        (client) {
//      client.badCertificateCallback =
//          (X509Certificate cert, String host, int port) {
//        return true;
//      };
//    };

    if (body) {
      options = dioLib.Options(
        headers: headers,
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        },
      );
      options.contentType = Headers.jsonContentType;
    }
    try {
      ///GET
      if (httpMethod == HttpMethod.get) {
        response = await dio.get(
          url,
          queryParameters: params,
          options: options,
        );
      }

      ///POST
      if (httpMethod == HttpMethod.post) {
        response = await dio.post(
          url,
          data: params,
          options: options,
        );
      }

      ///PUT
      if (httpMethod == HttpMethod.put) {
        response = await dio.put(
          url,
          data: params,
          options: options,
        );
      }

      //DELETE
      if (httpMethod == HttpMethod.delete) {
        response = await dio.delete(
          url,
          data: params,
          options: options,
        );
      }
    } catch (ex) {
      print("=======Lỗi try catch api=====");
      print(ex.toString());
      response = new dioLib.Response(statusCode: 696969);
    }

    // await new Future.delayed(const Duration(milliseconds: 3000));
    return response;
  }

  static Future<dioLib.Response> uploadImage(String url, dynamic file, bool auth,
      {VoidOnCallBackUpload onCallBackUpload, String fileName}) async {
    dioLib.Response response;
    try {
      var dio = new dioLib.Dio();
      dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        request: true,
      ));
      var headers = Map<String, String>();
      if (auth) {
        var token = ApiService.ACCESS_TOKEN;
        var userID = ApiService.USER_ID;
        headers["Authorization"] = token; //ApiServic
      }

      dioLib.Options options;

      options = dioLib.Options(
        headers: headers,
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        },
      );
      options.contentType = Headers.jsonContentType;
      FormData data;
      print(fileName);
      if (file is File)
        data = FormData.fromMap({
          "file": await MultipartFile.fromFile(
            file.path,
            filename: path.basename(file.path),
          ),
        });
      else
        data = FormData.fromMap({
          "file": MultipartFile.fromBytes(
            file,
            filename: fileName,
          ),
        });
      try {
        response = await dio.post(
          url,
          data: data,
          onSendProgress: (int sent, int total) {
            print("$sent $total");

            if (onCallBackUpload != null) onCallBackUpload(total, sent);
          },
          options: options,
        );
      } catch (ex) {
        print("=======Lỗi try catch api=====");
        print(ex.toString());
        response = new dioLib.Response(statusCode: 696969);
      }

      return response;
    } catch (e) {
      print(e);
      return response;
    }
  }
}
