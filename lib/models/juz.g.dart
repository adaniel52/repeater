// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'juz.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JuzAdapter extends TypeAdapter<Juz> {
  @override
  final int typeId = 1;

  @override
  Juz read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Juz().._fluency = fields[1] as String?;
  }

  @override
  void write(BinaryWriter writer, Juz obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._rubus)
      ..writeByte(1)
      ..write(obj._fluency);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JuzAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
