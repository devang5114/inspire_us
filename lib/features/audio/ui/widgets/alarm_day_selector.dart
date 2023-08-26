import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/constants/enums.dart';

import '../../../alarm/controller/alarm_controller.dart';

class AlarmDaySelector extends ConsumerWidget {
  const AlarmDaySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                backgroundColor: Colors.white,
                selectedColor: Colors.blue,
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
              items: const [
                DropdownMenuItem(value: 'dayWise', child: Text('Day wise')),
                DropdownMenuItem(
                    value: 'never',
                    child: Text(
                      'Never',
                    )),
              ],
              onChanged: (val) {
                print(val);

                if (val == 'never') {
                  print(val);
                  ref.read(alarmController.notifier).setRepeat(Repeat.never);
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
