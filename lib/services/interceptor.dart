import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_akhir_stenly_rachmad/config/logger.dart';

requestInterceptor(Request request) {
  var message = {
    'REQUEST URL:': request.url,
    'REQUEST HEADER:': request.headers,
    'REQUEST METHOD:': request.method,
    'REQUEST BODY': request.bodyBytes
  };
  if (GetStorage().hasData('auth')) {
    request.headers["authorization"] =
        "Bearer ${GetStorage().read('auth')['token']}";
    print("STORAGE AUTH : ${GetStorage().read('auth')}");
  }
  logger.i(message);

  return request;
}

responseInterceptor(Request request, Response response) {
  ///https://api.themoviedb.org/3/movie/top_rated?api_key=b42f1d2342c381ec25f6180c52e51c00&page=1
  var message = <String, dynamic>{
    'RESPONSE URL:': request.url,
    'RESPONSE CODE:': response.statusCode,
    'RESPONSE MESSAGE:': response.statusText,
    'RESPONSE BODY:': response.body,
    'RESPONSE UNAUTHORIZED:': response.unauthorized,
  };
  logger.i(message);
  // GetStorage().write(request.url.toString(), response.body);
  return response;
}
