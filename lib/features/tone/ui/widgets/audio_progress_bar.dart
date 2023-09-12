import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../common/config/theme/theme_manager.dart';
import 'audio_tile.dart';

class AudioProgressBar extends ConsumerWidget {
  const AudioProgressBar(
      {super.key, required this.positionDataStream, required this.audioPlayer});
  final Stream<PositionData> positionDataStream;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    return StreamBuilder(
      stream: positionDataStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data;
        return SizedBox(
          width: 180.w,
          child: ProgressBar(
            timeLabelTextStyle: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            baseBarColor: isDarkMode ? Colors.blueAccent : Colors.blueAccent,
            thumbColor: isDarkMode ? Colors.blueAccent : Colors.blueAccent,
            thumbGlowColor:
                isDarkMode ? Colors.white.withOpacity(.5) : Colors.blueAccent,
            progressBarColor:
                isDarkMode ? Colors.blueAccent : Colors.blueAccent,
            progress: positionData?.position ?? Duration.zero,
            buffered: positionData?.bufferedPosition ?? Duration.zero,
            total: positionData?.duration ?? Duration.zero,
            onSeek: audioPlayer.seek,
          ),
        );
      },
    );
  }
}
