import 'package:animations/animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/features/alarm/ui/screens/add_alarm.dart';
import 'package:intl/intl.dart';

import '../../../common/model/alarm_model.dart';
import '../../../common/utils/constants/app_const.dart';
import '../controller/alarm_controller.dart';

class AlarmTile extends ConsumerWidget {
  const AlarmTile({super.key, required this.alarmModel, required this.index});
  final AlarmModel alarmModel;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeFormater = DateFormat('hh:mm a');
    return OpenContainer(
      openBuilder: (context, action) {
        return AddAlarm(alarmModel: alarmModel, index: index);
      },
      openElevation: 0,
      closedElevation: 0,
      closedBuilder: (context, action) {
        final neverRepeat = alarmModel.days
            .fold(true, (previousValue, element) => true == !element.isEnable);

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: Card(
            elevation: 3,
            child: InkWell(
              onTap: () {
                action.call();
              },
              splashColor: Colors.blue.withOpacity(.5),
              highlightColor: Colors.blue.withOpacity(.3),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const IconButton(
                                onPressed: null, icon: Icon(Icons.alarm)),
                            Text(alarmModel.label.isEmpty
                                ? 'Alarm'
                                : alarmModel.label)
                          ],
                        ),
                        Row(
                          children: [
                            PopupMenuButton(
                              onSelected: (value) async {
                                if (value == 'delete') {
                                  await alarmModel.delete();
                                  ref
                                      .read(alarmController)
                                      .deleteAlarm(alarmModel);
                                  Fluttertoast.showToast(
                                      gravity: ToastGravity.CENTER,
                                      msg: 'Alarm Deleted',
                                      backgroundColor: Colors.blue);
                                }
                              },
                              child: const Icon(Icons.more_vert),
                              itemBuilder: (context) {
                                return const [
                                  PopupMenuItem(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete),
                                        Text('Delete'),
                                      ],
                                    ),
                                  ),
                                ];
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              timeFormater.format(alarmModel.time),
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.black),
                            ),
                            Switch.adaptive(
                              value: alarmModel.isEnable,
                              onChanged: (value) async {
                                final updateAlarm =
                                    alarmModel.copyWith(isEnable: value);
                                final box = Hive.box<AlarmModel>(alarmBoxKey);
                                await box.putAt(index, updateAlarm);
                                ref
                                    .read(alarmController.notifier)
                                    .onToggle(alarmModel);
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 5.h),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ...List.generate(alarmModel.days.length, (index) {
                                final day = alarmModel.days[index];
                                return Container(
                                  margin: EdgeInsets.only(right: 5.w),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 15.r,
                                    child: CircleAvatar(
                                      radius: 14.r,
                                      backgroundColor: day.isEnable
                                          ? Colors.blueAccent
                                          : Colors.white,
                                      child: FittedBox(
                                          child: Text(
                                        day.name,
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            color: day.isEnable
                                                ? Colors.white
                                                : Colors.black),
                                      )),
                                    ),
                                  ),
                                );
                              })
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String addZero(String val) {
    if (val.length < 2) {
      return '0$val';
    }
    return val;
  }
}
