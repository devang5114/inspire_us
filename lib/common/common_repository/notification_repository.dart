import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/model/alarm_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

final notificationRepoProvider =
    Provider<NotificationRepository>((ref) => NotificationRepository());

class NotificationRepository {
  FlutterRingtonePlayer flutterRingtonePlayer = FlutterRingtonePlayer();
  AwesomeNotifications awesomeNotifications = AwesomeNotifications();

  Future<void> showAlarmNotification(int id, String title, String time) async {
    await awesomeNotifications.createNotification(
        content: NotificationContent(
            id: id,
            channelKey: 'schedule_channel',
            title: 'Alarm $time',
            body: title.isEmpty ? 'Alarm is ringing' : title,
            wakeUpScreen: true,
            ticker: 'ticker',
            locked: true,
            displayOnBackground: true,
            displayOnForeground: true,
            category: NotificationCategory.Alarm,
            // showWhen: ,
            summary: 'Alarm is Ringing',
            criticalAlert: true,
            color: Colors.blueAccent,
            payload: {'alarmId': id.toString(), 'title': title, 'time': time},
            backgroundColor: Colors.teal.withOpacity(.2),
            notificationLayout: NotificationLayout.Default),
        actionButtons: [
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
              body:
                  'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
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
    // await Permission.manageExternalStorage.request();
    print(await Permission.storage.request());
    try {
      final t = await Permission.audio.request();
      print('audio permssion ${t.isGranted}');
    } catch (e) {
      print(e);
    }

    final result = await awesomeNotifications.isNotificationAllowed();
    if (!result) {
      awesomeNotifications.requestPermissionToSendNotifications();
    }
  }

  Future<void> playAlarm(AudioPlayer audioPlayer) async {
    await audioPlayer.play();
  }

  Future<void> stopAlarm(AudioPlayer audioPlayer) async {
    await audioPlayer.stop();
    // await FlutterRingtonePlayer.stop();
  }
}
