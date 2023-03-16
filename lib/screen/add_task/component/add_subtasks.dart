// import 'package:flutter/material.dart';
// import 'package:todo/config/themes/my_drawing.dart';
// import 'package:todo/data/media_query/media_query.dart';
// import 'package:todo/data/media_query/space_between.dart';
// import 'package:todo/data/model/front/sub_task.dart';
// import 'package:todo/widgets/input/custom_input.dart';
//
// class AddSubTasks extends StatefulWidget {
//   final int count;
//   final Function(int index) remove;
//   const AddSubTasks({Key? key, required this.count, required this.remove})
//       : super(key: key);
//
//   @override
//   State<AddSubTasks> createState() => _AddSubTasksState();
// }
//
// class _AddSubTasksState extends State<AddSubTasks> {
//   SubTask items = SubTask();
//
//   @override
//   void initState() {
//     setState(() {
//       items = SubTask(check: false, name: null, priority: widget.count);
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             InkWell(
//               onTap: () => setState(() => items.check = !items.check!),
//               child: Icon(
//                 items.check! == false
//                     ? Icons.circle_outlined
//                     : Icons.check_circle,
//                 color: MyColors.orange,
//                 size: 24,
//               ),
//             ),
//             SizedBox(
//               width: context.width - 150,
//               height: 50,
//               child: CustomInput(
//                 enterData: (text) => setState(() => items.name = text),
//                 labelText: "Subtask name",
//                 borderColor: Colors.transparent,
//               ),
//             ),
//             InkWell(
//               onTap: () => widget.remove(widget.count),
//               child: const Icon(
//                 Icons.clear,
//                 color: MyColors.grey_40,
//                 size: 20,
//               ),
//             ),
//             const Icon(
//               Icons.list,
//               color: MyColors.grey_40,
//               size: 24,
//             ),
//           ],
//         ),
//         intermediate(10)
//       ],
//     );
//   }
// }
