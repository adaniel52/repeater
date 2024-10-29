// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      lastLoginTime: fields[3] as DateTime,
    )
      .._juz = fields[0] as int?
      .._rubu = fields[1] as int?
      .._juzs = (fields[2] as List).cast<Juz>()
      .._schedules = (fields[4] as List?)?.cast<ScheduleEntry>()
      .._themeMode = fields[5] as String?
      .._colorScheme = fields[6] as int?;
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj._juz)
      ..writeByte(1)
      ..write(obj._rubu)
      ..writeByte(2)
      ..write(obj._juzs)
      ..writeByte(3)
      ..write(obj._lastLoginTime)
      ..writeByte(4)
      ..write(obj._schedules)
      ..writeByte(5)
      ..write(obj._themeMode)
      ..writeByte(6)
      ..write(obj._colorScheme);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
