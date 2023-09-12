import 'package:animations/animations.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/config/theme/theme_manager.dart';
import 'package:inspire_us/common/model/audio_model.dart';
import 'package:inspire_us/common/model/global_audio_model.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/recording/controller/recording_controller.dart';
import 'package:inspire_us/features/tone/repository/audio_repository.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import 'audio_control.dart';
import 'audio_progress_bar.dart';

class AudioTile extends ConsumerStatefulWidget {
  const AudioTile({this.audioModel, this.globalAudioModel, super.key});

  final AudioModel? audioModel;
  final GlobalAudioModel? globalAudioModel;

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
    if (widget.audioModel != null) {
      audioPlayer = AudioPlayer()..setUrl(widget.audioModel!.fileUrl);
    } else {
      audioPlayer = AudioPlayer()..setUrl(widget.globalAudioModel!.fileUrl);
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
    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    final isAudioModel = widget.audioModel != null;
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: const EdgeInsets.all(0.5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: isDarkMode
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blueAccent, Colors.white, Colors.blueGrey])
              : null),
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Container(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isAudioModel
                        ? widget.audioModel!.title
                        : widget.globalAudioModel!.title,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: context.colorScheme.onSurface),
                  ),
                  PopupMenuButton(
                    onSelected: (value) async {
                      if (value == 'download') {
                        ref.read(toneRepoProvider).downloadAudioFile(
                            widget.globalAudioModel!.fileUrl,
                            widget.globalAudioModel!.title);
                      } else if (value == 'delete') {
                        ref.read(recordingController).deleteTone(
                            widget.audioModel!.id.toString(), context);
                      }
                    },
                    child: const Icon(Icons.more_vert),
                    itemBuilder: (context) {
                      return [
                        if (isAudioModel)
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                const Icon(Icons.delete),
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
                        else
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
                      ];
                    },
                  )
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                  isAudioModel
                      ? addHashtagsToString(widget.audioModel!.tags)
                      : addHashtagsToString(widget.globalAudioModel!.tags),
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onSurface)),
              Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AudioControls(audioPlayer: audioPlayer),
                    AudioProgressBar(
                        positionDataStream: _positionDataStream,
                        audioPlayer: audioPlayer),
                    SizedBox(width: 5.w),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.shade300,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        // widget.audioModel.isRecordingTile ?
                        isAudioModel
                            ? DateFormat('hh:mm   yy/mm/dd')
                                .format(widget.audioModel!.createdAt)
                            : '@${widget.globalAudioModel!.userName}',
                        // : 'Steve Jobs',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: context.colorScheme.onSurface)),
                  ),
                  if (!isAudioModel)
                    PopupMenuButton(
                      padding: EdgeInsets.zero,
                      enableFeedback: false,
                      enabled: true,
                      position: PopupMenuPosition.under,
                      icon: Icon(Icons.info_outline),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text(
                              'Created At ${DateFormat('hh:mm   yy/mm/dd').format(widget.globalAudioModel!.createdAt)}'),
                          value: 'info',
                        )
                      ],
                    ),
                ],
              ),
              // if (!isAudioModel)
              //   Text(
              //       DateFormat('hh:mm   yy/mm/dd')
              //           .format(widget.globalAudioModel!.createdAt),
              //       style: TextStyle(
              //           fontSize: 12.sp, color: context.colorScheme.onSurface))
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

String addHashtagsToString(String inputString) {
  // Split the inputString by commas
  List<String> words = inputString.split(',');

  // Trim each word and add a hashtag before it
  List<String> wordsWithHashtags = words.map((word) {
    // Remove leading and trailing whitespaces
    String trimmedWord = word.trim();
    // Add a hashtag before the word
    return '#$trimmedWord';
  }).toList();

  // Join the words with commas to reconstruct the string
  String resultString = wordsWithHashtags.join(', ');

  return resultString;
}
