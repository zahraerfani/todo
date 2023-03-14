import 'package:hive/hive.dart';
import 'package:todo/data/hive/boxes_name.dart';
import 'package:todo/data/hive/models/task.dart';

class HiveAdapterModels {
  static final hiveModels = [
    HiveDetails(TaskAdapter(), HiveBoxNames.task),
    HiveDetails(SubTaskAdapter(), HiveBoxNames.subTask),
  ];
}

class HiveDetails<T> {
  final TypeAdapter<T> adapter;
  final String name;

  HiveDetails(this.adapter, this.name);
}
