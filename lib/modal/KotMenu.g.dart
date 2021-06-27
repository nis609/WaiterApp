// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'KotMenu.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KotMenuAdapter extends TypeAdapter<KotMenu> {
  @override
  final int typeId = 2;

  @override
  KotMenu read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KotMenu(
      id: fields[4] as int,
      name: fields[5] as String,
      rate: fields[6] as double,
    );
  }

  @override
  void write(BinaryWriter writer, KotMenu obj) {
    writer
      ..writeByte(3)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.rate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KotMenuAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
