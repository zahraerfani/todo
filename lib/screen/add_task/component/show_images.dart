import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo/config/route/const.dart';
import 'package:todo/config/themes/my_drawing.dart';

class ShowImages extends StatefulWidget {
  final List<String> choosePhoto;
  final Function(int index) removeImage;
  const ShowImages(
      {Key? key, required this.choosePhoto, required this.removeImage})
      : super(key: key);

  @override
  State<ShowImages> createState() => _ShowImagesState();
}

class _ShowImagesState extends State<ShowImages> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (int index = 0; index < widget.choosePhoto.length; index++)
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: InkWell(
              onTap: () => Navigator.of(context).pushNamed(RouteName.showImage,
                  arguments: widget.choosePhoto[index]),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.file(
                      File(widget.choosePhoto[index]),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          widget.removeImage(index);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 3),
                        child: ClipOval(
                          child: Container(
                            alignment: Alignment.center,
                            width: 25,
                            height: 25,
                            color: MyColors.white,
                            child: const Icon(
                              Icons.clear,
                              color: MyColors.red,
                              size: 20,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
      ],
    );
  }
}
