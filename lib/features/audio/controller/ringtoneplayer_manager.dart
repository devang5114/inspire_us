import 'package:just_audio/just_audio.dart';

class RingTonePlayerManager {
  init(String path) {
    audioPlayer.setFilePath(path);
  }

  AudioPlayer audioPlayer = AudioPlayer();

  play() {
    audioPlayer.play();
  }
}
