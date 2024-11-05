// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maqra.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MaqraAdapter extends TypeAdapter<Maqra> {
  @override
  final int typeId = 2;

  @override
  Maqra read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Maqra()
      .._isMemorized = fields[0] as bool?
      .._isReviewed = fields[1] as bool?;
  }

  @override
  void write(BinaryWriter writer, Maqra obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._isMemorized)
      ..writeByte(1)
      ..write(obj._isReviewed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MaqraAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
