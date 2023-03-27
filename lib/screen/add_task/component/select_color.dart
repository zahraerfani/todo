import 'package:flutter/material.dart';
import 'package:todo/config/themes/my_drawing.dart';
import 'package:todo/data/const/const_data.dart';

class SelectColor extends StatefulWidget {
  final Function(int color) changeColor;
  final int userColorSelect;
  const SelectColor(
      {Key? key, required this.changeColor, required this.userColorSelect})
      : super(key: key);

  @override
  State<SelectColor> createState() => _SelectColorState();
}

class _SelectColorState extends State<SelectColor> {
  List<int> colors = ConstData.colorCode;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (int index = 0; index < colors.length; index++)
          InkWell(
            onTap: () => widget.changeColor(colors[index]),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color(colors[index]),
                    ),
                  ),
                  colors[index] == widget.userColorSelect
                      ? Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: MyColors.white,
                          ),
                        )
                      : const SizedBox(),
                  colors[index] == widget.userColorSelect
                      ? Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(colors[index]),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          )
      ],
    );
  }
}
