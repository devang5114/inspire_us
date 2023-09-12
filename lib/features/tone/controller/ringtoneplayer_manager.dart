import 'package:just_audio/just_audio.dart';

import '../../../common/config/theme/theme_export.dart';

class RingTonePlayerManager {
  AudioPlayer? audioPlayer;

  init(String path) {
    audioPlayer = AudioPlayer();
    audioPlayer!.setFilePath(path);
  }

  play() async {
    audioPlayer!.setLoopMode(LoopMode.all);
    await audioPlayer!.play();
  }

  stop() async {
    await audioPlayer!.stop();
  }
}
