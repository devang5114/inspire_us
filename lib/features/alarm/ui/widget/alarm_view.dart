import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/common/utils/widgets/text_input.dart';
import 'package:inspire_us/features/alarm/ui/widget/alarm_day_selector.dart';
import 'package:inspire_us/features/dashboard/controller/dashboard_controller.dart';

import '../../../../common/config/theme/theme_manager.dart';
import '../../../../common/utils/widgets/button.dart';
import '../../controller/alarm_controller.dart';

class AlarmView extends ConsumerWidget {
  const AlarmView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmWatch = ref.watch(alarmController);
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    print('Lenght of audios${alarmWatch.alarmTones.map((e) => e.id).toList()}');
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
                  color: context.colorScheme.onBackground,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10.h),
            MyTextInput(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
              controller: ref.read(alarmController).labelController,
              hintText: 'Alarm',
              filled: true,
              filledColor: isDarkMode
                  ? Colors.blueGrey.withOpacity(.3)
                  : Colors.grey.shade50,
              customBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: context.colorScheme.onBackground.withOpacity(.5)),
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
      SizedBox(height: 15.h),
      const AlarmDaySelector(),
      SizedBox(height: 15.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alarm Tone',
              style: TextStyle(
                  fontSize: 15.sp,
                  color: context.colorScheme.onBackground,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10.h),
            if (alarmWatch.alarmTones.isNotEmpty)
              DropdownButtonFormField(
                value: alarmWatch.selectedToneId.toString(),
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color:
                              context.colorScheme.onBackground.withOpacity(.5),
                        )),
                    filled: true,
                    fillColor: isDarkMode
                        ? Colors.blueGrey.withOpacity(.3)
                        : Colors.grey.shade50,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color:
                              context.colorScheme.onBackground.withOpacity(.5),
                        ))),
                items: alarmWatch.alarmTones
                    .map((e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(
                          e.title,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: context.colorScheme.onBackground),
                        )))
                    .toList(),
                onChanged: (val) {
                  ref.read(alarmController.notifier).selectedToneId =
                      int.parse(val!.toString());
                  print(alarmWatch.selectedToneId);
                },
              )
            else
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      'No tones available ',
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: context.colorScheme.onBackground),
                    ),
                    SizedBox(height: 5.h),
                    TextButton(
                        onPressed: () {
                          context.pop();
                          ref.read(dashboardController.notifier).setPage(3);
                        },
                        child: Text(
                          'Add New Tone',
                          style: TextStyle(
                              fontSize: 15.sp, color: Colors.blueAccent),
                        )),
                  ],
                ),
              ),
            SizedBox(height: 20.h),
            SwitchListTile.adaptive(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
              tileColor: isDarkMode
                  ? Colors.blueGrey.withOpacity(.3)
                  : Colors.grey.shade50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  side: BorderSide(
                      color: context.colorScheme.onBackground.withOpacity(.5))),
              value: alarmWatch.vibrate,
              onChanged: (value) {
                ref.read(alarmController.notifier).vibrate = value;
                ref.read(alarmController).notifyListeners();
              },
              title: Text(
                'Vibrate when alarm sounds',
                style: TextStyle(
                    fontSize: 15.sp, color: context.colorScheme.onBackground),
              ),
            ),
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
                    onPressed: () {
                      ref.read(alarmController.notifier).setAlarm(context);
                      context.pop();
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
