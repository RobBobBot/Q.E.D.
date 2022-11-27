import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
  colorScheme: ColorScheme.dark().copyWith(
    secondary: Color.fromARGB(255, 254, 168, 0),
    primary: Color.fromARGB(255, 194, 171, 255),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Color.fromARGB(255, 42, 15, 116),
  ),
  scaffoldBackgroundColor: Color(0x0C0F0A),
  bottomAppBarColor: Color.fromARGB(255, 42, 15, 116),
  bottomAppBarTheme: BottomAppBarTheme(
    color: Color.fromARGB(255, 42, 15, 116),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 42, 15, 116),
    titleTextStyle: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Color.fromARGB(255, 255, 240, 225)),
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    ),
    headline2: TextStyle(
      fontSize: 15.0,
      color: Color.fromARGB(255, 255, 240, 225),
      fontFamily: 'Roboto',
    ),
    bodyText2: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
    ),
  ),
);

ListTileThemeData drawerTile = ListTileThemeData(
  textColor: Color.fromARGB(255, 255, 240, 225),
  tileColor: Color(0xFF03000F),
  style: ListTileStyle.drawer,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
);
TextStyle presentationTitle = const TextStyle(
  fontSize: 24,
  fontFamily: 'Roboto',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.bold,
);
ListTileThemeData presentationContent = ListTileThemeData(
    style: ListTileStyle.list,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    tileColor: Color.fromARGB(255, 35, 35, 42),
    textColor: Color.fromARGB(255, 255, 255, 255),
    iconColor: Color.fromARGB(255, 255, 186, 10));
