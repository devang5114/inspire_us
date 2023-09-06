import 'dart:async';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inspire_us/common/common_repository/notification_repository.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/model/day_model.dart';
import 'package:inspire_us/common/utils/constants/repeat_enum.dart';
import 'package:inspire_us/common/utils/helper/local_database_helper.dart';
import 'package:inspire_us/features/alarm/controller/alarm_controller.dart';
import 'package:inspire_us/features/alarm/repository/alarm_api_reposioty.dart';
import 'package:inspire_us/features/audio/controller/ringtoneplayer_manager.dart';
import 'package:intl/intl.dart';
import 'package:vibration/vibration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volume_controller/volume_controller.dart';

import '../../../common/model/alarm_model.dart';

class AlarmRepository {
  static scheduleAlarmEveryDay(AlarmModel alarmModel) async {
    for (int i = 0; i < alarmModel.days.length; i++) {
      final alarmTime = alarmModel.time;
      DateTime weeklyTime = DateTime(
        alarmTime.year,
        alarmTime.month,
        alarmTime.day - alarmTime.weekday + i + 1, // Adjust day
        alarmTime.hour,
        alarmTime.minute,
      );
      final id = alarmModel.id * 10 + i;
      // Handle the case where the day addition may exceed the number of days in the month
      if (weeklyTime.month != alarmModel.time.month) {
        weeklyTime = weeklyTime.subtract(const Duration(days: 1));
      }
      print(weeklyTime);
      await setAlarm(weeklyTime, alarmModel,
          id: id, alarmName: 'Schedule Everyday');
    }
  }

  static Future<void> scheduleAlarm(AlarmModel alarmModel) async {
    if (alarmModel.repeat == Repeat.everyDay) {
      scheduleAlarmEveryDay(alarmModel);
    } else if (alarmModel.repeat == Repeat.days) {
      scheduleAlarmDayWise(alarmModel);
    } else {
      setAlarm(alarmModel.time, alarmModel, alarmName: 'Schedule Onece');
    }
  }

  static scheduleAlarmDayWise(AlarmModel alarmModel) async {
    for (int i = 0; i < alarmModel.days.length; i++) {
      final day = alarmModel.days[i];
      final alarmTime = alarmModel.time;
      if (day.isEnable) {
        // Calculate the time for this specific day
        DateTime weeklyTime = DateTime(
          alarmTime.year,
          alarmTime.month,
          alarmTime.day - alarmTime.weekday + i + 1, // Adjust day
          alarmTime.hour,
          alarmTime.minute,
        );
        final id = alarmModel.id * 10 + i;

        // Handle the case where the day addition may exceed the number of days in the month
        if (weeklyTime.month != alarmModel.time.month) {
          weeklyTime = weeklyTime.subtract(const Duration(days: 1));
        }
        await setAlarm(weeklyTime, alarmModel,
            id: id, alarmName: 'Schedule DayWise');
      }
    }
  }

  static showAlarm(int id, Map<String, dynamic> params) async {
    playAlarm(params['toneId'], params['vibration']);
    await showNotification(params['alarmId'], params['title'], params['time']);
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('activeAlarmId', params['alarmId'].toString());
    print('Alarm id in bg${params['alarmId']}');
  }

  static playAlarm(int id, bool vibration) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final VolumeController volumeController = VolumeController();

