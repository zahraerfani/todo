import 'package:flutter/material.dart';
import 'package:todo/config/themes/my_drawing.dart';
import 'package:todo/config/themes/shadows.dart';
import 'package:todo/data/media_query/media_query.dart';

class ButtonLoading extends StatelessWidget {
  const ButtonLoading(
      {Key? key,
      required this.loading,
      required this.showBoxShadow,
      required this.onTab,
      required this.title,
      this.outline,
      this.loadColor,
      this.btnColor,
      this.btnHeight,
      this.btnWidth,
      this.textColor,
      this.iconColor,
      this.outLineColor,
      this.radius,
      this.icon})
      : super(key: key);
  final bool loading;
  final bool? showBoxShadow;
  final bool? outline;
  final Function() onTab;
  final String title;
  final Color? loadColor;
  final Color? btnColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? outLineColor;
  final double? btnWidth;
  final double? btnHeight;
  final double? radius;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return IgnorePointer(
      ignoring: loading,
      child: Container(
        width: btnWidth ?? (context.width - 80),
        height: btnHeight ?? 50,
        decoration: (outline != null && outline == true)
            ? BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: outLineColor ?? MyColors.primary,
                  width: 1,
                ))
            : null,
        alignment: Alignment.center,
        child: Container(
          width: btnWidth ?? (context.width - 80),
          height: btnHeight ?? 50,
          decoration: BoxDecoration(
              boxShadow: [
                showBoxShadow == true
                    ? myShadows()
                    : myShadows(
                        color: Colors.transparent,
                        blur: 0,
                        offset: const Offset(0, 0))
              ],
              color: btnColor ?? MyColors.primary,
              borderRadius: BorderRadius.circular(radius ?? 4.0)),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(radius ?? 4.0),
            child: InkWell(
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 4.0)),
              splashColor: MyColors.grey_20.withOpacity(0.6),
              onTap: () {
                onTab();
              },
              child: SizedBox(
                width: context.width - 80,
                height: 50,
                child: Center(
                  child: loading
                      ? Center(
                          child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: loadColor ?? MyColors.white,
                              )),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            icon != null
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Icon(
                                      icon!,
                                      color: iconColor ?? MyColors.white,
                                      size: 24,
                                    ),
                                  )
                                : Container(),
                            Text(
                              title,
                              style: textColor != null
                                  ? textTheme.bodyText2
                                      ?.copyWith(color: textColor)
                                  : textTheme.bodyText2,
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
