import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspire_us/common/common_repository/api_repositoy.dart';
import 'package:inspire_us/common/model/user.dart';
import 'package:inspire_us/common/utils/constants/app_const.dart';
import 'package:inspire_us/common/utils/helper/local_database_helper.dart';

final profileRepProvider =
    Provider<ProfileRepository>((ref) => ProfileRepository(ref));

class ProfileRepository {
  ProfileRepository(this.ref);

  Ref ref;

  Future<({User? user, String? error})> getUserData() async {
    final userId = await LocalDb.localDb.getValue(userIdKey);
    final authToken = await LocalDb.localDb.getValue(authTokenKey);
    print('$userId auth token is $authToken');
    final apiResponse = await ref.read(apiRepoProvider).postRequest(
        endPoint: 'user-profile',
        data: {'user_id': userId},
        headers: {"Authorization": 'Bearer $authToken'});
    if (apiResponse.response != null) {
      final data = apiResponse.response!.data;
      if (data['status'] as bool) {
        final userData = data['data'];
        print(userData);
        return (
          user: User(
              id: userData['id'],
              name: userData['name'],
              email: userData['email'],
              path: userData['image']),
          error: null
        );
      }
      return (user: null, error: (data['message'] ?? data['error']).toString());
    }
    return (user: null, error: apiResponse.error);
  }

  Future<({bool updateStatus, String? error})> updateUserData(
      String name, String email, String path) async {
    final userId = await LocalDb.localDb.getValue(userIdKey);
    final authToken = await LocalDb.localDb.getValue(authTokenKey);
    final formData = FormData.fromMap({
      'user_id': userId,
      'name': name,
      'email': email,
      'image': await MultipartFile.fromFile(path)
    });
    final apiResponse = await ref.read(apiRepoProvider).postRequestWithFormData(
        endPoint: 'update-profile',
        formData: formData,
        headers: {"Authorization": 'Bearer $authToken'});
    if (apiResponse.response != null) {
      final data = apiResponse.response!.data;
      if (data['status'] as bool) {
        return (updateStatus: true, error: null);
      }
      return (
        updateStatus: false,
        error: (data['message'] ?? data['error']).toString()
      );
    } else {
      return (updateStatus: false, error: apiResponse.error);
    }
  }
}
