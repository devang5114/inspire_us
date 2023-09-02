import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/config/theme/theme_manager.dart';
import 'package:inspire_us/common/utils/constants/enums.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

import '../../../../common/utils/constants/repeat_enum.dart';
import '../../controller/alarm_controller.dart';

class AlarmDaySelector extends ConsumerWidget {
  const AlarmDaySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    final alarmWatch = ref.watch(alarmController);
    Widget alarmDays = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: 20.w, top: 10.h),
      child: Row(
        children: [
          ...List.generate(ref.read(alarmController).days.length, (index) {
            final day = alarmWatch.days[index];

            return Theme(
              data: ThemeData.light(),
              child: ChoiceChip(
                labelStyle: TextStyle(fontSize: 12.sp),
                shape: CircleBorder(
                    side: BorderSide(color: Colors.grey.withOpacity(.1))),
                backgroundColor:
                    isDarkMode ? Colors.blueGrey.shade700 : Colors.white,
                selectedColor: isDarkMode ? Colors.white : Colors.blueAccent,
                label: Text(
                  day.name,
                  style: TextStyle(
                      color: day.isEnable
                          ? isDarkMode
                              ? Colors.black
                              : Colors.white
                          : isDarkMode
                              ? Colors.white
                              : Colors.black),
                ),
                selected: day.isEnable,
                onSelected: (value) {
                  ref.read(alarmController.notifier).setDaysValue(index, value);
                },
              ),
            );
          })
        ],
      ),
    );
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: DropdownButtonFormField(
              value: alarmWatch.repeat.name,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  )),
              items: [
                DropdownMenuItem(
                    value: Repeat.once.name,
                    child: Text('Once',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: context.colorScheme.onBackground))),
                DropdownMenuItem(
                    value: Repeat.days.name,
                    child: Text(
                      'Day wise',
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: context.colorScheme.onBackground),
                    )),
                DropdownMenuItem(
                    value: Repeat.everyDay.name,
                    child: Text(
                      'Every day',
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: context.colorScheme.onBackground),
                    )),
              ],
              onChanged: (val) {
                // print(val);

                if (val == Repeat.once.name) {
                  // print(val);
                  ref.read(alarmController.notifier).setRepeat(Repeat.once);
                } else if (val == Repeat.days.name) {
                  ref.read(alarmController.notifier).setRepeat(Repeat.days);
                } else if (val == Repeat.everyDay.name) {
                  ref.read(alarmController.notifier).setRepeat(Repeat.everyDay);
                }
              }),
        ),
        Visibility(
          visible: ref.watch(alarmController).repeat == Repeat.days,
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 0),
              child: alarmDays),
        )
      ],
    );
  }
}
