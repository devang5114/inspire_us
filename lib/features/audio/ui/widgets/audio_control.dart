import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:just_audio/just_audio.dart';

class AudioControls extends StatelessWidget {
  const AudioControls({
    super.key,
    required this.audioPlayer,
  });
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
        stream: audioPlayer.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          final processingState = playerState?.processingState;
          final playing = playerState?.playing;
          if (!(playing ?? false)) {
            return IconButton(
                onPressed: audioPlayer.play,
                icon: const Icon(Icons.play_arrow_sharp));
          } else if (processingState != ProcessingState.completed) {
            return IconButton(
                onPressed: audioPlayer.pause,
                icon: const Icon(Icons.pause_rounded));
          }
          return const IconButton(
              onPressed: null, icon: Icon(Icons.play_arrow_sharp));
        });
  }
}
