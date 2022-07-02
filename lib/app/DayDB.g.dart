// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DayDB.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayDataAdapter extends TypeAdapter<DayData> {
  @override
  final int typeId = 1;

  @override
  DayData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayData(
      fields[0] as dynamic,
      todayResult: fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, DayData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.todayResult);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
