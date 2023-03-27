import 'package:flutter/material.dart';
import 'package:todo/config/themes/my_drawing.dart';

class CounterUiCategory extends StatefulWidget {
  final Function() changeCounter;
  final int? number;
  const CounterUiCategory(
      {Key? key, required this.changeCounter, required this.number})
      : super(key: key);

  @override
  State<CounterUiCategory> createState() => _CounterUiCategoryState();
}

class _CounterUiCategoryState extends State<CounterUiCategory> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Stack(
        children: [
          Icon(
            widget.number != null ? Icons.circle : Icons.circle_outlined,
            size: 24,
            color: MyColors.orange,
          )
        ],
      ),
    );
  }
}
