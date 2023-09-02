import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspire_us/common/common_repository/api_repositoy.dart';
import 'package:inspire_us/common/model/audio_model.dart';

import '../../../common/utils/constants/app_const.dart';
import '../../../common/utils/helper/local_database_helper.dart';

final recordingRepoProvider =
    Provider<RecordingRepository>((ref) => RecordingRepository(ref));

class RecordingRepository {
  RecordingRepository(this.ref);

  Ref ref;

  Future<({bool uploadStatus, String? error})> uploadRecordingData(
      String filePath, String title, String tags) async {
    final userId = await LocalDb.localDb.getValue(userIdKey);
    final authToken = await LocalDb.localDb.getValue(authTokenKey);
    Map<String, dynamic> headers = {'Authorization': 'Bearer $authToken'};
    FormData formData = FormData.fromMap({
      'user_id': userId,
      'title': title,
      'tags': tags,
      'file': await MultipartFile.fromFile(filePath)
    });
    final apiResponse = await ref.read(apiRepoProvider).postRequestWithFormData(
        endPoint: 'tone-insert', headers: headers, formData: formData);
    if (apiResponse.response != null) {
      final data = apiResponse.response!.data;
      if (data['status'] as bool) {
        return (uploadStatus: true, error: null);
      }
      return (
        uploadStatus: false,
        error: (data['message'] ?? data['error']).toString()
      );
    } else {
      return (uploadStatus: false, error: apiResponse.error);
    }
  }

  Future<({List<AudioModel>? audioList, String? error})>
      getUserRecording() async {
    final userId = await LocalDb.localDb.getValue(userIdKey);
    final authToken = await LocalDb.localDb.getValue(authTokenKey);
    final apiResponse = await ref.read(apiRepoProvider).postRequest(
        endPoint: 'all-tones-user',
        headers: {'Authorization': 'Bearer $authToken'},
        data: {'user_id': userId});
    if (apiResponse.response != null) {
      final data = apiResponse.response!.data;
      if (data['status'] as bool) {
        final audioFiles = data['data'];
        List<AudioModel> audioList = [];
        for (var audioData in audioFiles) {
          audioList.add(AudioModel.fromJson(audioData));
        }
        return (audioList: audioList, error: null);
      }
      return (
        audioList: null,
        error: (data['error'] ?? data['message'] ?? 'Something went wrong')
            .toString()
      );
    } else {
      return (audioList: null, error: apiResponse.error);
    }
  }

  Future<({String? error, bool isDeleted})> deleteTone(String toneId) async {
    final userId = await LocalDb.localDb.getValue(userIdKey);
    final authToken = await LocalDb.localDb.getValue(authTokenKey);
    Map<String, dynamic> headers = {'Authorization': 'Bearer $authToken'};

    final apiResponse = await ref.read(apiRepoProvider).postRequest(
        endPoint: 'tone-delete', data: {'tone_id': toneId}, headers: headers);
    if (apiResponse.response != null) {
      final data = apiResponse.response!.data;
      if (data['status'] as bool) {
        return (isDeleted: true, error: null);
      }
      return (
        isDeleted: false,
        error: (data['message'] ?? data['error']).toString()
      );
    }
    return (isDeleted: false, error: apiResponse.error);
  }
}
