import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/data/hive/boxes_name.dart';
import 'package:todo/data/hive/models/task.dart';

class TaskHiveRequest {
  static ValueListenable<Box> getTaskList() {
    return Hive.box(HiveBoxNames.task).listenable();
  }

  static List<Task> getTaskListShow() {
    List<Task> items = Hive.box(HiveBoxNames.task).values.toList().cast();
    return items;
  }

  static deleteTask() {}

  static updateTask(int index, Task task) {
    Hive.box(HiveBoxNames.task).putAt(index, task);
  }

  static getTask() {
    Hive.box(HiveBoxNames.task).get(0);
  }

  static addTask(Task task) {
    Hive.box(HiveBoxNames.task).add(task);
  }
}
