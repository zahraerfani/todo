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

  static deleteTask(int index) {
    // Task item = Hive.box(HiveBoxNames.task).get(index);
    // String taskName = item.taskName;
    // final Map taskMap = Hive.box(HiveBoxNames.task).toMap();
    // dynamic taskKey;
    // taskMap.forEach((key, value) {
    //   if (value.taskName == taskName) taskKey = key;
    // });
    Hive.box(HiveBoxNames.task).deleteAt(index);
  }

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
