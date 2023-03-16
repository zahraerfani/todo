import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:record/record.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo/Utils/upload_image.dart';
import 'package:todo/config/themes/my_drawing.dart';
import 'package:todo/data/hive/models/task.dart';
import 'package:todo/data/hive/requests/task_request.dart';
import 'package:todo/data/media_query/media_query.dart';
import 'package:todo/data/media_query/space_between.dart';
import 'package:todo/data/model/front/header_model.dart';
import 'package:todo/screen/add_task/component/audio_player.dart';
import 'package:todo/screen/add_task/component/audio_recorder.dart';
import 'package:todo/screen/add_task/component/calendar.dart';
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
                    onTab: () => calendarModal(),
                    title: "Task completion date"),
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
                        choosePhoto: choosePhoto!,
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
        context: context,
        child: Container(
            color: MyColors.white,
            width: context.width,
            height: 200,
            child: Column(
              children: [
                intermediate(20),
                ButtonLoading(
                    loading: false,
                    showBoxShadow: false,
                    onTab: () => Navigator.of(context).pop("camera"),
                    title: "Camera"),
                intermediate(20),
                ButtonLoading(
                    loading: false,
                    showBoxShadow: false,
                    onTab: () => Navigator.of(context).pop("gallery"),
                    title: "Gallery"),
              ],
            )));
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
    print("1111111111111111111");
    List<SubTask> x = [];
    x.add(SubTask(subtaskName: "subtaskName", check: true));
    print((x[0].subtaskName));
    TaskHiveRequest.addTask(Task(
      taskName: "name",
      record: "audioPath",
      note: "note",
      image: ["choosePhoto"], /*subTask: x*/
    ));
    // TaskHiveRequest.addTask(Task(
    //     taskName: name!,
    //     record: audioPath,
    //     note: note!,
    //     image: choosePhoto,
    //     subTask: x));
    // Navigator.of(context).pop();
    // } else {
    //   print("ajsdhgkjd");
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

  timeModal() {
    return ModalClass.showModalBottomPage(
        context: context,
        opacity: 0.4,
        title: "",
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors.white,
            ),
            height: context.width - 50,
            width: context.width - 50,
            child: SfDateRangePicker(
                enablePastDates: false,
                showActionButtons: true,
                onCancel: () => Navigator.pop(context),
                onSubmit: (sub) => Navigator.pop(context),
                onSelectionChanged: (DateRangePickerSelectionChangedArgs date) {
                  setState(() {
                    formattedDate = date.value.toString().substring(0, 10);
                  });
                },
                selectionMode: DateRangePickerSelectionMode.single),
          ),
        ));
  }
}