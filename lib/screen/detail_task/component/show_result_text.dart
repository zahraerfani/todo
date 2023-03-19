import 'package:flutter/material.dart';
import 'package:todo/config/themes/my_drawing.dart';
import 'package:todo/data/media_query/space_between.dart';

class ShowResultText extends StatelessWidget {
  final String? result;
  final String title;
  final IconData icon;
  const ShowResultText(
      {Key? key, required this.result, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      child: result != null
          ? Column(
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: MyColors.orange,
                      size: 24,
                    ),
                    limitWidth(5),
                    Text(
                      "$title  $result",
                      style: textTheme.headline1,
                    ),
                  ],
                ),
                intermediate(20),
              ],
            )
          : Container(),
    );
  }
}
