import 'package:dio/dio.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/model/api_response.dart';
import 'package:inspire_us/common/utils/constants/app_const.dart';

final apiRepoProvider = Provider<ApiRepository>((ref) => ApiRepository(ref));

class ApiRepository {
  ApiRepository(this.ref);
  Ref ref;
  Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    headers: {},
  ));

  Future<ApiResponse> getRequest({required String endPoint}) async {
    try {
      FormData formData = FormData.fromMap({});
      final response = await dio.get(endPoint);
      if (response.statusCode == 200) {
        return ApiResponse(response: response);
      }
      return ApiResponse(error: 'Somthing went wrong');
    } on DioException catch (e) {
      return ApiResponse(error: e.message);
    }
  }

  Future<ApiResponse> postRequest(
      {required String endPoint, required dynamic data}) async {
    try {
      final response = await dio.post(endPoint, data: data);
      if (response.statusCode == 200) {
        return ApiResponse(response: response);
      } else {
        return ApiResponse(error: 'Somthing went wrong');
      }
    } on DioException catch (e) {
      return ApiResponse(error: e.message);
    }
  }

  Future<ApiResponse> putRequest(
      {required String endPoint, required dynamic data}) async {
    try {
      final response = await dio.post(endPoint, data: data);
      if (response.statusCode == 200) {
        return ApiResponse(response: response);
      } else {
        return ApiResponse(error: 'Somthing went wrong');
      }
    } on DioException catch (e) {
      return ApiResponse(error: e.message);
    }
  }

  Future<ApiResponse> postRequestWithFormData(
      {required String endPoint, FormData? formData}) async {
    try {
      final response = await dio.post(endPoint, data: formData);
      if (response.statusCode == 200) {
        return ApiResponse(response: response);
      } else {
        return ApiResponse(error: 'Somthing went wrong');
      }
    } on DioException catch (e) {
      return ApiResponse(error: e.message);
    }
  }
}
