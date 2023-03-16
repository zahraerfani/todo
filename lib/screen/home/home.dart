import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/config/route/const.dart';
import 'package:todo/config/themes/my_drawing.dart';
import 'package:todo/data/hive/boxes_name.dart';
import 'package:todo/data/hive/models/task.dart';
import 'package:todo/data/hive/requests/task_request.dart';
import 'package:todo/data/model/front/header_model.dart';
import 'package:todo/screen/drawer/drawer.dart';
import 'package:todo/widgets/appbar/my_custom_appbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        item: HeaderModel(title: "Home", icon: []),
        backButton: false,
      ),
      drawer: const MyCustomDrawer(),
      body: /* Container(),*/
          ValueListenableBuilder(
        valueListenable: Hive.box(HiveBoxNames.task).listenable(),
        builder: (context, Box box, widget) {
          if (box.isEmpty) {
            return const Center(
              child: Text('Empty'),
            );
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                Task personData = box.get(index);
                return InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text(personData.taskName),
                    subtitle: Text(personData.taskName),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),

      // body: Column(
      //   children: [
      // Accordion(
      //     headerColor: MyColors.primaryDark,
      //     title: "Today",
      //     iconColor: MyColors.white,
      //     content: Text(
      //       "Today",
      //       style: textTheme.bodyText1,
      //     )),
      // Accordion(
      //     headerColor: MyColors.amber,
      //     iconColor: MyColors.white,
      //     title: "Tomorrow",
      //     content: Text(
      //       "Today",
      //       style: textTheme.bodyText1,
      //     )),
      // Accordion(
      //     headerColor: MyColors.green,
      //     iconColor: MyColors.white,
      //     title: "During the week",
      //     content: Text(
      //       "Today",
      //       style: textTheme.bodyText1,
      //     )),
      // Accordion(
      //     headerColor: MyColors.grey_40,
      //     iconColor: MyColors.white,
      //     title: "This month",
      //     content: Text(
      //       "Today",
      //       style: textTheme.bodyText1,
      //     )),
      // Accordion(
      //     headerColor: MyColors.red,
      //     iconColor: MyColors.white,
      //     title: "Later",
      //     content: Text(
      //       "Today",
      //       style: textTheme.bodyText1,
      //     )),
      // ],
      // ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.primaryDark,
          onPressed: () => Navigator.of(context).pushNamed(RouteName.addTask),
          tooltip: "Add task",
          child: const Icon(
            Icons.add,
            size: 24,
          )),
    );
  }

  add() {
    TaskHiveRequest.addTask(Task(
        taskName:
            "Second" /*, subTask: [SubTask(subtaskName: "subtaskName")]*/));
    print("OK");
  }
}