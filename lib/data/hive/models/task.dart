import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part '../adapters/task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String taskName;
  @HiveField(1)
  final String? record;
  @HiveField(2)
  final String? completion;
  @HiveField(3)
  final String? executionTime;
  @HiveField(4)
  final String? note;
  @HiveField(5)
  final List<String?>? image;
  @HiveField(6)
  final List<SubTask>? subTask;
  @HiveField(7)
  final List<SubCategory>? subCategory;
  Task(
      {required this.taskName,
      this.record,
      this.completion,
      this.executionTime,
      this.note,
      this.image,
      this.subTask,
      this.subCategory});

  Task copyWith({
    String? taskName,
    String? record,
    String? completion,
    String? executionTime,
    String? note,
    List<String?>? image,
    List<SubTask>? subTask,
    List<SubCategory>? subCategory,
  }) {
    return Task(
        taskName: taskName ?? this.taskName,
        record: record ?? this.record,
        completion: completion ?? this.completion,
        executionTime: executionTime ?? this.executionTime,
        note: note ?? this.note,
        image: image ?? this.image,
        subTask: subTask ?? this.subTask,
        subCategory: subCategory ?? this.subCategory);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Task &&
        other.taskName == taskName &&
        other.record == record &&
        listEquals(other.subTask, subTask) &&
        other.completion == completion &&
        other.executionTime == executionTime &&
        other.note == note &&
        listEquals(other.image, image) &&
        listEquals(other.subCategory, subCategory);
  }

  @override
  int get hashCode =>
      taskName.hashCode ^
      record.hashCode ^
      subTask.hashCode ^
      completion.hashCode ^
      executionTime.hashCode ^
      note.hashCode ^
      image.hashCode ^
      subCategory.hashCode;
}

@HiveType(typeId: 1)
class SubTask extends HiveObject {
  @HiveField(0)
  final String? subtaskName;
  @HiveField(1)
  final bool? check;
  @HiveField(2)
  final int? priority;
  SubTask({this.subtaskName, this.check, this.priority});

  SubTask copyWith({
    String? subtaskName,
    bool? check,
    int? priority,
  }) {
    return SubTask(
      subtaskName: subtaskName ?? this.subtaskName,
      check: check ?? this.check,
      priority: priority ?? this.priority,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubTask &&
        other.subtaskName == subtaskName &&
        other.check == check &&
        other.priority == priority;
  }

  @override
  int get hashCode => subtaskName.hashCode ^ check.hashCode ^ priority.hashCode;
}

@HiveType(typeId: 2)
class SubCategory extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int? icon;
  @HiveField(2)
  final int? color;
  SubCategory({
    required this.name,
    required this.icon,
    required this.color,
  });
  SubCategory copyWith({
    String? name,
    int? icon,
    int? color,
  }) {
    return SubCategory(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubCategory &&
        other.name == name &&
        other.icon == icon &&
        other.color == color;
  }

  @override
  int get hashCode => name.hashCode ^ icon.hashCode ^ color.hashCode;
}
