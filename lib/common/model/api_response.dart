import 'package:dio/dio.dart';

class ApiResponse {
  final Response? response;
  final String? error;

  ApiResponse({this.response, this.error});
}
