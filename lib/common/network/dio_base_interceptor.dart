import 'package:dio/dio.dart';

import '../util/error_util.dart';

class DioBaseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 401) {
      ErrorUtil.rejectResponse(
        exception: ErrorUtil.unauthorizedException(response),
        requestOptions: response.requestOptions,
        handler: handler,
      );
    }
    if (response.statusCode! >= 400) {
      ErrorUtil.rejectResponse(
        exception: ErrorUtil.httpException(response),
        requestOptions: response.requestOptions,
        handler: handler,
      );
    }
    return handler.next(response);
  }
}
