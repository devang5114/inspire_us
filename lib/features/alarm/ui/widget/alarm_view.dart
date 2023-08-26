
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/audio/ui/widgets/alarm_day_selector.dart';

import '../../../../common/utils/widgets/button.dart';
import '../../controller/alarm_controller.dart';

class AlarmView extends ConsumerWidget {
  const AlarmView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmWatch = ref.watch(alarmController);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Label',
              style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10.h),
            TextFormField(
              controller: ref.read(alarmController).labelController,
              decoration: InputDecoration(
                  hintText: 'Alarm',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  )),
            ),
          ],
        ),
      ),
      SizedBox(height: 15.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Text(
          'Repeat',
          style: TextStyle(
              fontSize: 15.sp, color: Colors.blue, fontWeight: FontWeight.w500),
        ),
      ),
      SizedBox(height: 10.h),
      const AlarmDaySelector(),
      SizedBox(height: 10.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alarm sound',
              style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10.h),
            DropdownButtonFormField(
                value: ref.watch(alarmController).selectedTune,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    )),
                items: const [
                  DropdownMenuItem(
                      value: 'Wake up to reality',
                      child: Text(
                        'Wake up to reality',
                      )),
                  DropdownMenuItem(
                      value: 'Morning tune', child: Text('Morning tune')),
                  DropdownMenuItem(value: 'Tune 1', child: Text('Tune 1')),
                ],
                onChanged: (val) {
                  ref.read(alarmController.notifier).selectedTune = val!;
                }),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.resolveWith((states) =>
                            EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h)),
                        shape: MaterialStateProperty.resolveWith(
                          (states) => RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                        ),
                        side: MaterialStateProperty.resolveWith(
                            (states) => const BorderSide(color: Colors.blue))),
                    onPressed: () => context.pop(),
                    child: const Text('Cancel')),
                SizedBox(width: 20.w),
                Button(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    borderRadius: BorderRadius.circular(10.r),
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      await ref
                          .read(alarmController.notifier)
                          .setAlarm(context);
                      ref.read(alarmController.notifier).reset();
                    }),
              ],
            )
          ],
        ),
      ),
    ]);
  }
}
