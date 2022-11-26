import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
  colorScheme: ColorScheme.dark().copyWith(
    secondary: Color.fromARGB(255, 254, 168, 0),
    primary: Color.fromARGB(255, 42, 15, 116),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Color.fromARGB(255, 42, 15, 116),
  ),
  scaffoldBackgroundColor: Color.fromARGB(255, 15, 12, 35),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 42, 15, 116),
    titleTextStyle: TextStyle(fontSize: 32.0, fontStyle: FontStyle.italic),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Color.fromARGB(255, 255, 240, 225)),
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 56.0, fontWeight: FontWeight.bold),
    headline2: TextStyle(
      color: Color.fromARGB(255, 255, 240, 225),
    ),
    bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
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
