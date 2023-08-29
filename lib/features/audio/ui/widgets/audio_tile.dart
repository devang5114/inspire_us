import 'package:animations/animations.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/audio/controller/audio_controller.dart';
import 'package:inspire_us/features/audio/repository/audio_repository.dart';
import 'package:inspire_us/features/audio/ui/widgets/audio_control.dart';
import 'package:inspire_us/features/audio/ui/widgets/audio_progress_bar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioTile extends ConsumerStatefulWidget {
  const AudioTile(
      {this.name,
      this.title,
      this.desc,
      this.recordingPath,
      this.audioPath,
      this.isRecordingTile = false,
      super.key});
  final bool isRecordingTile;
  final String? audioPath;
  final String? recordingPath;
  final String? title;
  final String? name;
  final String? desc;

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
    if (widget.recordingPath != null) {
      audioPlayer = AudioPlayer()..setFilePath(widget.recordingPath!);
    } else {
      audioPlayer = AudioPlayer()..setAsset(widget.audioPath!);
    }
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
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Container(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.isRecordingTile
                    ? 'Name : ${widget.name} '
                    : 'Title : ${widget.title}',
                style: TextStyle(
                    fontSize: 15.sp, color: context.colorScheme.onSurface),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AudioControls(audioPlayer: audioPlayer),
                    SizedBox(width: 5.w),
                    AudioProgressBar(
                        positionDataStream: _positionDataStream,
                        audioPlayer: audioPlayer),
                    SizedBox(width: 5.w),
                    PopupMenuButton(
                      onSelected: (value) async {
                        if (value == 'download') {
                          ref.read(audioRepoProvider).downloadAudioFile(
                              'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3');
                        } else if (value == 'speed') {}
                      },
                      child: const Icon(Icons.more_vert),
                      itemBuilder: (context) {
                        return [
                          if (widget.isRecordingTile)
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  const Icon(Icons.download),
                                  SizedBox(width: 5.w),
                                  Text(
                                    'Delete',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: context.colorScheme.onSurface),
                                  ),
                                ],
                              ),
                            )
                          else ...[
                            PopupMenuItem(
                              value: 'download',
                              child: Row(
                                children: [
                                  const Icon(Icons.download),
                                  SizedBox(width: 5.w),
                                  Text(
                                    'Download',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: context.colorScheme.onSurface),
                                  ),
                                ],
                              ),
                            ),
                            // PopupMenuItem(
                            //   value: 'speed',
                            //   child: Row(
                            //     children: [
                            //       PopupMenuButton(
                            //           itemBuilder: (context) {
                            //             return [
                            //               const PopupMenuItem(
                            //                 child: Text('0.5'),
                            //                 value: '0.5',
                            //               ),
                            //               const PopupMenuItem(
                            //                 child: Text('1.0'),
                            //                 value: '1.0',
                            //               ),
                            //               const PopupMenuItem(
                            //                 child: Text('1.5'),
                            //                 value: '1.5',
                            //               ),
                            //             ];
                            //           },
                            //           child: Row(children: [
                            //             const Icon(
                            //                 Icons.play_circle_filled_sharp),
                            //             Text('Play back speed',
                            //                 style: TextStyle(
                            //                     fontSize: 13.sp,
                            //                     color: context
                            //                         .colorScheme.onSurface))
                            //           ]),
                            //         onSelected: (value) {
                            //           audioPlayer.play()
                            //         },
                            //       ),
                            //     ],
                            //   ),
                            // )
                          ]
                        ];
                      },
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.shade300,
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Text(widget.isRecordingTile ? 'tag' : 'Steve Jobs',
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: context.colorScheme.onSurface)))
            ],
          ),
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
