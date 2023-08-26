import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:inspire_us/common/model/alarm_model.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

import '../../../common/model/day_model.dart';
import '../../../common/utils/constants/enums.dart';
import '../../../common/utils/helper/local_database_helper.dart';
import '../repository/alarm_repository.dart';

final alarmController = ChangeNotifierProvider<AlarmController>((ref) {
  return AlarmController(ref);
});

class AlarmController extends ChangeNotifier {
  AlarmController(this.ref);

  Ref ref;
  List<AlarmModel> alarms = [];
  TextEditingController labelController = TextEditingController();
  Repeat repeat = Repeat.never;
  List<Day> days = [
    Day(name: 'Mon', isEnable: false),
    Day(name: 'Tue', isEnable: false),
    Day(name: 'Wed', isEnable: false),
    Day(name: 'Thu', isEnable: false),
    Day(name: 'Fri', isEnable: false),
    Day(name: 'Sat', isEnable: false),
    Day(name: 'Sun', isEnable: false),
  ];
  String selectedTune = 'Tune 1';
  DateTime alarmTime = DateTime.now();
  int? updateAlarmIndex;
  int? updateAlarmId;

  update(AlarmModel alarmModel, int index) {
    updateAlarmIndex = index;
    updateAlarmId = alarmModel.id;
    days = alarmModel.days;
    alarmTime = alarmModel.time;
    selectedTune = alarmModel.alarmSound;
    labelController.text = alarmModel.label;
  }

  setRepeat(Repeat val) {
    repeat = val;
    print('hiii2');
    print(repeat);

    notifyListeners();
  }

  deleteAlarm(AlarmModel alarmModel) async {
    ref.read(alarmRepoProvider).removeSchedulerAlarm(alarmModel);
  }

  reset() {
    updateAlarmId = null;
    updateAlarmIndex = null;
    labelController.clear();
    days = [
      Day(name: 'Mon', isEnable: false),
      Day(name: 'Tue', isEnable: false),
      Day(name: 'Wed', isEnable: false),
      Day(name: 'Thu', isEnable: false),
      Day(name: 'Fri', isEnable: false),
      Day(name: 'Sat', isEnable: false),
      Day(name: 'Sun', isEnable: false),
    ];
  }

  pickTime(BuildContext context) async {
    TimeOfDay initialTime =
        TimeOfDay(hour: alarmTime.hour, minute: alarmTime.minute + 1);
    final timeOfDay = await showTimePicker(
        context: context, initialTime: initialTime, helpText: 'Select Time');
    if (timeOfDay != null) {
      var time = DateTime.now();
      DateTime alTime = DateTime(
          time.year, time.month, time.day, timeOfDay.hour, timeOfDay.minute);
      alarmTime = alTime;
      notifyListeners();
    }
  }

  setDaysValue(int index, bool val) {
    days[index].isEnable = val;
    notifyListeners();
  }

  Future<void> setAlarm(BuildContext context) async {
    if (updateAlarmIndex != null) {
      AlarmModel alarmModel = AlarmModel(
          id: updateAlarmId,
          alarmSound: selectedTune,
          days: days,
          label: labelController.text == '' ? 'Alarm' : labelController.text,
          time: alarmTime,
          isEnable: true);
      await ref.read(alarmRepoProvider).removeSchedulerAlarm(alarmModel);
      await ref.read(alarmRepoProvider).scheduleAlarm(alarmModel);
      await LocalDb.localDb.putAtIndex(updateAlarmIndex!, alarmModel);
    } else {
      AlarmModel alarmModel = AlarmModel(
          days: days,
          label: labelController.text,
          alarmSound: selectedTune,
          time: alarmTime,
          isEnable: true);
      await ref.read(alarmRepoProvider).scheduleAlarm(alarmModel);
      await LocalDb.localDb.addAlarm(alarmModel);
    }
    context.pop();
    reset();
  }

  Future<void> onToggle(AlarmModel alarmModel) async {
    await ref.read(alarmRepoProvider).toggleAlarmOnOf(alarmModel);
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  @override
  void dispose() {
    labelController.dispose();
    super.dispose();
  }
}