    final path = pref.getString(id.toString());
    if (path != null) {
      RingTonePlayerManager ringTonePlayerManager = RingTonePlayerManager();
      ringTonePlayerManager.init(path);
      ringTonePlayerManager.play();
      if (vibration) {
        Timer.periodic(1.seconds, (timer) {
          Vibration.vibrate(duration: 1000);
        });
      }

      volumeController.setVolume(1.0, showSystemUI: false);
    }
  }

  static showNotification(int id, String title, String time) async {
    await NotificationRepository().showAlarmNotification(id, title, time);
  }

  static cancelAlarm(AlarmModel alarmModel) async {
    if (alarmModel.repeat == Repeat.everyDay) {
      for (int i = 0; i < alarmModel.days.length; i++) {
        final id = alarmModel.id * 10 + i;
        final val = await AndroidAlarmManager.cancel(id);
        print('delete alarm $val $id');
      }
    } else if (alarmModel.repeat == Repeat.days) {
      for (int i = 0; i < alarmModel.days.length; i++) {
        final day = alarmModel.days[i];
        if (day.isEnable) {
          final id = alarmModel.id * 10 + i;
          final val = await AndroidAlarmManager.cancel(id);
          print('delete alarm $val $id');
        }
      }
    } else {
      final val = await AndroidAlarmManager.cancel(alarmModel.id);
      print('delete alarm $val ');
    }
  }

  static toggleAlarm(AlarmModel alarmModel, bool value) {
    if (value) {
      scheduleAlarm(alarmModel);
    } else {
      cancelAlarm(alarmModel);
    }
  }

  static Future<void> setAlarm(DateTime time, AlarmModel alarmModel,
      {int? id, String? alarmName}) async {
    final formater = DateFormat('hh:mm a');
    DateTime alarmTime = time;
    if (alarmTime.isBefore(DateTime.now())) {
      alarmTime = alarmTime.add(const Duration(days: 1));
    }

    final val = await AndroidAlarmManager.oneShotAt(
      alarmTime,
      id ?? alarmModel.id,
      showAlarm,
      params: {
        'alarmId': alarmModel.id,
        'toneId': alarmModel.toneId,
        'title': alarmModel.label,
        'time': formater.format(alarmTime),
        'vibration': alarmModel.vibration
      },
      exact: true,
      alarmClock: true,
      wakeup: true,
      allowWhileIdle: true,
    );
    print('$alarmName $val');
    print('time $alarmTime');
  }

  static Future<void> synchronizeAlarms(dynamic ref) async {
    ({List<AlarmModel>? alarmList, String? error}) result =
        await ref.read(alarmApiRepoProvider).getUserAlarms();
    if (result.error != null) {
      Fluttertoast.showToast(msg: 'Fail to synchronize Alarms ${result.error}');
      return;
    }
    print('synchronizeAlarms');

    List<AlarmModel> localAlarmsList =
        LocalDb.localDb.alarmBox!.values.toList();
    List<AlarmModel> serverAlarmsList = result.alarmList!;
    final localAlarmIds = localAlarmsList.map((e) => e.id).toSet();

    List<AlarmModel> newOrUpdatedAlarms = [];
    List<int> updatedAlarmIds = [];
    for (final serverAlarm in serverAlarmsList) {
      if (!localAlarmIds.contains(serverAlarm.id)) {
        //Add new alarm
        newOrUpdatedAlarms.add(serverAlarm);
        scheduleAlarm(serverAlarm);
      } else {
        final matchingLocalAlarm = localAlarmsList.firstWhere(
            (localAm) => localAm.id == serverAlarm.id,
            orElse: AlarmModel.emptyModel);
        if (matchingLocalAlarm.id != -1 &&
            !matchingLocalAlarm.isEqualTo(serverAlarm)) {
          newOrUpdatedAlarms.add(serverAlarm);
          updatedAlarmIds.add(serverAlarm.id);
        }
      }
    }

    //remove the alarm that are no longer available in server
    localAlarmsList.removeWhere((localAm) {
      return !(serverAlarmsList.any((serverAm) => serverAm.id == localAm.id));
    });
    localAlarmsList
        .removeWhere((localAlarm) => updatedAlarmIds.contains(localAlarm.id));
    print('New or updated Alarm $newOrUpdatedAlarms');
    localAlarmsList.addAll(newOrUpdatedAlarms);
    await LocalDb.localDb.clearAlarmBox();
    await LocalDb.localDb.addAllAlarms(localAlarmsList);
  }
}
