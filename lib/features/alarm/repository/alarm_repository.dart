import 'dart:async';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:inspire_us/common/common_repository/notification_repository.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/model/alarm_model.dart';

final alarmRepoProvider = Provider<AlarmRepository>((ref) {
  return AlarmRepository(ref);
});

Future<void> scheduleAlarm(AlarmModel alarmModel) async {
  // if (alarmModel.days.any((day) => day.isEnable)) {
  //   final formater = DateFormat('hh:mm a');
  //
  //   for (int i = 0; i < alarmModel.days.length; i++) {
  //     final day = alarmModel.days[i];
  //
  //     if (day.isEnable) {
  //       // Calculate the time for this specific day
  //       final DateTime alarmTime = DateTime(
  //         alarmModel.time.year,
  //         alarmModel.time.month,
  //         alarmModel.time.day + i, // Add 'i' days to the alarm time
  //         alarmModel.time.hour,
  //         alarmModel.time.minute,
  //       );
  //
  //       final val = await AndroidAlarmManager.oneShotAt(
  //         alarmTime,
  //         alarmModel.toneId,
  //         showAlarm,
  //         params: {
  //           'id': alarmModel.toneId,
  //           'title': alarmModel.label,
  //           'time': formater.format(alarmTime)
  //         },
  //         exact: true,
  //         alarmClock: true,
  //         wakeup: true,
  //         allowWhileIdle: true,
  //       );
  //
  //       print(
  //           'Scheduled alarm for ${day.name} at ${formater.format(alarmTime)}: val $val');
  //     }
  //   }
  // } else {
  final formater = DateFormat('hh:mm a');
  final val = await AndroidAlarmManager.oneShotAt(
      alarmModel.time, alarmModel.toneId, showAlarm,
      params: {
        'id': alarmModel.toneId,
        'title': alarmModel.label,
        'time': formater.format(alarmModel.time)
      },
      exact: true,
      rescheduleOnReboot: true,
      alarmClock: true,
      wakeup: true,
      allowWhileIdle: true);
  print('val $val');
  // }
}

showAlarm(int id, Map<String, dynamic> params) async {
  await playAlarm(params['id']);
  await showNotification(params['title'], params['time']);

  // AwesomeNotifications().actionStream.listen((event) {
  //   if (event.buttonKeyPressed == 'DISMISS') {
  //     // NotificationRepository().stopAlarm(audioPlayer);
  //   }
  // });
}

playAlarm(int id) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final path = pref.getString(id.toString());
  print('null');
  if (path != null) {
    print('not null');

    AudioPlayer audioPlayer = AudioPlayer()..setFilePath(path);
    audioPlayer.setLoopMode(LoopMode.all);
    audioPlayer.play();
    pref.setString('playingTune', path);
  }
}

showNotification(String title, String time) async {
  await NotificationRepository().showAlarmNotification(title, time);
}

class AlarmRepository {
  AlarmRepository(this.ref);
  Ref ref;

  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // Future<void> scheduldeAalarm(AlarmModel alarmModel) async {
  //   final val = await AndroidAlarmManager.oneShotAt(
  //       alarmModel.time, alarmModel.id, showAlarm,
  //       exact: true, alarmClock: true, wakeup: true, allowWhileIdle: true);
  //   print('val $val');
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
  // }

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
      // await scheduleAalarm(alarmModel);
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
