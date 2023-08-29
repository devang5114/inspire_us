import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:path_provider/path_provider.dart';

final audioRepoProvider = Provider<AudioRepository>((ref) => AudioRepository());

class AudioRepository {
  Future<String?> downloadAudioFile(String url) async {
    try {
      final downloadsDirectory = await getExternalStorageDirectory();
      if (downloadsDirectory != null) {
        return await FlutterDownloader.enqueue(
            url: url,
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

  cancelDownLoad() {}
}
