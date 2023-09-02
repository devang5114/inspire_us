import 'package:fluttertoast/fluttertoast.dart';
import 'package:inspire_us/common/utils/constants/enums.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/common/utils/helper/network_state_helper.dart';
import 'package:inspire_us/common/utils/widgets/button.dart';
import 'package:inspire_us/features/audio/ui/widgets/audio_tile.dart';
import 'package:inspire_us/features/recording/controller/recording_controller.dart';

import '../../../../common/config/theme/theme_export.dart';
import 'mic_image_and_text.dart';

class RecordingWidget extends ConsumerWidget {
  const RecordingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordingWatch = ref.watch(recordingController);
    return ValueListenableBuilder(
      valueListenable: ConnectionStatusValueNotifier(),
      builder: (context, state, child) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Text(
              'Record Alarm Tone',
              style: TextStyle(fontSize: 25.sp),
            ),
            SizedBox(height: 30.h),
            const MicImageAndTime(),
            SizedBox(height: 30.h),
            Button(
                backgroundColor: context.colorScheme.primary,
                icon: recordingWatch.isRecording
                    ? const Icon(
                        Icons.pause_rounded,
                        color: Colors.white,
                      )
                    : const Icon(Icons.play_arrow_sharp, color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                onPressed: () {
                  if (state == NetworkState.online) {
                    ref
                        .read(recordingController.notifier)
                        .handleRecording(context);
                  } else {
                    Fluttertoast.showToast(
                      msg: 'You are offline',
                      backgroundColor: context.colorScheme.onBackground,
                      gravity: ToastGravity.CENTER,
                      textColor: context.colorScheme.background,
                    );
                  }
                },
                child: Text(
                  recordingWatch.isRecording
                      ? 'Stop Recording'
                      : 'Start Recording',
                  style: TextStyle(fontSize: 15.sp, color: Colors.white),
                )),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
