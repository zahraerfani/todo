import 'package:flutter/material.dart';
import 'package:todo/data/media_query/space_between.dart';

class ShowResultText extends StatelessWidget {
  final String? result;
  final String title;
  const ShowResultText({Key? key, required this.result, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      child: result != null
          ? Column(
              children: [
                Text(
                  "$title : $result",
                  style: textTheme.headline1,
                ),
                intermediate(10),
              ],
            )
          : Container(),
    );
  }
}
