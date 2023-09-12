import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/tone/controller/tone_controller.dart';
import 'package:inspire_us/features/tone/ui/widgets/tones_list.dart';

class ToneCategoryList extends ConsumerWidget {
  const ToneCategoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmTuneSelectionWatch = ref.watch(toneController);
    return alarmTuneSelectionWatch.allTagsList.isEmpty
        ? emptyListWidget(context, ref)
        : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            physics: const BouncingScrollPhysics(),
            itemCount: alarmTuneSelectionWatch.allTagsList.length,
            itemBuilder: (context, index) {
              final tag = alarmTuneSelectionWatch.allTagsList[index];
              return Card(
                child: ListTile(
                    onTap: () {
                      context.push(TonesList(tag: tag));
                    },
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    leading: CircleAvatar(
                        radius: 20.r,
                        child: const Icon(
                          Icons.tag_rounded,
                        )),
                    title: Text(
                      tag,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: context.colorScheme.onBackground),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20.sp,
                    )),
              );
            },
          );
  }

  Widget emptyListWidget(BuildContext context, WidgetRef ref) => Center(
        child: Text(
          'No Tags available ',
          style: TextStyle(
              fontSize: 15.sp, color: context.colorScheme.onBackground),
        ),
      );
}
