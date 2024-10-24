// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rubu.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RubuAdapter extends TypeAdapter<Rubu> {
  @override
  final int typeId = 2;

  @override
  Rubu read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Rubu().._isMemorized = fields[0] as bool?;
  }

  @override
  void write(BinaryWriter writer, Rubu obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj._isMemorized);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RubuAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
