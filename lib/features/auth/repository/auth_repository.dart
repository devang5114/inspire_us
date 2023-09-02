import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspire_us/common/common_repository/api_repositoy.dart';
import 'package:inspire_us/common/model/api_response.dart';
import 'package:inspire_us/common/model/auth_response.dart';
import 'package:inspire_us/common/utils/constants/app_const.dart';
import 'package:inspire_us/common/utils/helper/local_database_helper.dart';

final authRepoProvider = Provider<AuthRepository>((ref) => AuthRepository(ref));

class AuthRepository {
  AuthRepository(this.ref);
  Ref ref;
  Future<AuthResponse> loginRequest(String email, String password) async {
    final apiResponse = await ref.read(apiRepoProvider).postRequest(
        endPoint: 'login', data: {'email': email, 'password': password});
    if (apiResponse.response != null) {
      final data = apiResponse.response!.data;
      if (data['status'] as bool) {
        LocalDb.localDb.putValue(userIdKey, data['data']['id']);
        return AuthResponse(authToken: data['token']);
      } else {
        return AuthResponse(error: data['error'] ?? data['message']);
      }
    }
    return AuthResponse(error: apiResponse.error);
  }

  Future<AuthResponse> registerRequest(
      String name, String email, String password) async {
    print(name + email + password);
    final apiResponse = await ref.read(apiRepoProvider).postRequest(
        endPoint: 'register',
        data: {'name': name, 'email': email, 'password': password});
    if (apiResponse.response != null) {
      final data = apiResponse.response!.data;
      if (data['status'] as bool) {
        LocalDb.localDb.putValue(userIdKey, data['data']['id']);
        return AuthResponse(
            authToken: data['token'], registerCode: data['code']);
      } else {
        return AuthResponse(error: data['error'] ?? data['message']);
      }
    }
    return AuthResponse(error: apiResponse.error);
  }

  Future<AuthResponse> verifyEmail(String email, String code) async {
    final apiResponse = await ref.read(apiRepoProvider).postRequest(
        endPoint: 'email-verify', data: {'email': email, 'code': code});
    if (apiResponse.response != null) {
      final data = apiResponse.response!.data;
      return AuthResponse(
          isEmailVerified: data['message'] == 'Email Verified..');
    } else {
      return AuthResponse(error: apiResponse.error);
    }
  }

  Future<AuthResponse> forgetPassword(String email) async {
    final apiResponse = await ref
        .read(apiRepoProvider)
        .postRequest(endPoint: 'forgot-password', data: {'email': email});
    if (apiResponse.response != null) {
      final data = apiResponse.response!.data;
      if (data['data'] != null) {
        return AuthResponse(forgetPassWordOtp: data['data']);
      } else {
        return AuthResponse(
            error: data['error'] ??
                data['message'] ??
                'something went wrong plz try again');
      }
    }
    return AuthResponse(error: apiResponse.error);
  }

  Future<AuthResponse> changePassWord(String email, String newPassword) async {
    final apiResponse = await ref.read(apiRepoProvider).postRequest(
        endPoint: 'change-password',
        data: {'email': email, 'newpassword': newPassword});
    print(apiResponse);
    if (apiResponse.response != null) {
      final data = apiResponse.response!.data;
      if (data['status'] as bool) {
        return AuthResponse(successMessage: data['message']);
      }
      return AuthResponse(error: data['message'] ?? data['error']);
    } else {
      return AuthResponse(error: apiResponse.error);
    }
  }
}
