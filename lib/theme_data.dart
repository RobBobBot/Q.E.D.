import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
  colorScheme: ColorScheme.dark().copyWith(
    secondary: Color.fromARGB(255, 254, 168, 0),
    primary: Color.fromARGB(255, 194, 171, 255),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Color.fromARGB(255, 42, 15, 116),
  ),
  scaffoldBackgroundColor: Color.fromARGB(255, 15, 12, 35),
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
  textColor: Color.fromARGB(255, 254, 168, 0),
  tileColor: Color.fromARGB(255, 21, 17, 48),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
);
TextStyle presentationTitle = const TextStyle(
  fontSize: 24,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.bold,
);
ListTileThemeData presentationContent = ListTileThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    tileColor: Color.fromARGB(255, 21, 17, 48));
