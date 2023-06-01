import 'package:dio/dio.dart';

class MainException implements Exception {
  MainException(this.code, this.message, this.path);

  final String code;
  final String message;
  final String path;

  static MainException convert(DioError e) {
    Map<String, dynamic> data = e.response?.data;
    return MainException(data["code"], data["message"], data["path"]);
  }
}