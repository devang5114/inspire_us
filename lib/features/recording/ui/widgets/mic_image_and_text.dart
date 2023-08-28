import 'package:flutter_sound/flutter_sound.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/recording/controller/recording_controller.dart';

import '../../../../common/utils/constants/app_assets.dart';

class MicImageAndTime extends ConsumerWidget {
  const MicImageAndTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<RecordingDisposition>(
      stream: ref.read(recordingController).recorder.onProgress,
      builder: (context, snapshot) {
        final duration =
            snapshot.hasData ? snapshot.data!.duration : Duration.zero;
        String toDigits(int n) => n.toString().padLeft(2);
        final twoDigitMinutes = formatTime(duration.inMinutes.toString());
        final twoDigitSecond = formatTime(duration.inSeconds.toString());
        return Column(
          children: [
            Container(
              height: 200.h,
              width: 200.w,
              padding: EdgeInsets.all(30.r),
              decoration: BoxDecoration(
                  border: Border.all(color: context.colorScheme.primary),
                  color: ref.watch(recordingController).isRecording
                      ? Colors.white
                      : context.colorScheme.primary.withOpacity(.1),
                  shape: BoxShape.circle),
              child: Visibility(
                visible: ref.watch(recordingController).isRecording,
                replacement: Image.asset(
                  AppAssets.voiceIcon,
                  height: 150.h,
                  width: 150.w,
                ),
                child: Image.asset(
                  AppAssets.activeRecordingGif,
                  height: 150.h,
                  width: 150.w,
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Text(
              '$twoDigitMinutes : $twoDigitSecond',
              style: TextStyle(
                  fontSize: 20.sp, color: context.colorScheme.onBackground),
            ),
          ],
        );
      },
    );
  }

  String formatTime(String time) {
    if (time.length == 1) {
      return '0$time'; // Add leading zero for single-digit time
    }
    return time;
  }
}
