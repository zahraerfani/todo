import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
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
  final String? image;
  @HiveField(6)
  final List<SubTask>? subTask;
  Task(
      {required this.taskName,
      this.record,
      this.completion,
      this.executionTime,
      this.note,
      this.image,
      this.subTask});
}

@HiveType(typeId: 2)
class SubTask extends HiveObject {
  @HiveField(0)
  final String subtaskName;
  @HiveField(1)
  final bool? check;
  SubTask({required this.subtaskName, this.check});
}
