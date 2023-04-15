import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/config/route/const.dart';
import 'package:todo/config/themes/my_drawing.dart';
import 'package:todo/data/hive/boxes_name.dart';
import 'package:todo/data/hive/models/task.dart';
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
                Task personData = box.get(index);
                return InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                      RouteName.detailTask,
                      arguments: {"myTask": personData, "index": index}),
                  child: ListTile(
                    title: Text(personData.taskName),
                    subtitle: Text(personData.note ?? ""),
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
