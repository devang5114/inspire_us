import 'dart:math';

import 'package:hive/hive.dart';
import 'package:inspire_us/features/alarm/controller/alarm_controller.dart';

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
  final bool vibration;
  AlarmModel(
      {int? id,
      required this.vibration,
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
      bool? vibration,
      List<Day>? days,
      bool? isEnable,
      DateTime? updatedAt,
      Repeat? repeat,
      int? toneId}) {
    return AlarmModel(
        id: id ?? this.id,
        days: days ?? this.days,
        vibration: vibration ?? this.vibration,
        time: time ?? this.time,
        alarmSound: alarmSound ?? this.alarmSound,
        label: label ?? this.label,
        repeat: repeat ?? this.repeat,
        toneId: toneId ?? this.toneId,
        isEnable: isEnable ?? this.isEnable,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  bool isEqualTo(AlarmModel serverAlarm) {
    return id == serverAlarm.id &&
        days == serverAlarm.days &&
        time == serverAlarm.time &&
        toneId == serverAlarm.toneId &&
        label == serverAlarm.label &&
        repeat == serverAlarm.repeat;
  }

  factory AlarmModel.emptyModel() {
    return AlarmModel(
        vibration: false,
        time: DateTime.now(),
        alarmSound: '',
        days: [],
        isEnable: true,
        repeat: Repeat.once,
        toneId: 2,
        id: -1);
  }

  factory AlarmModel.fromJson(Map<String, dynamic> json) {
    String timePart = json['time_part'] ?? 'AM';
    int hours = int.parse(json['time_hours']);
    if (timePart == 'PM') {
      hours += 12;
    }
    return AlarmModel(
      id: json['id'],
      label: json['title'] ?? 'Alarm',
      time: DateTime(
        DateTime.now().year, // Assuming current year
        DateTime.now().month, // Assuming current month
        DateTime.now().day, // Assuming current day
        hours,
        int.parse(json['time_minutes']),
      ),
      isEnable: json['status'] == 'ACTIVE',
      alarmSound: json['alarm_sound'] ?? '',
      days: _parseDays(json),
      repeat: _parseRepeat(json['repeat']),
      toneId: json['tone_id'],
      vibration: false,
      createdAt: DateTime.tryParse(json['created_at']),
      updatedAt: DateTime.tryParse(json['updated_at']),
    );
  }
  static List<Day> _parseDays(Map<String, dynamic> json) {
    final repeat = _parseRepeat(json['repeat']);
    if (repeat == Repeat.everyDay) {
      return activeDays;
    } else if (repeat == Repeat.once) {
      return emptyDays;
    }
    return [
      Day(name: 'Mon', isEnable: json['MON'] == '1'),
      Day(name: 'Tue', isEnable: json['TUE'] == '1'),
      Day(name: 'Wed', isEnable: json['WED'] == '1'),
      Day(name: 'Thu', isEnable: json['THU'] == '1'),
      Day(name: 'Fri', isEnable: json['FRI'] == '1'),
      Day(name: 'Sat', isEnable: json['SAT'] == '1'),
      Day(name: 'Sun', isEnable: json['SUN'] == '1'),
    ];
  }

  static Repeat _parseRepeat(String repeatValue) {
    switch (repeatValue) {
      case 'ONCE':
        return Repeat.once;
      case 'DAYS':
        return Repeat.days;
      default:
        return Repeat.once;
    }
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
