import 'dart:typed_data';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:timezone/timezone.dart';

import '../../../common/model/alarm_model.dart';

final alarmRepoProvider = Provider<AlarmRepository>((ref) {
  return AlarmRepository();
});

class AlarmRepository {
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  Future<void> scheduleAlarm(AlarmModel alarmModel) async {
    // print('schedule Alarm');
    // DateTime alarmTime = alarmModel.time;
    // if (alarmTime.isBefore(DateTime.now())) {
    //   print('alarm is before');
    //   alarmTime = alarmTime.add(const Duration(days: 1));
    //   print(alarmTime);
    // }
    // final androidNotificationDetails = AndroidNotificationDetails(
    //     '\$id', 'Waikey Alarms',
    //     sound: const RawResourceAndroidNotificationSound('alarm_sound'),
    //     importance: Importance.max,
    //     priority: Priority.high,
    //     additionalFlags: Int32List.fromList([4]),
    //     fullScreenIntent: true,
    //     enableLights: true,
    //     visibility: NotificationVisibility.public,
    //     ticker: 'ticker',
    //     icon: 'alarm',
    //     playSound: true);
    //
    // const darwinNotificationDetails = DarwinNotificationDetails(
    //   presentAlert: true,
    //   presentSound: true,
    //   sound: 'alarm.aiff',
    // );
    //
    // final notificationDetails = NotificationDetails(
    //     android: androidNotificationDetails, iOS: darwinNotificationDetails);
    // final body = alarmModel.label == '' ? 'Alarm' : alarmModel.label;
    //
    // if (!alarmModel.days.any((day) => day.isEnable)) {
    //   print('hii from single alarm');
    //   await flutterLocalNotificationsPlugin.zonedSchedule(
    //     alarmModel.id,
    //     '${alarmTime.hour} : ${alarmTime.minute}',
    //     body,
    //     TZDateTime.from(alarmTime, local),
    //     notificationDetails,
    //     uiLocalNotificationDateInterpretation:
    //         UILocalNotificationDateInterpretation.absoluteTime,
    //     androidScheduleMode: AndroidScheduleMode.alarmClock,
    //     payload: '${alarmTime.hour} : ${alarmTime.minute} ',
    //     androidAllowWhileIdle: true,
    //   );
    // } else {
    //   for (int i = 0; i < alarmModel.days.length; i++) {
    //     if (alarmModel.days[i].isEnable) {
    //       print('hiiidsdssd');
    //       final weeklyTime = DateTime(
    //         alarmTime.year,
    //         alarmTime.month,
    //         alarmTime.day - alarmTime.weekday + i + 1, // Adjust day
    //         alarmTime.hour,
    //         alarmTime.minute,
    //       );
    //       await flutterLocalNotificationsPlugin.zonedSchedule(
    //         // Use a unique id for each scheduled notification
    //         alarmModel.id * 10 + i,
    //         '${alarmTime.hour} : ${alarmTime.minute}',
    //         body,
    //         TZDateTime.from(weeklyTime, local),
    //         notificationDetails,
    //         androidAllowWhileIdle: true,
    //         uiLocalNotificationDateInterpretation:
    //             UILocalNotificationDateInterpretation.absoluteTime,
    //         matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    //       );
    //     }
    //   }
    // }
  }

  Future<void> removeSchedulerAlarm(AlarmModel alarmModel) async {
    // print('hireeei');
    // final List<PendingNotificationRequest> pendingNotificationRequest =
    //     await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    // if (alarmModel.days.any((day) => day.isEnable)) {
    //   for (var notification in pendingNotificationRequest) {
    //     if ((notification.id / 10).floor() == alarmModel.id) {
    //       await flutterLocalNotificationsPlugin.cancel(notification.id);
    //     }
    //     print('from remove shcedular $notification');
    //   }
    // } else {
    //   flutterLocalNotificationsPlugin.cancel(alarmModel.id);
    // }
  }

  Future<void> toggleAlarmOnOf(AlarmModel alarmModel) async {
    print('hii');
    if (alarmModel.isEnable) {
      await removeSchedulerAlarm(alarmModel);
    } else {
      await scheduleAlarm(alarmModel);
    }
  }

  requestNotificationPermission() async {
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.requestPermission();
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         IOSFlutterLocalNotificationsPlugin>()
    //     ?.requestPermissions();
  }
}
