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
}
