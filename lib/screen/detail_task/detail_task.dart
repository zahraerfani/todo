import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/Utils/utils.dart';
import 'package:todo/data/hive/boxes_name.dart';
import 'package:todo/data/hive/models/task.dart';
import 'package:todo/data/hive/requests/task_request.dart';
import 'package:todo/data/media_query/space_between.dart';
import 'package:todo/data/model/front/header_model.dart';
import 'package:todo/data/model/front/sub_task_model.dart';
import 'package:todo/screen/add_task/component/audio_player.dart';
import 'package:todo/screen/detail_task/component/show_result_text.dart';
import 'package:todo/screen/detail_task/component/show_subtask.dart';
import 'package:todo/widgets/appbar/my_custom_appbar.dart';
import 'package:todo/widgets/show_tags/show_tags.dart';

import 'component/show_galley.dart';

class DetailTask extends StatelessWidget {
  final int index;
  const DetailTask({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: MyCustomAppBar(
        item: HeaderModel(title: "Task Detail", icon: []),
        backButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          child: ValueListenableBuilder(
            valueListenable: Hive.box(HiveBoxNames.task).listenable(),
            builder: (context, Box box, widget) {
              Task taskData = box.getAt(index);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskData.taskName.capitalize(),
                    style: textTheme.headlineLarge,
                  ),
                  intermediate(20),
                  (taskData.subTask != null && taskData.subTask!.isNotEmpty)
                      ? ShowSubtask(
                          task: taskData,
                          update: (int i) => _updateTask(i, index, taskData),
                        )
                      : Container(),
                  intermediate(20),
                  ShowTags(
                    items: taskData.subCategory,
                  ),
                  intermediate(10),
                  ShowResultText(
                    title: "",
                    result: taskData.note,
                    icon: Icons.description,
                  ),
                  ShowResultText(
                    title: "executionTime",
                    result: taskData.executionTime,
                    icon: Icons.hourglass_bottom,
                  ),
                  ShowResultText(
                    title: "Task completion",
                    result: taskData.completion,
                    icon: Icons.calendar_month,
                  ),
                  intermediate(20),
                  taskData.record != null
                      ? AudioPlayer(source: taskData.record!)
                      : Container(),
                  intermediate(20),
                  (taskData.image != null && taskData.image!.isNotEmpty)
                      ? ShowGallery(images: taskData.image!)
                      : Container(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _updateTask(int subIndex, int index, Task editedTask) {
    List<SubTaskModel> model = [];
    for (int i = 0; i < editedTask.subTask!.length; i++) {
      model.add(SubTaskModel(
          subtaskName: editedTask.subTask![i].subtaskName,
          check: i == subIndex
              ? !editedTask.subTask![i].check!
              : editedTask.subTask![i].check,
          priority: editedTask.subTask![i].priority));
    }
    List<SubTask> subtaskList = <SubTask>[];
    for (int i = 0; i < model.length; i++) {
      subtaskList.add(SubTask(
          subtaskName: model[i].subtaskName,
          check: model[i].check,
          priority: model[i].priority));
    }
    Task changeTasK = Task(
        taskName: editedTask.taskName,
        image: editedTask.image,
        note: editedTask.note,
        executionTime: editedTask.executionTime,
        completion: editedTask.completion,
        record: editedTask.record,
        subTask: subtaskList,
        subCategory: editedTask.subCategory);
    TaskHiveRequest.updateTask(index, changeTasK);
  }
}
