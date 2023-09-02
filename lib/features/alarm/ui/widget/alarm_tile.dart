import 'package:animations/animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/common/utils/helper/local_database_helper.dart';
import 'package:inspire_us/common/utils/helper/network_state_helper.dart';
import 'package:inspire_us/features/alarm/ui/screens/add_alarm.dart';
import 'package:intl/intl.dart';

import '../../../../common/config/theme/theme_manager.dart';
import '../../../../common/model/alarm_model.dart';
import '../../../../common/utils/constants/app_const.dart';
import '../../../../common/utils/constants/enums.dart';
import '../../controller/alarm_controller.dart';

class AlarmTile extends ConsumerWidget {
  const AlarmTile({super.key, required this.alarmModel, required this.index});
  final AlarmModel alarmModel;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeFormater = DateFormat('hh:mm a');
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    return OpenContainer(
      openBuilder: (context, action) {
        return AddAlarm(alarmModel: alarmModel, index: index);
      },
      openElevation: 0,
      closedElevation: 0,
      closedColor: context.colorScheme.background,
      closedBuilder: (context, action) {
        final neverRepeat = alarmModel.days
            .fold(true, (previousValue, element) => true == !element.isEnable);

        return ValueListenableBuilder(
          valueListenable: ConnectionStatusValueNotifier(),
          builder: (context, NetworkState state, child) => Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Container(
              margin: EdgeInsets.only(bottom: 10.h),
              padding: const EdgeInsets.all(0.5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: !isDarkMode
                      ? null
                      : LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                              Colors.blueAccent,
                              Colors.grey.shade100,
                              Colors.blueGrey
                            ])),
              child: Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r)),
                elevation: 3,
                child: InkWell(
                  onTap: () async {
                    if (state != NetworkState.offline) {
                      await LocalDb.localDb
                          .putValue(updateAlarmnIndexKey, index);
                      action.call();
                    } else {
                      Fluttertoast.showToast(
                        msg: 'You are offline',
                        backgroundColor: context.colorScheme.onBackground,
                        gravity: ToastGravity.CENTER,
                        textColor: context.colorScheme.background,
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(15.r),
                  splashColor: isDarkMode
                      ? Colors.blueGrey
                      : Colors.blue.withOpacity(.5),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    onPressed: null,
                                    icon: Icon(
                                      Icons.alarm,
                                      color: context.colorScheme.onSurface,
                                    )),
                                Text(
                                  alarmModel.label.isEmpty
                                      ? 'Alarm'
                                      : alarmModel.label,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: context.colorScheme.onSurface),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                PopupMenuButton(
                                  onSelected: (value) async {
                                    if (state != NetworkState.offline) {
                                      if (value == 'delete') {
                                        ref
                                            .read(alarmController)
                                            .deleteAlarm(alarmModel);
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: 'You are offline',
                                        backgroundColor:
                                            context.colorScheme.onBackground,
                                        textColor:
                                            context.colorScheme.background,
                                      );
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
                                      fontSize: 20.sp,
                                      color: context.colorScheme.onBackground),
                                ),
                                Switch.adaptive(
                                  value: alarmModel.isEnable,
                                  onChanged: (value) async {
                                    final updateAlarm =
                                        alarmModel.copyWith(isEnable: value);
                                    final box =
                                        Hive.box<AlarmModel>(alarmBoxKey);
                                    await box.putAt(index, updateAlarm);
                                    print('ee');
                                    print(alarmModel.isEnable);
                                    ref
                                        .read(alarmController.notifier)
                                        .onToggle(updateAlarm);
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
                                  ...List.generate(alarmModel.days.length,
                                      (index) {
                                    final day = alarmModel.days[index];
                                    return Container(
                                      margin: EdgeInsets.only(right: 5.w),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        radius: 15.r,
                                        child: CircleAvatar(
                                          radius: 14.r,
                                          backgroundColor: day.isEnable
                                              ? isDarkMode
                                                  ? Colors.white
                                                  : Colors.blueAccent
                                              : isDarkMode
                                                  ? Colors.blueGrey.shade700
                                                  : Colors.white,
                                          child: FittedBox(
                                              child: Text(
                                            day.name,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: day.isEnable
                                                  ? isDarkMode
                                                      ? Colors.black
                                                      : Colors.white
                                                  : isDarkMode
                                                      ? Colors.white
                                                      : Colors.black,
                                            ),
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
