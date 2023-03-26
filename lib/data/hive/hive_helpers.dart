import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/data/hive/models/category.dart';
import 'package:todo/data/hive/models/task.dart';

// for building database -> flutter packages pub run build_runner build

class HiveHelper {
  // late String name;
  //
  // HiveHelper(this.name);

  static Future<void> initializes<T>(/*List<HiveDetails<T>> hives*/) async {
    if (kIsWeb) {
      Hive.init("personalDb");
    } else {
      final dir = await getApplicationDocumentsDirectory();

      Directory directory = Directory(join(dir.path, "personalDb"));

      if (await directory.exists() == false) {
        try {
          await directory.create(recursive: true);
        } on Exception {
          log("u have error");
        }
      }
      Hive.init(directory.path);
    }

    await Hive.initFlutter();

    Hive.registerAdapter(SubTaskAdapter());
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(CategoryTaskAdapter());
    await Hive.openBox("subtask");
    await Hive.openBox("task");
    await Hive.openBox("category");

    // for (final element in HiveAdapterModels.hiveModels) {
    //   Hive.registerAdapter(element.adapter);
    //   await Hive.openBox(element.name);
    // }
  }

  static void close(String name) async {
    Hive.close();
  }

  static void open(String name) async {
    final dir = await getApplicationDocumentsDirectory();

    Directory directory = Directory(join(dir.path, "db"));
    if (!Hive.isBoxOpen(name)) {
      await Hive.openBox(name, path: join(directory.path, name));
    }
  }
//
// T getRecord<T>(Object key) {
//   final box = Hive.box(name);
//
//   return box.get(key) as T;
// }
//
// List getRecords() {
//   final box = Hive.box(name);
//   List result = box.values.toList();
//
//   return result;
// }
//
// Future<bool> put<T>(Object key, T value) async {
//   bool status = false;
//
//   try {
//     final box = Hive.box(name);
//     await box.put(key, value).whenComplete(() {
//       status = true;
//     });
//   } on Exception catch (e) {
//     log(e.toString());
//     status = false;
//   }
//
//   return status;
// }
//
// Future<bool> delete<T>(Object key) async {
//   final box = Hive.box(name);
//   bool status = false;
//
//   await box.delete(key).whenComplete(() {
//     status = true;
//   }).onError((error, stackTrace) {
//     status = false;
//   });
//
//   return status;
// }
}
