import 'package:flutter/material.dart';
import 'package:todo/config/themes/my_drawing.dart';
import 'package:todo/data/media_query/media_query.dart';
import 'package:todo/data/model/front/sub_task_model.dart';
import 'package:todo/widgets/input/custom_input.dart';

class AddSubTasks extends StatefulWidget {
  final int count;
  final SubTaskModel item;
  final Function() remove;
  final Function() changeCheck;
  final Function(String text) changeText;
  const AddSubTasks({
    Key? key,
    required this.count,
    required this.remove,
    required this.changeCheck,
    required this.item,
    required this.changeText,
  }) : super(key: key);

  @override
  State<AddSubTasks> createState() => _AddSubTasksState();
}

class _AddSubTasksState extends State<AddSubTasks> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => widget.changeCheck(),
          child: Icon(
            !widget.item.check! ? Icons.circle_outlined : Icons.check_circle,
            color: MyColors.orange,
            size: 24,
          ),
        ),
        SizedBox(
          width: context.width - 150,
          height: 50,
          child: CustomInput(
            enterData: (text) => widget.changeText(text),
            borderColor: Colors.transparent,
          ),
        ),
        InkWell(
          onTap: () => widget.remove(),
          child: const Icon(
            Icons.clear,
            color: MyColors.grey_40,
            size: 20,
          ),
        ),
        const Icon(
          Icons.list,
          color: MyColors.grey_40,
          size: 24,
        ),
      ],
    );
  }
}
