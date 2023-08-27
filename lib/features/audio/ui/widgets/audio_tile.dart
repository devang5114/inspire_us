import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/features/audio/ui/widgets/audio_control.dart';
import 'package:inspire_us/features/audio/ui/widgets/audio_progress_bar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioTile extends ConsumerStatefulWidget {
  const AudioTile(this.audioUrl, {super.key});

  final String audioUrl;

  @override
  ConsumerState<AudioTile> createState() => _AudioTileState();
}

class _AudioTileState extends ConsumerState<AudioTile>
    with SingleTickerProviderStateMixin {
  late AudioPlayer audioPlayer;
  Duration? duration;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    audioPlayer = AudioPlayer()..setAsset(widget.audioUrl);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          audioPlayer.positionStream,
          audioPlayer.bufferedPositionStream,
          audioPlayer.durationStream,
          (positionStream, bufferedPositionStream, durationStream) =>
              PositionData(positionStream, bufferedPositionStream,
                  durationStream ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Container(
        margin: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Title : Audio'),
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 10.h, right: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AudioControls(audioPlayer: audioPlayer),
                  AudioProgressBar(
                      positionDataStream: _positionDataStream,
                      audioPlayer: audioPlayer),
                  // IconButton(
                  //     onPressed: () {}, icon: const Icon(Icons.volume_up)),
                  PopupMenuButton(
                    child: const Icon(Icons.more_vert),
                    itemBuilder: (context) {
                      return const [
                        PopupMenuItem(
                          value: 'download',
                          child: Row(
                            children: [
                              Icon(Icons.download),
                              Text('Download'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'speed',
                          child: Row(
                            children: [
                              Icon(Icons.play_circle_filled_sharp),
                              Text('Play back speed'),
                            ],
                          ),
                        )
                      ];
                    },
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
            ),
            const Align(
                alignment: Alignment.bottomRight, child: Text('Steve Jobs'))
          ],
        ),
      ),
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}
