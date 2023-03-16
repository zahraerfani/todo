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
  Task(
      {required this.taskName,
      this.record,
      this.completion,
      this.executionTime,
      this.note,
      this.image,
      this.subTask});
  factory Task.fromJson(Map<String, dynamic> json) {
    var subData = json["subTask"] as List;
    List<SubTask> mySubTask = subData.map((i) => SubTask.fromJson(i)).toList();
    return Task(
      taskName: json["taskName"],
      completion: json["completion"],
      executionTime: json["executionTime"],
      image: json["image"],
      note: json["note"],
      record: json["record"],
      subTask: mySubTask,
    );
  }
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
  factory SubTask.fromJson(Map<String, dynamic> json) {
    return SubTask(
      subtaskName: json["subtaskName"],
      check: json["check"],
      priority: json["priority"],
    );
  }
}
