import 'package:flutter/material.dart';
import 'package:todo/data/hive/models/category.dart';
import 'package:todo/data/hive/requests/category_request.dart';
import 'package:todo/data/media_query/space_between.dart';
import 'package:todo/screen/add_task/component/select_color.dart';
import 'package:todo/screen/add_task/component/select_icon.dart';
import 'package:todo/widgets/button/button_loading.dart';
import 'package:todo/widgets/input/custom_input.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  int colorSelect = 0xffFFBF19;
  int iconSelect = 0xe31c;
  String? iconName;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInput(
                enterData: (text) => setState(() {
                  iconName = text;
                }),
                labelText: "New Category",
                validation: "required",
              ),
              intermediate(20),
              Text(
                "Icons",
                style: textTheme.headline1,
              ),
              intermediate(20),
              SelectIcon(
                iconSelect: iconSelect,
                colorSelect: colorSelect,
                onChangeIcon: (int icon) => setState(() {
                  iconSelect = icon;
                }),
              ),
              intermediate(20),
              SelectColor(
                changeColor: (int color) => setState(() {
                  colorSelect = color;
                }),
                userColorSelect: colorSelect,
              ),
              intermediate(20),
              ButtonLoading(
                  loading: false,
                  showBoxShadow: false,
                  onTab: () => saveCategory(),
                  title: "Save")
            ],
          ),
        ),
      ),
    );
  }

  saveCategory() {
    if (formKey.currentState!.validate()) {
      CategoryHiveRequest.addCategory(
          CategoryTask(name: iconName!, icon: iconSelect, color: colorSelect));
      Navigator.of(context).pop();
    }
  }
}
