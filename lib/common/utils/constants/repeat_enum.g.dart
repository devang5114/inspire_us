// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repeat_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RepeatAdapter extends TypeAdapter<Repeat> {
  @override
  final int typeId = 3;

  @override
  Repeat read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Repeat.once;
      case 1:
        return Repeat.days;
      case 2:
        return Repeat.everyDay;
      default:
        return Repeat.once;
    }
  }

  @override
  void write(BinaryWriter writer, Repeat obj) {
    switch (obj) {
      case Repeat.once:
        writer.writeByte(0);
        break;
      case Repeat.days:
        writer.writeByte(1);
        break;
      case Repeat.everyDay:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepeatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
