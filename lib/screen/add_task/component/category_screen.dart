import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/config/themes/my_drawing.dart';
import 'package:todo/data/hive/boxes_name.dart';
import 'package:todo/data/hive/models/category.dart';
import 'package:todo/data/media_query/space_between.dart';
import 'package:todo/screen/add_task/component/add_category.dart';
import 'package:todo/widgets/button/button_loading.dart';
import 'package:todo/widgets/modal/modal.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(HiveBoxNames.category).listenable(),
      builder: (context, Box box, widget) {
        if (box.isEmpty) {
          return const Center(
            child: Text('Empty'),
          );
        } else {
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: box.length,
                itemBuilder: (context, index) {
                  CategoryTask category = box.get(index);
                  return ListTile(
                    title: Text(
                      category.name,
                      style: TextStyle(color: Color(category.color!)),
                    ),
                    leading: Icon(
                        IconData(category.icon!, fontFamily: 'MaterialIcons')),
                    subtitle: Text(category.color.toString()),
                    iconColor: Color(category.color!),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.circle_outlined,
                      ),
                    ),
                  );
                },
              ),
              intermediate(20),
              ButtonLoading(
                loading: false,
                showBoxShadow: false,
                onTab: () => addCategoryModal(),
                title: "Add a category",
                icon: Icons.add,
              )
            ],
          );
        }
      },
    );
  }

  addCategoryModal() {
    return ModalClass.showModalBottomPage(
        context: context,
        opacity: 0.8,
        title: "New Category",
        color: MyColors.white,
        iconColor: MyColors.primaryDark,
        titleColor: MyColors.primaryDark,
        child: const AddCategory());
  }
}
