import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspire_us/common/common_repository/api_repositoy.dart';
import 'package:inspire_us/common/model/api_response.dart';

final authRepoProvider = Provider<AuthRepository>((ref) => AuthRepository(ref));

class AuthRepository {
  AuthRepository(this.ref);
  Ref ref;
  Future<void> loginRequest(String email, String password) async {
    ApiResponse response = await ref.read(apiRepoProvider).postRequest(
        endPoint: 'login', data: {'email': email, 'password': password});
  }

  Future<void> registerRequest(
      String name, String email, String password) async {
    ApiResponse response = await ref.read(apiRepoProvider).postRequest(
        endPoint: 'register',
        data: {'name': name, 'email': email, 'password': password});
  }

  Future<void> verifyOtp(String otp) async {
    ApiResponse response = await ref
        .read(apiRepoProvider)
        .postRequest(endPoint: 'otp', data: {'otp': otp});
  }
}
