import 'package:flutter/material.dart';
import 'package:todo/config/themes/my_drawing.dart';
import 'package:todo/data/model/front/header_model.dart';

class MyCustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final HeaderModel item;
  final bool backButton;
  final Color? background;
  final Color? cartIcon;
  final Color? sortIcon;
  final Color? badgeContentColor;
  final PreferredSizeWidget? bottom;
  final Function()? backFromScreen;
  final Function()? actionFunction;
  @override
  Size get preferredSize => bottom != null
      ? const Size.fromHeight(120.0)
      : const Size.fromHeight(60.0);

  const MyCustomAppBar(
      {Key? key,
      required this.item,
      required this.backButton,
      this.background,
      this.cartIcon,
      this.sortIcon,
      this.badgeContentColor,
      this.bottom,
      this.backFromScreen,
      this.actionFunction})
      : super(key: key);

  @override
  State<MyCustomAppBar> createState() => _MyCustomAppBarState();
}

class _MyCustomAppBarState extends State<MyCustomAppBar> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: widget.background ?? MyColors.primaryDark,
      elevation: 0,
      bottom: widget.bottom,
      centerTitle: true,
      leading: widget.backButton
          ? IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 24,
                color: MyColors.white,
              ))
          : Container(),
      title: Text(
        widget.item.title!,
        style: textTheme.headline1?.copyWith(color: MyColors.nearlyWhite),
      ),
      actions: [
        for (int index = 0; index < widget.item.icon!.length; index++)
          Stack(
            alignment: Alignment.center,
            children: [
              Builder(
                builder: (BuildContext context) => IconButton(
                    onPressed: () => widget.actionFunction!(),
                    icon: Icon(
                      widget.item.icon![index].name,
                      color: widget.cartIcon ?? MyColors.nearlyWhite,
                      size: 24,
                    )),
              ),
              widget.item.icon![index].hasBadge == true
                  ? Container(
                      height: 18,
                      width: 18,
                      margin: const EdgeInsets.only(top: 15.0, left: 15.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: widget.badgeContentColor ?? MyColors.red,
                      ),
                      child: Text(
                        "1",
                        style: textTheme.headline3?.copyWith(fontSize: 11),
                        textAlign: TextAlign.center,
                      ))
                  : Container(),
            ],
          ),
      ],
    );
  }
}
