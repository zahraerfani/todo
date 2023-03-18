import 'package:permission_handler/permission_handler.dart';

class Utils {
  Utils._();
  static Future<bool> getStoragePermission() async {
    final status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> getCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  static String showSelectTime({required int hour, required int min}) {
    String hh = "0";
    String mm = "0";
    hour < 10 ? hh = "0$hour" : hh = hour.toString();
    min < 10 ? mm = "0$min" : mm = min.toString();
    return "$hh : $mm";
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
