import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/model/alarm_model.dart';

final notificationRepoProvider =
    Provider<NotificationRepository>((ref) => NotificationRepository());

class NotificationRepository {
  FlutterRingtonePlayer flutterRingtonePlayer = FlutterRingtonePlayer();
  AwesomeNotifications awesomeNotifications = AwesomeNotifications();

  Future<void> showSimpleNotification() async {
    await awesomeNotifications.createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'schedule_channel',
            title: 'Alarm 10:30',
            body: 'Wake up',
            wakeUpScreen: true,
            ticker: 'ticker',
            locked: true,
            color: Colors.blueAccent,
            backgroundColor: Colors.teal.withOpacity(.2),
            notificationLayout: NotificationLayout.Default),
        actionButtons: [
          NotificationActionButton(
            key: 'SNOOZE',
            label: 'Snooze',
          ),
          NotificationActionButton(
            key: 'DISMISS',
            label: 'Dismiss',
          ),
        ]);
  }

  Future<void> scheduleAlarm(AlarmModel alarmModel, bool repeat) async {
    final time = alarmModel.time;
    print(time);
    await awesomeNotifications
        .createNotification(
            content: NotificationContent(
              id: 1,
              channelKey: 'schedule_channel',
              title: 'Alarm ${alarmModel.time.hour} : ${alarmModel.time.hour}',
              body: alarmModel.label,
              displayOnForeground: true,
              locked: true,
              notificationLayout: NotificationLayout.Default,
              wakeUpScreen: true,
            ),
            actionButtons: [
              NotificationActionButton(
                key: 'SNOOZE',
                label: 'Snooze',
              ),
              NotificationActionButton(
                key: 'DISMISS',
                label: 'Dismiss',
              ),
            ],
            schedule: NotificationCalendar(
              weekday: time.weekday,
              hour: time.hour,
              minute: time.minute,
              second: 0,
              millisecond: 0,
              repeats: repeat,
            ))
        .then((value) => print(value));
  }

  Future<void> requestPermission() async {
    final result = await awesomeNotifications.isNotificationAllowed();
    if (!result) {
      awesomeNotifications.requestPermissionToSendNotifications();
    }
  }

  Future<void> playAlarm() async {
    await FlutterRingtonePlayer.play(
        fromAsset: 'assets/audio/morning_alarm.mp3');
  }

  Future<void> stopAlarm() async {
    await FlutterRingtonePlayer.stop();
  }
}
