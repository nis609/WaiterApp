// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getKotMenu.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class getKotMenuAdapter extends TypeAdapter<getKotMenu> {
  @override
  final int typeId = 1;

  @override
  getKotMenu read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return getKotMenu(
      message: fields[0] as String,
      statusCode: fields[1] as int,
      token: fields[2] as String,
      data: (fields[3] as List)?.cast<KotMenu>(),
    );
  }

  @override
  void write(BinaryWriter writer, getKotMenu obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.statusCode)
      ..writeByte(2)
      ..write(obj.token)
      ..writeByte(3)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is getKotMenuAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
