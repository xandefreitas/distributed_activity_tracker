import 'package:dio/dio.dart';

import 'dio_base_interceptor.dart';

abstract class DioBase {
  static getDio({
    List<Interceptor>? interceptors,
    int timeout = 20,
  }) {
    final dio = Dio();

    dio.options.baseUrl = 'https://www.boredapi.com/api/';
    dio.options.connectTimeout = Duration(seconds: timeout);
    dio.options.receiveTimeout = Duration(seconds: timeout);
    dio.interceptors.add(DioBaseInterceptor());
    dio.options.validateStatus = (status) {
      return true;
    };

    return dio;
  }
}
