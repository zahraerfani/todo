import 'package:flutter/material.dart';
import 'package:todo/config/themes/my_drawing.dart';

class MyCustomDrawer extends StatefulWidget {
  const MyCustomDrawer({Key? key}) : super(key: key);

  @override
  State<MyCustomDrawer> createState() => _MyCustomDrawerState();
}

class _MyCustomDrawerState extends State<MyCustomDrawer> {
  List<String> data = [
    "sunday",
    "monday",
    "tuesday",
    "wednesday",
    "thursday",
    "friday",
    "saturday"
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: MyColors.grey_5,
      ),
      child: SafeArea(
          child: Drawer(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: Text(data[index]),
            );
          },
          itemCount: data.length,
        ),
      )),
    );
  }
}
