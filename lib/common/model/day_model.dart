import 'package:hive/hive.dart';

part 'day_model.g.dart';

@HiveType(typeId: 2)
class Day {
  @HiveField(0)
  String name;
  @HiveField(1)
  bool isEnable;
  Day({required this.name, required this.isEnable});

  @override
  String toString() {
    return 'name: $name, isEnable:$isEnable';
  }
}
