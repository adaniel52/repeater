// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduleEntryAdapter extends TypeAdapter<ScheduleEntry> {
  @override
  final int typeId = 3;

  @override
  ScheduleEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleEntry()
      .._startDate = fields[0] as DateTime
      .._reviewType = fields[1] as String
      .._reviewList = (fields[2] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as Juz, (v as List?)?.cast<Rubu>()))
      .._isCompleted = fields[3] as bool?;
  }

  @override
  void write(BinaryWriter writer, ScheduleEntry obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj._startDate)
      ..writeByte(1)
      ..write(obj._reviewType)
      ..writeByte(2)
      ..write(obj._reviewList)
      ..writeByte(3)
      ..write(obj._isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
