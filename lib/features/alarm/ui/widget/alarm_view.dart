import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/common/utils/widgets/text_input.dart';
import 'package:inspire_us/features/audio/ui/widgets/alarm_day_selector.dart';

import '../../../../common/config/theme/theme_manager.dart';
import '../../../../common/utils/widgets/button.dart';
import '../../controller/alarm_controller.dart';

class AlarmView extends ConsumerWidget {
  const AlarmView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmWatch = ref.watch(alarmController);
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

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
                  color: isDarkMode ? Colors.white : Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10.h),
            MyTextInput(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
              controller: ref.read(alarmController).labelController,
              hintText: 'Alarm',
              customBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.colorScheme.onBackground),
                borderRadius: BorderRadius.circular(10.r),
              ),
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
              fontSize: 15.sp,
              color: context.colorScheme.onBackground,
              fontWeight: FontWeight.w500),
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
                  color: context.colorScheme.onBackground,
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
                        borderSide: BorderSide(
                          color: context.colorScheme.onBackground,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: context.colorScheme.onBackground,
                        ))),
                items: [
                  DropdownMenuItem(
                      value: 'Wake up to reality',
                      child: Text(
                        'Wake up to reality',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: context.colorScheme.onBackground),
                      )),
                  DropdownMenuItem(
                      value: 'Morning tune',
                      child: Text(
                        'Morning tune',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: context.colorScheme.onBackground),
                      )),
                  DropdownMenuItem(
                      value: 'Tune 1',
                      child: Text(
                        'Tune 1',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: context.colorScheme.onBackground),
                      )),
                ],
                onChanged: (val) {
                  ref.read(alarmController.notifier).selectedTune = val!;
                }),
            SizedBox(height: 20.h),
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
                        side: MaterialStateProperty.resolveWith((states) =>
                            BorderSide(color: context.colorScheme.primary))),
                    onPressed: () {
                      context.pop();
                      ref.read(alarmController.notifier).reset();
                    },
                    child: const Text('Cancel')),
                SizedBox(width: 20.w),
                Button(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    borderRadius: BorderRadius.circular(10.r),
                    backgroundColor: context.colorScheme.primary,
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
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    ]);
  }
}
