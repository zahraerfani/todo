import 'package:flutter/material.dart';
import 'package:todo/config/themes/my_drawing.dart';
import 'package:todo/data/media_query/media_query.dart';
import 'package:todo/data/media_query/space_between.dart';
import 'package:todo/widgets/button/button_loading.dart';

class CameraOrGallery extends StatefulWidget {
  const CameraOrGallery({Key? key}) : super(key: key);

  @override
  State<CameraOrGallery> createState() => _CameraOrGalleryState();
}

class _CameraOrGalleryState extends State<CameraOrGallery> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: MyColors.white,
        width: context.width,
        height: 200,
        child: Column(
          children: [
            intermediate(20),
            ButtonLoading(
                loading: false,
                showBoxShadow: false,
                onTab: () => Navigator.of(context).pop("camera"),
                title: "Camera"),
            intermediate(20),
            ButtonLoading(
                loading: false,
                showBoxShadow: false,
                onTab: () => Navigator.of(context).pop("gallery"),
                title: "Gallery"),
          ],
        ));
  }
}
