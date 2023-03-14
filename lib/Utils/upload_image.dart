import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/Utils/utils.dart';

class UploadImage {
  UploadImage._();
  Future<bool> requestPermission(type) async {
    if (type == ImageSource.gallery) {
      return await Utils.getStoragePermission();
    } else {
      return await Utils.getCameraPermission();
    }
  }

  static Future<XFile?> openImagePicker({
    required ImageSource source,
    required BuildContext context,
  }) async {
    Uint8List? imageBytes;
    XFile? choosePhoto;
    bool permission = false;
    if (!kIsWeb) {
      if (source == ImageSource.gallery) {
        permission = await Utils.getStoragePermission();
      } else {
        permission = await Utils.getCameraPermission();
      }

      if (permission) {
        ImagePicker picker = ImagePicker();
        XFile? photo = await picker.pickImage(
            source: source, maxWidth: 1500, maxHeight: 1500, imageQuality: 99);
        if (photo != null) {
          choosePhoto = photo;
          imageBytes = await photo.readAsBytes();
        }
        return choosePhoto;
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Permission'),
            duration: Duration(seconds: 1),
          ));
        }
      }
    }
    return null;
  }
}
