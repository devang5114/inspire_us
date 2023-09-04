import 'dart:math';

import 'package:hive/hive.dart';

import '../utils/constants/repeat_enum.dart';
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
  @HiveField(6)
  DateTime? createdAt;
  @HiveField(7)
  DateTime? updatedAt;
  @HiveField(8)
  final int toneId;
  @HiveField(9)
  final Repeat repeat;
  @HiveField(10)
  AlarmModel(
      {int? id,
      required this.time,
      required this.alarmSound,
      required this.days,
      this.label = 'Alarm',
      required this.isEnable,
      this.createdAt,
      this.updatedAt,
      required this.repeat,
      required this.toneId})
      : id = id ?? Random.secure().nextInt(10000 - 1000) + 1000;

  AlarmModel copyWith(
      {int? id,
      String? label,
      String? alarmSound,
      DateTime? time,
      List<Day>? days,
      bool? isEnable,
      DateTime? updatedAt,
      Repeat? repeat,
      int? toneId}) {
    return AlarmModel(
        id: id ?? this.id,
        days: days ?? this.days,
        time: time ?? this.time,
        alarmSound: alarmSound ?? this.alarmSound,
        label: label ?? this.label,
        repeat: repeat ?? this.repeat,
        toneId: toneId ?? this.toneId,
        isEnable: isEnable ?? this.isEnable,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  @override
  String toString() {
    return 'id : $id time : $time, alarmSound : $alarmSound days : $days createdAt: $createdAt updateAt: $updatedAt ';
  }
}

class Alarm {
  final int id;
  final int userId;
  final int toneId;
  final String title;
  final String timeHours;
  final String timeMinutes;
  final String timePart;
  final String repeat;
  final String sun;
  final String mon;
  final String tue;
  final String wed;
  final String thu;
  final String fri;
  final String sat;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Alarm({
    required this.id,
    required this.userId,
    required this.toneId,
    required this.title,
    required this.timeHours,
    required this.timeMinutes,
    required this.timePart,
    required this.repeat,
    required this.sun,
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
    required this.fri,
    required this.sat,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
      id: json['id'],
      userId: json['user_id'],
      toneId: json['tone_id'],
      title: json['title'],
      timeHours: json['time_hours'],
      timeMinutes: json['time_minutes'],
      timePart: json['time_part'],
      repeat: json['repeat'],
      sun: json['SUN'],
      mon: json['MON'],
      tue: json['TUE'],
      wed: json['WED'],
      thu: json['THU'],
      fri: json['FRI'],
      sat: json['SAT'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
