import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo/data/media_query/media_query.dart';
import 'package:todo/data/model/front/header_model.dart';
import 'package:todo/widgets/appbar/my_custom_appbar.dart';

class ShowImage extends StatelessWidget {
  final String image;
  const ShowImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        item: HeaderModel(title: "Image", icon: []),
        backButton: true,
      ),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Image.file(
            File(image),
            width: context.width - 100,
            height: context.width - 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
