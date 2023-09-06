import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inspire_us/common/model/alarm_model.dart';
import 'package:inspire_us/common/utils/constants/repeat_enum.dart';

import '../../model/day_model.dart';

class LocalDb {
  LocalDb._();
  Box<AlarmModel>? alarmBox;
  Box? inspireUsBox;

  init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AlarmModelAdapter());
    Hive.registerAdapter(DayAdapter());
    Hive.registerAdapter(RepeatAdapter());
    inspireUsBox = await Hive.openBox('inspireUs');
    alarmBox = await Hive.openBox<AlarmModel>('alarm');
  }

  static LocalDb localDb = LocalDb._();

  Future<dynamic> getValue(String key, {dynamic defaultValue}) async {
    return await inspireUsBox!.get(key, defaultValue: defaultValue);
  }

  Future<dynamic> putValue(String key, dynamic value) async {
    await inspireUsBox!.put(key, value);
  }

  Future<void> clearAlarmBox() async {
    await alarmBox!.clear();
  }

  Future<void> addAlarm(AlarmModel alarmModel) async {
    await alarmBox!.add(alarmModel);
  }

  Future<void> addAllAlarms(List<AlarmModel> alarms) async {
    await alarmBox!.addAll(alarms);
  }

  Future<void> putAlarmAtIndex(int index, AlarmModel alarmModel) async {
    await alarmBox!.putAt(index, alarmModel);
  }

  bool inspireBoxContainKey(String key) {
    return inspireUsBox!.containsKey(key);
  }

  ValueListenable<Box<AlarmModel>> get alarmBoxListenable =>
      alarmBox!.listenable();
}
