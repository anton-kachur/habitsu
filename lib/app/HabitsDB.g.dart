// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HabitsDB.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitDataAdapter extends TypeAdapter<HabitData> {
  @override
  final int typeId = 0;

  @override
  HabitData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitData(
      fields[0] as dynamic,
      fields[1] as dynamic,
      fields[2] as dynamic,
      (fields[7] as List).cast<DayData>(),
      alarm: fields[5] as dynamic,
      frequency: fields[4] as dynamic,
      notes: fields[3] as dynamic,
      color: fields[6] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, HabitData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.measureUnit)
      ..writeByte(2)
      ..write(obj.eveyDayAim)
      ..writeByte(3)
      ..write(obj.notes)
      ..writeByte(4)
      ..write(obj.frequency)
      ..writeByte(5)
      ..write(obj.alarm)
      ..writeByte(6)
      ..write(obj.color)
      ..writeByte(7)
      ..write(obj.days);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
