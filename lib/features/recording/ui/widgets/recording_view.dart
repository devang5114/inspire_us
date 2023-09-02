import 'package:flutter_animate/flutter_animate.dart';
import 'package:inspire_us/features/recording/controller/recording_controller.dart';
import 'package:inspire_us/features/recording/ui/widgets/recording_widget.dart';
import 'package:inspire_us/features/recording/ui/widgets/upload_widget.dart';

import '../../../../common/config/theme/theme_export.dart';

class RecordingView extends ConsumerWidget {
  const RecordingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordingWatch = ref.watch(recordingController);
    return Column(
      children: [
        TabBar(
            onTap: (value) {
              ref.read(recordingController.notifier).setIndex(value);
            },
            tabs: [
              Tab(
                child: Text(
                  'RECORD',
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
              ),
              Tab(
                child: Text(
                  'UPLOAD',
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
              ),
            ]),
        Expanded(
            child: recordingWatch.index == 0
                ? const RecordingWidget().animate().fade()
                : const UploadWidget().animate().fade())
      ],
    );
  }
}
