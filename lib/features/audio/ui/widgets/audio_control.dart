import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../common/config/theme/theme_manager.dart';

class AudioControls extends ConsumerWidget {
  const AudioControls({
    super.key,
    required this.audioPlayer,
  });
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    return StreamBuilder<PlayerState>(
        stream: audioPlayer.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          final processingState = playerState?.processingState;
          final playing = playerState?.playing;
          if (!(playing ?? false)) {
            return IconButton(
                onPressed: audioPlayer.play,
                color: isDarkMode ? Colors.white : Colors.black,
                icon: const Icon(Icons.play_arrow_sharp));
          } else if (processingState != ProcessingState.completed) {
            return IconButton(
                onPressed: audioPlayer.pause,
                color: isDarkMode ? Colors.white : Colors.black,
                icon: const Icon(Icons.pause_rounded));
          }
          return IconButton(
              onPressed: null,
              color: isDarkMode ? Colors.white : Colors.black,
              icon: const Icon(Icons.play_arrow_sharp));
        });
  }
}
