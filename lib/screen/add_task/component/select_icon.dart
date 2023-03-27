import 'package:flutter/material.dart';
import 'package:todo/config/themes/my_drawing.dart';
import 'package:todo/data/const/const_data.dart';

class SelectIcon extends StatefulWidget {
  final int iconSelect;
  final int colorSelect;
  final Function(int icon) onChangeIcon;
  const SelectIcon(
      {Key? key,
      required this.iconSelect,
      required this.colorSelect,
      required this.onChangeIcon})
      : super(key: key);

  @override
  State<SelectIcon> createState() => _SelectIconState();
}

class _SelectIconState extends State<SelectIcon> {
  List<int> icons = ConstData.iconCode;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (int index = 0; index < icons.length; index++)
          Container(
            alignment: Alignment.center,
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: widget.iconSelect != icons[index]
                    ? MyColors.white
                    : Color(widget.colorSelect),
                borderRadius: BorderRadius.circular(50)),
            child: InkWell(
              onTap: () => widget.onChangeIcon(icons[index]),
              child: Icon(
                IconData(icons[index], fontFamily: 'MaterialIcons'),
                size: 36,
                color: widget.iconSelect == icons[index]
                    ? MyColors.white
                    : Color(widget.colorSelect),
              ),
            ),
          )
      ],
    );
  }
}
