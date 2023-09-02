import 'package:hive/hive.dart';

part 'repeat_enum.g.dart';

@HiveType(typeId: 3)
enum Repeat {
  @HiveField(0)
  once,
  @HiveField(1)
  days,
  @HiveField(2)
  everyDay
}
