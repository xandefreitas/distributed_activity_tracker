class DioCustomException implements Exception {
  final dynamic message;
  final int code;

  DioCustomException({required this.message, required this.code});
}
