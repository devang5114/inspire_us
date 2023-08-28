import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspire_us/common/common_repository/api_repositoy.dart';

final recordingRepoProvider =
    Provider<RecordingRepository>((ref) => RecordingRepository(ref));

class RecordingRepository {
  RecordingRepository(this.ref);
  Ref ref;

  Future<void> uploadRecordingData(String filePath) async {
    final apiResponse = await ref.read(apiRepoProvider).postRequestWithFormData(
        endPoint: 'uploadFile',
        formData: FormData.fromMap(
            {'audio': await MultipartFile.fromFile(filePath), 'title': ''}));
  }

  getUserRecording() async {
    final apiResponse =
        await ref.read(apiRepoProvider).getRequest(endPoint: 'myaudios');
  }
}
