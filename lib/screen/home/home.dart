import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/config/route/const.dart';
import 'package:todo/config/themes/my_drawing.dart';
import 'package:todo/data/hive/boxes_name.dart';
import 'package:todo/data/hive/models/task.dart';
import 'package:todo/data/hive/requests/task_request.dart';
import 'package:todo/data/model/front/header_model.dart';
import 'package:todo/screen/drawer/drawer.dart';
import 'package:todo/widgets/appbar/my_custom_appbar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        item: HeaderModel(title: "My Task List", icon: []),
        backButton: false,
      ),
      drawer: const MyCustomDrawer(),
      body: ValueListenableBuilder(
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
                Task taskData = box.getAt(index);
                return InkWell(
                  onTap: () => Navigator.of(context)
                      .pushNamed(RouteName.detailTask, arguments: index),
                  child: ListTile(
                    title: Text(taskData.taskName),
                    subtitle: Text(taskData.note ?? ""),
                    trailing: IconButton(
                      onPressed: () => TaskHiveRequest.deleteTask(index),
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
}
