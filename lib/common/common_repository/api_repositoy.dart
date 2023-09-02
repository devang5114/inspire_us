import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/model/api_response.dart';
import 'package:inspire_us/common/utils/constants/app_const.dart';

final apiRepoProvider = Provider<ApiRepository>((ref) => ApiRepository(ref));

class ApiRepository {
  ApiRepository(this.ref);
  Ref ref;
  Dio dio = Dio(
      BaseOptions(baseUrl: baseUrl, headers: {'Accept': 'application/json'}));

  Future<ApiResponse> getRequest(
      {required String endPoint, Map<String, dynamic>? headers}) async {
    try {
      final response =
          await dio.get(endPoint, options: Options(headers: headers));
      print(response.data);
      if (response.statusCode == 200) {
        return ApiResponse(response: response);
      }
      return ApiResponse(
          error: response.data['message'] ?? response.data['error']);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return ApiResponse(
            error: 'Connection time Out Plz check Your Internet Connection');
      }
      return ApiResponse(error: 'Something went wrong..plz try again');
    } on SocketException catch (e) {
      if (e.osError?.errorCode == 7) {
        return ApiResponse(
            error: 'Failed to connect: Please check your internet connection.');
      } else {
        return ApiResponse(error: 'Somthing went wrong');
      }
    }
  }

  Future<ApiResponse> postRequest(
      {required String endPoint,
      required Map<String, dynamic> data,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await dio.post(endPoint,
          data: data, options: Options(headers: headers));

      print('response :$response');
      print('status code :${response.statusCode}');
      print('$endPoint data :${response.data}');
      if (response.statusCode == 200) {
        print('respone dd ${response.data['message']}');
        return ApiResponse(response: response);
      } else {
        return ApiResponse(error: response.statusMessage);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiResponse(
            error: e.response!.data['message'] ?? e.response!.data['error']);
      }
      print('status code :${e.error}');
      if (e.type == DioExceptionType.connectionError) {
        return ApiResponse(
            error: 'Connection time Out Plz check Your Internet Connection');
      } else if (e.type == DioExceptionType.badResponse) {
        return ApiResponse(error: 'Bad Response try again');
      } else if (e.error is SocketException) {
        return ApiResponse(error: 'You are offline');
      }
      return ApiResponse(error: 'Something went wrong..');
    } on SocketException catch (e) {
      if (e.osError?.errorCode == 7) {
        return ApiResponse(
            error: 'Failed to connect: Please check your internet connection.');
      } else {
        return ApiResponse(error: 'Something went wrong');
      }
    }
  }

  Future<ApiResponse> putRequest(
      {required String endPoint,
      required dynamic data,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await dio.put(endPoint,
          data: data, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return ApiResponse(response: response);
      } else {
        return ApiResponse(error: 'Somthing went wrong');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return ApiResponse(
            error: 'Connection time Out Plz check Your Internet Connection');
      }
      return ApiResponse(error: 'Something went wrong..plz try again');
    } on SocketException catch (e) {
      if (e.osError?.errorCode == 7) {
        return ApiResponse(
            error: 'Failed to connect: Please check your internet connection.');
      } else {
        return ApiResponse(error: 'Somthing went wrong');
      }
    }
  }

  Future<ApiResponse> postRequestWithFormData(
      {required String endPoint,
      FormData? formData,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await dio.post(endPoint,
          data: formData, options: Options(headers: headers));
      print(response.data);
      if (response.statusCode == 200) {
        return ApiResponse(response: response);
      } else {
        return ApiResponse(error: 'Somthing went wrong');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return ApiResponse(
            error: 'Connection time Out Plz check Your Internet Connection');
      }
      return ApiResponse(error: 'Something went wrong.. plz try again');
    } on SocketException catch (e) {
      if (e.osError?.errorCode == 7) {
        return ApiResponse(
            error: 'Failed to connect: Please check your internet connection.');
      } else {
        return ApiResponse(error: 'Somthing went wrong');
      }
    }
  }
}
