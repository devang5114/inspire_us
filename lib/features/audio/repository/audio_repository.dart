import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspire_us/common/common_repository/api_repositoy.dart';
import 'package:inspire_us/common/model/global_audio_model.dart';

import 'package:path_provider/path_provider.dart';

import '../../../common/utils/constants/app_const.dart';
import '../../../common/utils/helper/local_database_helper.dart';

final audioRepoProvider =
    Provider<AudioRepository>((ref) => AudioRepository(ref));

class AudioRepository {
  AudioRepository(this.ref);
  Ref ref;
  Future<String?> downloadAudioFile(String url, String name) async {
    try {
      final downloadsDirectory = await getExternalStorageDirectory();
      if (downloadsDirectory != null) {
        return await FlutterDownloader.enqueue(
            url: url,
            fileName: '$name.mp3',
            savedDir: downloadsDirectory.path,
            showNotification: true,
            saveInPublicStorage: true,
            openFileFromNotification: true,
            allowCellular: true,
            requiresStorageNotLow: true);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<({List<GlobalAudioModel>? audioList, String? error})>
      getGlobalTones() async {
    final userId = await LocalDb.localDb.getValue(userIdKey);
    final authToken = await LocalDb.localDb.getValue(authTokenKey);
    print('userid $userId token $authToken');
    Map<String, dynamic> headers = {'Authorization': 'Bearer $authToken'};
    final apiResponse = await ref.read(apiRepoProvider).postRequest(
        endPoint: 'all-tones-global',
        data: {
          'user_id': userId,
        },
        headers: headers);
    if (apiResponse.response != null) {
      final data = apiResponse.response!.data;
      if (data['status'] as bool) {
        final audioData = data['data'];
        List<GlobalAudioModel> audioList = [];
        for (var data in audioData) {
          audioList.add(GlobalAudioModel.fromJson(data));
        }
        return (audioList: audioList, error: null);
      }
      return (
        audioList: null,
        error: (data['message'] ?? data['message'] ?? 'Something went Wrong')
            .toString()
      );
    }
    return (audioList: null, error: apiResponse.error);
  }
}
