import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/data/hive/boxes_name.dart';
import 'package:todo/data/hive/models/category.dart';

class CategoryHiveRequest {
  static ValueListenable<Box> getCategoryList() {
    return Hive.box(HiveBoxNames.category).listenable();
  }

  static List<CategoryTask>? getCategoryListShow() {
    List<CategoryTask> items =
        Hive.box(HiveBoxNames.category).values.toList().cast();
    return items;
  }

  static deleteCategory() {}
  static updateCategory(int index, CategoryTask category) {
    Hive.box(HiveBoxNames.category).putAt(index, category);
  }

  static getCategory() {
    Hive.box(HiveBoxNames.category).get(0);
  }

  static addCategory(CategoryTask category) {
    Hive.box(HiveBoxNames.category).add(category);
  }
}
