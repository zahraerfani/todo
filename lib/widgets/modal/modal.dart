import 'package:flutter/material.dart';

class ModalClass {
  static Future showModalBottomPage({
    required BuildContext context,
    required Widget child,
    double? opacity,
    String? title,
  }) async {
    final res = await showGeneralDialog(
      context: context,
      barrierDismissible:
          false, // should dialog be dismissed when tapped outside
      barrierLabel: title ?? "Modal", // label for barrier
      transitionDuration: const Duration(
          milliseconds:
              500), // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.black.withOpacity(opacity ?? 0.5),
              toolbarHeight: 60,
              centerTitle: true,
              leading: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Text(
                title ?? "Modal",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Overpass', fontSize: 20),
              ),
              elevation: 0.0),
          backgroundColor: Colors.black.withOpacity(opacity ?? 0.5),
          body: child,
        );
      },
    );
  }
}
