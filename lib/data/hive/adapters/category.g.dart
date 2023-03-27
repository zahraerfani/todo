// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryTaskAdapter extends TypeAdapter<CategoryTask> {
  @override
  final int typeId = 3;

  @override
  CategoryTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryTask(
      name: fields[0] as String,
      icon: fields[1] as int?,
      color: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryTask obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.icon)
      ..writeByte(2)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
