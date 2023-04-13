import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/data/hive/models/category.dart';
import 'package:todo/data/hive/models/task.dart';

class HiveHelper {
  static Future<void> initializes<T>() async {
    if (kIsWeb) {
      Hive.init("personalDb");
    } else {
      final dir = await getApplicationDocumentsDirectory();

      Directory directory = Directory(join(dir.path, "personalDb"));

      if (await directory.exists() == false) {
        try {
          await directory.create(recursive: true);
        } on Exception {
          log("error");
        }
      }
      Hive.init(directory.path);
    }

    await Hive.initFlutter();
    const secureStorage = FlutterSecureStorage();
    final encryprionKey = await secureStorage.read(key: 'key');
    if (encryprionKey == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(
        key: 'key',
        value: base64UrlEncode(key),
      );
    }

    final key = await secureStorage.read(key: 'key');
    final encryptionKey = base64Url.decode(key!);

    Hive.registerAdapter(SubTaskAdapter());
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(SubCategoryAdapter());
    await Hive.openBox(
      "subtask",
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
    await Hive.openBox(
      "task",
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
    await Hive.openBox(
      "subCategory",
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
    Hive.registerAdapter(CategoryTaskAdapter());
    await Hive.openBox(
      "category",
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
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
}
