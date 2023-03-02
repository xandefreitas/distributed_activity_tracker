import 'dart:io';

import 'package:dio/dio.dart';

import '../network/dio_custom_exception.dart';

abstract class ErrorUtil {
  static String validateException(dynamic e) {
    if (e is DioError) {
      if (e.error is! String) {
        return e.error is SocketException ? (e.error as SocketException).osError!.message : e.error.toString();
      } else {
        return e.message.toString();
      }
    }
    return e.message.toString();
  }

  static DioCustomException httpException(Response<dynamic> response) {
    return DioCustomException(
      message: getErrorMessage(response),
      code: response.statusCode!,
    );
  }

  static DioCustomException unauthorizedException(Response<dynamic> response) {
    return DioCustomException(
      message: getErrorMessage(response),
      code: response.statusCode!,
    );
  }

  static rejectResponse({
    required Exception exception,
    required RequestOptions requestOptions,
    required ResponseInterceptorHandler handler,
  }) {
    return handler.reject(
      DioError(
        requestOptions: requestOptions,
        error: exception,
      ),
    );
  }

  static getErrorMessage(Response response) => response.data is String ? response.data : response.data["Message"];
}
