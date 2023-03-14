import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:todo/config/themes/my_drawing.dart';
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
                  labelText: "Task Name",
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
                            print('Recorded file path: $path');
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
                  labelText: "Add a Note",
                  validation: "required",
                  preIcon: Icons.note,
                ),
                intermediate(10),
                ButtonLoading(
                    btnWidth: context.width - 20,
                    loading: false,
                    showBoxShadow: false,
                    icon: Icons.image,
                    onTab: () {},
                    title: "Add an image"),
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

  save() {
    if (formKey.currentState!.validate()) {
      print("1111111111111111111");
    } else {
      print("ajsdhgkjd");
    }
  }
}
