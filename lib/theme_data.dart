import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
  colorScheme: ColorScheme.dark(),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Color.fromARGB(255, 59, 22, 161),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 42, 15, 116),
    titleTextStyle: TextStyle(fontSize: 32.0, fontStyle: FontStyle.italic),
  ),
  hintColor: Color.fromARGB(255, 92, 60, 180),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(),
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 56.0, fontWeight: FontWeight.bold),
    //headline2: TextStyle(fontSize: 14.0, color: Color.fromARGB(255, 164, 139, 233),),
    bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
);

ListTileThemeData drawerTile = const ListTileThemeData(
  textColor: Color.fromARGB(255, 254, 168, 0),
);
TextStyle presentationTitle = TextStyle(
  fontSize: 24,
  //fontStyle: FontStyle.italic,
  fontWeight: FontWeight.bold,
);
