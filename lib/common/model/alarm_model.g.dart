// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlarmModelAdapter extends TypeAdapter<AlarmModel> {
  @override
  final int typeId = 1;

  @override
  AlarmModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlarmModel(
      id: fields[0] as int?,
      vibration: fields[10] as bool,
      time: fields[2] as DateTime,
      alarmSound: fields[4] as String,
      days: (fields[5] as List).cast<Day>(),
      label: fields[1] as String,
      isEnable: fields[3] as bool,
      createdAt: fields[6] as DateTime?,
      updatedAt: fields[7] as DateTime?,
      repeat: fields[9] as Repeat,
      toneId: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AlarmModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.isEnable)
      ..writeByte(4)
      ..write(obj.alarmSound)
      ..writeByte(5)
      ..write(obj.days)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt)
      ..writeByte(8)
      ..write(obj.toneId)
      ..writeByte(9)
      ..write(obj.repeat)
      ..writeByte(10)
      ..write(obj.vibration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlarmModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
