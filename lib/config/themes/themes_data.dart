import 'package:flutter/material.dart';

import 'my_drawing.dart';
import 'my_font.dart';

/// ***********Light**************/

final ThemeData themeData = ThemeData(
  fontFamily: MyFont.medium,
  brightness: Brightness.light,
  primaryColor: Colors.orange[500],
  textTheme: textTheme,
  bottomSheetTheme:
      BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
);

TextTheme textTheme = TextTheme(
  displayLarge: headline1,
  displayMedium: headLine2,
  displaySmall: headLine3,
  headlineMedium: headLine4,
  headlineSmall: headLine5,
  titleLarge: headLine6,
  bodyLarge: bodyText1,
  bodyMedium: bodyText2,
  labelMedium: labelMedium,
  bodySmall: caption,
);
const TextStyle headline1 = TextStyle(
    fontFamily: MyFont.bold,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: MyColors.darkText);

const TextStyle headLine2 = TextStyle(
    fontFamily: MyFont.medium, fontSize: 16, color: MyColors.darkText);
TextStyle labelMedium = TextStyle(
    fontFamily: MyFont.medium,
    fontSize: 14,
    color: MyColors.darkText.withOpacity(0.5));

const TextStyle headLine3 =
    TextStyle(fontFamily: MyFont.medium, fontSize: 10, color: MyColors.white);

const TextStyle headLine4 =
    TextStyle(fontFamily: MyFont.medium, color: MyColors.grey_60, fontSize: 11);

const TextStyle headLine5 =
    TextStyle(fontFamily: MyFont.bold, color: MyColors.grey_60, fontSize: 14);

const TextStyle headLine6 =
    TextStyle(fontFamily: MyFont.medium, color: MyColors.grey_60, fontSize: 12);

const TextStyle caption =
    TextStyle(fontSize: 12, fontFamily: MyFont.medium, color: MyColors.grey_40);

const TextStyle bodyText1 = TextStyle(
    fontWeight: FontWeight.normal,
    fontFamily: MyFont.medium,
    fontSize: 14,
    color: MyColors.darkText);

const TextStyle bodyText2 = TextStyle(
    fontWeight: FontWeight.normal,
    fontFamily: MyFont.medium,
    fontSize: 14,
    color: MyColors.white);

/// ***********Dark**************/

final ThemeData themeDataDark = ThemeData(
    brightness: Brightness.dark,
    textTheme: myTextTheme,
    primarySwatch: Colors.deepPurple,
    fontFamily: MyFont.medium);

TextTheme myTextTheme = TextTheme(
  displayLarge: headlineDark1,
  titleLarge: headlineDark6,
  bodyMedium: bodyTextDark2,
);
TextStyle get headlineDark1 =>
    const TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold);

TextStyle get headlineDark6 =>
    const TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic);

TextStyle get bodyTextDark2 =>
    const TextStyle(fontSize: 14.0, fontFamily: 'Hind');

extension CustomColorScheme on ColorScheme {
  Color get success =>
      brightness == Brightness.light ? Colors.green : Colors.deepPurple;
  Color get warning => brightness == Brightness.light
      ? Colors.orange
      : Colors.blueAccent.shade700;
  Color get alert => brightness == Brightness.light ? Colors.red : Colors.teal;
  Color get button =>
      brightness == Brightness.light ? Colors.blue : Colors.deepOrange;
}
