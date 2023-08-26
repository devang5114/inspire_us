import 'dart:math';

import 'package:hive/hive.dart';

import 'day_model.dart';

part 'alarm_model.g.dart';

@HiveType(typeId: 1)
class AlarmModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String label;

  @HiveField(2)
  final DateTime time;

  @HiveField(3)
  final bool isEnable;
  @HiveField(4)
  final String alarmSound;
  @HiveField(5)
  final List<Day> days;

  AlarmModel(
      {int? id,
      required this.time,
      required this.alarmSound,
      required this.days,
      this.label = 'Alarm',
      required this.isEnable})
      : id = id ?? Random.secure().nextInt(10000 - 1000) + 1000;

  AlarmModel copyWith({
    String? label,
    String? alarmSound,
    DateTime? time,
    List<Day>? days,
    bool? isEnable,
  }) {
    return AlarmModel(
      id: id,
      days: days ?? this.days,
      time: time ?? this.time,
      alarmSound: alarmSound ?? this.alarmSound,
      label: label ?? this.label,
      isEnable: isEnable ?? this.isEnable,
    );
  }

  @override
  String toString() {
    return 'id : $id time : $time, alarmSound : $alarmSound days : $days  ';
  }
}
