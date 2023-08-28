import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/config/theme/theme_manager.dart';
import 'package:inspire_us/common/utils/constants/enums.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

import '../../../alarm/controller/alarm_controller.dart';

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
                    isDarkMode ? Colors.white : Colors.white.withOpacity(.7),
                selectedColor: context.colorScheme.primary,
                label: Text(
                  day.name,
                  style: TextStyle(
                      color: day.isEnable ? Colors.white : Colors.black),
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
              value: ref.watch(alarmController).repeat.name,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  )),
              items: [
                DropdownMenuItem(
                    value: 'dayWise',
                    child: Text(
                      'Day wise',
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: context.colorScheme.onBackground),
                    )),
                DropdownMenuItem(
                    value: 'once',
                    child: Text('Once',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: context.colorScheme.onBackground))),
              ],
              onChanged: (val) {
                print(val);

                if (val == 'once') {
                  print(val);
                  ref.read(alarmController.notifier).setRepeat(Repeat.once);
                } else if (val == 'dayWise') {
                  ref.read(alarmController.notifier).setRepeat(Repeat.dayWise);
                }
              }),
        ),
        Visibility(
          visible: ref.watch(alarmController).repeat == Repeat.dayWise,
          child: alarmDays,
        )
      ],
    );
  }
}
