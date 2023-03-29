// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      taskName: fields[0] as String,
      record: fields[1] as String?,
      completion: fields[2] as String?,
      executionTime: fields[3] as String?,
      note: fields[4] as String?,
      image: (fields[5] as List?)?.cast<String?>(),
      subTask: (fields[6] as List?)?.cast<SubTask>(),
      subCategory: (fields[7] as List?)?.cast<SubCategory>(),
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.taskName)
      ..writeByte(1)
      ..write(obj.record)
      ..writeByte(2)
      ..write(obj.completion)
      ..writeByte(3)
      ..write(obj.executionTime)
      ..writeByte(4)
      ..write(obj.note)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.subTask)
      ..writeByte(7)
      ..write(obj.subCategory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SubTaskAdapter extends TypeAdapter<SubTask> {
  @override
  final int typeId = 1;

  @override
  SubTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubTask(
      subtaskName: fields[0] as String?,
      check: fields[1] as bool?,
      priority: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SubTask obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.subtaskName)
      ..writeByte(1)
      ..write(obj.check)
      ..writeByte(2)
      ..write(obj.priority);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SubCategoryAdapter extends TypeAdapter<SubCategory> {
  @override
  final int typeId = 2;

  @override
  SubCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubCategory(
      name: fields[0] as String,
      icon: fields[1] as int?,
      color: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SubCategory obj) {
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
      other is SubCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
