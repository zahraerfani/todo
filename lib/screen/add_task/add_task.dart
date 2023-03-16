import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:record/record.dart';
import 'package:todo/Utils/upload_image.dart';
import 'package:todo/Utils/utils.dart';
import 'package:todo/config/themes/my_drawing.dart';
import 'package:todo/data/hive/models/task.dart';
import 'package:todo/data/hive/requests/task_request.dart';
import 'package:todo/data/media_query/media_query.dart';
import 'package:todo/data/media_query/space_between.dart';
import 'package:todo/data/model/front/header_model.dart';
import 'package:todo/data/model/front/sub_task_model.dart';
import 'package:todo/screen/add_task/component/audio_player.dart';
import 'package:todo/screen/add_task/component/audio_recorder.dart';
import 'package:todo/screen/add_task/component/calendar.dart';
import 'package:todo/screen/add_task/component/camera_or_gallery.dart';
import 'package:todo/screen/add_task/component/show_images.dart';
import 'package:todo/widgets/appbar/my_custom_appbar.dart';
import 'package:todo/widgets/button/button_loading.dart';
import 'package:todo/widgets/input/custom_input.dart';
import 'package:todo/widgets/modal/modal.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String? name;
  String? note;
  final formKey = GlobalKey<FormState>();
  final record = Record();
  bool recordAudio = false;
  String? audioPath;
  List<String> choosePhoto = [];
  String? time;
  List<SubTaskModel> items = [
    SubTaskModel(subtaskName: null, check: false, priority: 0)
  ];

  int count = 0;

  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    permission();
    super.initState();
  }

  permission() async {
    if (await record.hasPermission() && recordAudio) {
      await record.start(
        path: 'aFullPath/myFile.m4a',
        encoder: AudioEncoder.aacLc, // by default
        bitRate: 128000, // by default
        samplingRate: 44100, // by default
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: MyCustomAppBar(
        item: HeaderModel(title: "Add Task", icon: []),
        backButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomInput(
                  enterData: (text) {
                    setState(() {
                      name = text;
                    });
                  },
                  labelText: "Task name",
                  validation: "required",
                  preIcon: Icons.task,
                ),
                intermediate(10),
                ButtonLoading(
                    btnWidth: context.width - 20,
                    loading: false,
                    showBoxShadow: false,
                    icon: Icons.arrow_forward_sharp,
                    onTab: () => addSubtask(),
                    title: "Add a subtask"),
                // intermediate(10),
                count > 0
                    ? Column(
                        children: [
                          for (int index = 0; index < count; index++)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => setState(() => items[index]
                                      .check = !items[index].check!),
                                  child: Icon(
                                    !items[index].check!
                                        ? Icons.circle_outlined
                                        : Icons.check_circle,
                                    color: MyColors.orange,
                                    size: 24,
                                  ),
                                ),
                                SizedBox(
                                  width: context.width - 150,
                                  height: 50,
                                  child: CustomInput(
                                    enterData: (text) => setState(
                                        () => items[index].subtaskName = text),
                                    labelText: "Subtask name",
                                    borderColor: Colors.transparent,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      count -= 1;
                                      items.removeAt(index);
                                    });
                                  },
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
                            )
                        ],
                      )
                    : Container(),
                intermediate(10),

                ButtonLoading(
                    btnWidth: context.width - 20,
                    loading: false,
                    showBoxShadow: false,
                    icon: Icons.mic,
                    onTab: () => audioModal(),
                    title: "Add an audio recording"),
                audioPath != null
                    ? Column(
                        children: [
                          intermediate(10),
                          AudioPlayer(
                            source: audioPath!,
                            onDelete: () {
                              setState(() => audioPath = null);
                            },
                          ),
                        ],
                      )
                    : Container(),
                intermediate(10),
                ButtonLoading(
                    btnWidth: context.width - 20,
                    loading: false,
                    showBoxShadow: false,
                    icon: Icons.calendar_month,
                    onTab: () => calendarModal(),
                    title: "Task completion date"),
                intermediate(10),
                Container(
                  width: context.width - 45,
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    formattedDate,
                    style: textTheme.caption?.copyWith(fontSize: 14),
                  ),
                ),
                intermediate(10),
                ButtonLoading(
                    btnWidth: context.width - 20,
                    loading: false,
                    showBoxShadow: false,
                    icon: Icons.watch_later_outlined,
                    onTab: () => timeModal(),
                    title: "Task execution time"),
                // intermediate(10),
                time != null
                    ? Container(
                        width: context.width - 45,
                        height: 40,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          time!,
                          style: textTheme.caption?.copyWith(fontSize: 14),
                        ),
                      )
                    : Container(),
                intermediate(10),
                CustomInput(
                  enterData: (text) {
                    setState(() {
                      note = text;
                    });
                  },
                  labelText: "Add a note",
                  validation: "required",
                  preIcon: Icons.note,
                ),
                intermediate(10),
                ButtonLoading(
                    btnWidth: context.width - 20,
                    loading: false,
                    showBoxShadow: false,
                    icon: Icons.image,
                    onTab: () => chooseImageSource(),
                    title: "Add an image"),
                intermediate(20),
                choosePhoto.isNotEmpty
                    ? ShowImages(
                        choosePhoto: choosePhoto,
                        removeImage: (int index) => choosePhoto.removeAt(index),
                      )
                    : Container(),
                intermediate(20),
                ButtonLoading(
                    btnColor: MyColors.primaryDark,
                    btnWidth: context.width - 20,
                    loading: false,
                    showBoxShadow: false,
                    onTab: () => save(),
                    title: "Save"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  chooseImageSource() async {
    final res = await ModalClass.showModalBottomCustomSheet(
        context: context, child: const CameraOrGallery());
    if (res != null && context.mounted) {
      final result = await UploadImage.openImagePicker(
          source: res == "camera" ? ImageSource.camera : ImageSource.gallery,
          context: context);
      if (result != null) {
        setState(() {
          choosePhoto.add(result.path);
        });
      }
    }
  }

  save() {
    // if (formKey.currentState!.validate() &&
    //     audioPath != null &&
    //     choosePhoto.isNotEmpty) {
    List<SubTaskModel> copyItems = [];
    for (int i = 0; i < items.length; i++) {
      if (items[i].subtaskName != null) {
        copyItems.add(items[i]);
      }
    }
    print("1111111111111111111");
    List<SubTask> subtaskList = <SubTask>[];
    if (copyItems.isNotEmpty) {
      for (int i = 0; i < copyItems.length; i++) {
        subtaskList.add(SubTask(
            subtaskName: copyItems[i].subtaskName,
            check: copyItems[i].check,
            priority: copyItems[i].priority));
      }
    }
    // print((x[0].subtaskName));
    TaskHiveRequest.addTask(Task(
        taskName: "name",
        record: "audioPath",
        note: "note",
        image: ["choosePhoto"],
        subTask: subtaskList));
    // TaskHiveRequest.addTask(Task(
    //     taskName: name!,
    //     record: audioPath,
    //     note: note!,
    //     image: choosePhoto,
    //     subTask: x));
    // Navigator.of(context).pop();
    // } else {
    //   print("null");
    // }
  }

  audioModal() {
    return ModalClass.showModalBottomPage(
        context: context,
        opacity: 0.8,
        title: "record",
        child: AudioRecorder(
          onStop: (path) {
            setState(() {
              audioPath = path;
              recordAudio = true;
            });
          },
        ));
  }

  calendarModal() {
    return ModalClass.showModalBottomPage(
        context: context,
        opacity: 0.4,
        title: "",
        child: Calendar(
          onSubmit: (String date) => setState(
            () => formattedDate = date.toString().substring(0, 10),
          ),
        ));
  }

  timeModal() async {
    final res = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 7, minute: 15),
    );
    if (res != null) {
      String result = Utils.showSelectTime(
          hour: int.parse(res.hour.toString()),
          min: int.parse(res.minute.toString()));
      setState(() => time = result);
    }
  }

  addSubtask() {
    setState(() {
      count += 1;
      items.add(SubTaskModel(subtaskName: null, check: false, priority: count));
    });
  }
}
