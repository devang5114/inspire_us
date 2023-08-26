import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inspire_us/common/model/alarm_model.dart';

import '../../model/day_model.dart';

class LocalDb {
  LocalDb._();

  static LocalDb localDb = LocalDb._();

  Future<void> addAlarm(AlarmModel alarmModel) async {
    final box = Hive.box<AlarmModel>('alarm');
    await box.add(alarmModel);
  }

  Future<void> putAtIndex(int index, AlarmModel alarmModel) async {
    final box = Hive.box<AlarmModel>('alarm');
    await box.putAt(index, alarmModel);
  }

  ValueListenable<Box<AlarmModel>> get alarmBoxListenable =>
      Hive.box<AlarmModel>('alarm').listenable();
}
