import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/audio/controller/audio_controller.dart';
import 'package:inspire_us/features/dashboard/controller/dashboard_controller.dart';

import '../../../../common/utils/widgets/button.dart';
import 'audio_tile.dart';

class AudioList extends ConsumerWidget {
  const AudioList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioWatch = ref.watch(audioController);
    return audioWatch.globalAudioList.isEmpty
        ? emptyListWidget(context, ref)
        : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            physics: const BouncingScrollPhysics(),
            itemCount: audioWatch.globalAudioList.length,
            itemBuilder: (context, index) {
              final globalAudioModel =
                  audioWatch.globalAudioList.reversed.toList()[index];
              return AudioTile(
                globalAudioModel: globalAudioModel,
              );
            },
          );
  }

  Widget emptyListWidget(BuildContext context, WidgetRef ref) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No tones available ',
              style: TextStyle(
                  fontSize: 15.sp, color: context.colorScheme.onBackground),
            ),
            SizedBox(height: 20.h),
            Button(
                onPressed: () {
                  ref.read(dashboardController.notifier).setPage(3);
                },
                backgroundColor: context.colorScheme.primary,
                child: Text(
                  'Add your own tones to personalize your experience!',
                  style: TextStyle(fontSize: 15.sp, color: Colors.white),
                )),
          ],
        ),
      );
}
