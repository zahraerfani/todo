import 'package:flutter/material.dart';
import 'package:todo/config/themes/my_drawing.dart';
import 'package:todo/data/hive/models/task.dart';
import 'package:todo/data/media_query/space_between.dart';
import 'package:todo/data/model/front/header_model.dart';
import 'package:todo/screen/add_task/component/audio_player.dart';
import 'package:todo/screen/deatil_task/component/show_galley.dart';
import 'package:todo/screen/deatil_task/component/show_result_text.dart';
import 'package:todo/widgets/appbar/my_custom_appbar.dart';

class DetailTask extends StatefulWidget {
  final Task myTask;
  const DetailTask({Key? key, required this.myTask}) : super(key: key);

  @override
  State<DetailTask> createState() => _DetailTaskState();
}

class _DetailTaskState extends State<DetailTask> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShowResultText(
                title: "task",
                result: widget.myTask.taskName,
              ),
              ShowResultText(
                title: "description",
                result: widget.myTask.note,
              ),
              ShowResultText(
                title: "executionTime",
                result: widget.myTask.executionTime,
              ),
              ShowResultText(
                title: "date",
                result: widget.myTask.completion,
              ),
              widget.myTask.record != null
                  ? AudioPlayer(source: widget.myTask.record!)
                  : Container(),
              (widget.myTask.image != null && widget.myTask.image!.isNotEmpty)
                  ? ShowGallery(images: widget.myTask.image!)
                  : Container(),
              (widget.myTask.subTask != null &&
                      widget.myTask.subTask!.isNotEmpty)
                  ? Column(
                      children: [
                        for (int i = 0; i < widget.myTask.subTask!.length; i++)
                          Column(
                            children: [
                              intermediate(10),
                              Row(
                                children: [
                                  Icon(
                                    widget.myTask.subTask![i].check!
                                        ? Icons.check_circle
                                        : Icons.circle_outlined,
                                    color: MyColors.orange,
                                    size: 24,
                                  ),
                                  limitWidth(5),
                                  Text(
                                    widget.myTask.subTask![i].subtaskName!,
                                    style: textTheme.bodyText1,
                                  )
                                ],
                              ),
                              intermediate(10),
                            ],
                          )
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
