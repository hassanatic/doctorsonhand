import 'package:flutter/material.dart';

const COLOR_PRIMARY = Color(0xff439bFF);
// const COLOR_SECONDARY =
const COLOR_ACCENT = Color(0xff7e5bed);
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  //primaryColor: COLOR_PRIMARY,
  colorScheme: ColorScheme.fromSwatch().copyWith(

    primary: COLOR_PRIMARY,
    secondary: COLOR_ACCENT),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
);
