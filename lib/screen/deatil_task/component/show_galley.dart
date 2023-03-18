import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo/config/route/const.dart';

class ShowGallery extends StatelessWidget {
  final List<String?> images;
  const ShowGallery({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (int index = 0; index < images.length; index++)
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: InkWell(
              onTap: () => Navigator.of(context)
                  .pushNamed(RouteName.showImage, arguments: images[index]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.file(
                  File(images[index]!),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
      ],
    );
  }
}
