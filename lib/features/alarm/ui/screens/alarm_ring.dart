import 'dart:io';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/config/theme/theme_manager.dart';
import 'package:inspire_us/common/model/alarm_model.dart';
import 'package:inspire_us/common/utils/constants/repeat_enum.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/alarm/repository/alarm_repository.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';
import '../../../../common/utils/constants/app_assets.dart';
import '../../../../common/utils/widgets/button.dart';
import '../../controller/alarm_ring_controller.dart';

class AlarmRing extends ConsumerWidget {
  const AlarmRing({
    required this.activeAlarmModel,
    super.key,
    this.isAppActive = false,
  });

  final bool isAppActive;
  final AlarmModel activeAlarmModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(alarmRingController).getCurrentTime;
    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    final formater = DateFormat('hh:mm a');
    return WillPopScope(
      onWillPop: () async {
        if (isAppActive) {
          // ref.read(ringToneProvider).stop();
        }
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('activeAlarmId', '0');

        return true;
      },
      child: SafeArea(
        child: Scaffold(
            body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: context.colorScheme.background,
                        border: Border.all(
                            color: isDarkMode
                                ? context.colorScheme.primary
                                : Colors.grey.shade300,
                            width: 3.w),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: time.isNotEmpty
                          ? Text(time,
                              style: TextStyle(
                                  fontSize: 50.sp,
                                  color: context.colorScheme.onBackground))
                          : CircularProgressIndicator(
                              color: context.colorScheme.primary,
                            )),
                  Lottie.asset(AppAssets.alarmLottie,
                      height: 300.h, width: 300.w),
                  Text(
                    formater.format(activeAlarmModel.time),
                    style: TextStyle(
                        fontSize: 25.sp,
                        color: context.colorScheme.onBackground),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                      activeAlarmModel.label.isEmpty
                          ? "Alarm"
                          : activeAlarmModel.label,
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: context.colorScheme.onBackground)),
                  SizedBox(height: 30.h),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                      backgroundColor: context.colorScheme.primary,
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.w, vertical: 18.h),
                      onPressed: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        await pref.setString('activeAlarmId', '0');
                        Navigator.popUntil(context, (route) => false);
                        await Future.delayed(200.ms);
                        exit(0);
                      },
                      child: Text(
                        'Stop Alarm',
                        style: TextStyle(fontSize: 15.sp, color: Colors.white),
                      )),
                  SizedBox(width: 30.w),
                  Button(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      borderSide:
                          BorderSide(color: context.colorScheme.primary),
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.w, vertical: 18.h),
                      onPressed: () async {
                        final alarm = activeAlarmModel.copyWith(
                            repeat: Repeat.once,
                            time: activeAlarmModel.time.add(
                              5.minutes,
                            ));
                        await AlarmRepository.scheduleAlarm(alarm);
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setString('activeAlarmId', '0');
                        Fluttertoast.showToast(msg: 'Alarm snooze in 5 min');
                        await Future.delayed(3.seconds);
                        Navigator.popUntil(context, (route) => false);
                        await Future.delayed(200.ms);

                        exit(0);
                      },
                      child: Text(
                        'Snooze',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: context.colorScheme.onBackground),
                      )),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
