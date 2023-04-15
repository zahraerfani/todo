import 'package:flutter/material.dart';
import 'package:todo/data/hive/models/task.dart';
import 'package:todo/data/media_query/space_between.dart';

class ShowTags extends StatelessWidget {
  final List<SubCategory>? items;
  const ShowTags({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return (items != null && items!.isNotEmpty)
        ? Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              for (int index = 0; index < items!.length; index++)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      IconData(items![index].icon!,
                          fontFamily: 'MaterialIcons'),
                      color: Color(items![index].color!),
                    ),
                    limitWidth(10),
                    Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Color(items![index].color!),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          items![index].name,
                          style: textTheme.bodyText2,
                        ),
                      ),
                    ),
                    limitWidth(10)
                  ],
                ),
            ],
          )
        : Container();
  }
}
