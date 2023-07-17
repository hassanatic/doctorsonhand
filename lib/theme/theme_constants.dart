import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const COLOR_PRIMARY = Color(0xff439bFF);
// const COLOR_SECONDARY =
const COLOR_ACCENT = Color(0xff7e5bed);
 final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  //primaryColor: COLOR_PRIMARY,
  colorScheme: ColorScheme.fromSwatch().copyWith(

    primary: COLOR_PRIMARY,
    secondary: COLOR_ACCENT),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

   cupertinoOverrideTheme: CupertinoThemeData.raw(Brightness.dark, Colors.black, Colors.white,  textThemeData, Colors.black, Colors.black , true),


);



 final ThemeData data = ThemeData(
  primaryColor: const Color(0xFFF44336), // custom primary color
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: const Color(0xFFF44336),
    primary: const Color(0xFFF44336),
  ), // custom accent color
  visualDensity: VisualDensity.adaptivePlatformDensity,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Color(0xFF000000),
    ),
    headline2: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
      color: Color(0xFF000000),
    ),
   bodyText1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Color(0xFF000000),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Color(0xFFF44336), // custom app bar color
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFFF5722), // custom bottom navigation bar color
  ),
);


 TextTheme txtTheme = const TextTheme(

     headline1: TextStyle(
       fontSize: 24.0,
       fontWeight: FontWeight.bold,
       color: Colors.white,
     ),
     headline2: TextStyle(
       fontSize: 18.0,
       fontWeight: FontWeight.normal,
       color: Colors.white,
     ),
     bodyText1: TextStyle(
       fontSize: 14.0,
       fontWeight: FontWeight.normal,
       color: Colors.white,
     ),

 );

 CupertinoTextThemeData textThemeData = const CupertinoTextThemeData(
  // primaryColor: Colors.white,
  // pickerTextStyle: TextStyle(color: Colors.white),
  // textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
 );
