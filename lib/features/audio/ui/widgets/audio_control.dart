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

        if (!(playing ?? false) ||
            processingState == ProcessingState.completed) {
          // If audio is not playing or has completed, show the play button
          return IconButton(
            onPressed: () {
              if (processingState == ProcessingState.completed) {
                // If audio has completed, seek to the beginning before playing
                audioPlayer.seek(Duration.zero);
              }
              audioPlayer.play();
            },
            color: isDarkMode ? Colors.white : Colors.black,
            icon: const Icon(Icons.play_arrow_sharp),
          );
        } else if (playing!) {
          // If audio is playing, show the pause button
          return IconButton(
            onPressed: audioPlayer.pause,
            color: isDarkMode ? Colors.white : Colors.black,
            icon: const Icon(Icons.pause_rounded),
          );
        }

        // Default state when none of the conditions match
        return const SizedBox.shrink();
      },
    );
  }
}
