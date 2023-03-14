import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:todo/Utils/upload_image.dart';
import 'package:todo/config/route/const.dart';
import 'package:todo/config/themes/my_drawing.dart';
import 'package:todo/data/hive/models/task.dart';
import 'package:todo/data/hive/requests/task_request.dart';
import 'package:todo/data/media_query/media_query.dart';
import 'package:todo/data/media_query/space_between.dart';
import 'package:todo/data/model/front/header_model.dart';
import 'package:todo/screen/add_task/component/audio_player.dart';
import 'package:todo/screen/add_task/component/audio_recorder.dart';
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
  List<String?> choosePhoto = [];

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
                    onTab: () => ModalClass.showModalBottomPage(
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
                        )),
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
                    ? Wrap(
                        children: [
                          for (int index = 0;
                              index < choosePhoto.length;
                              index++)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: InkWell(
                                onTap: () => Navigator.of(context).pushNamed(
                                    RouteName.showImage,
                                    arguments: choosePhoto[index]!),
                                child: Stack(
                                  alignment: Alignment.topLeft,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4.0),
                                      child: Image.file(
                                        File(choosePhoto[index]!),
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            choosePhoto.removeAt(index);
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 3),
                                          child: ClipOval(
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 25,
                                              height: 25,
                                              color: MyColors.white,
                                              child: const Icon(
                                                Icons.clear,
                                                color: MyColors.red,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                        ],
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
    if (formKey.currentState!.validate() &&
        audioPath != null &&
        choosePhoto.isNotEmpty) {
      print("1111111111111111111");
      TaskHiveRequest.addTask(Task(
          taskName: name!, record: audioPath, note: note!, image: choosePhoto));
    } else {
      print("ajsdhgkjd");
    }
  }
}
