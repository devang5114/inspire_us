import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:just_audio/just_audio.dart';

import 'audio_tile.dart';

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar(
      {super.key, required this.positionDataStream, required this.audioPlayer});
  final Stream<PositionData> positionDataStream;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: positionDataStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data;
        return SizedBox(
          width: 180.w,
          child: ProgressBar(
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
