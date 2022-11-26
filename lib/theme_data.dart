import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
  colorScheme: ColorScheme.dark(),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Color(0xFF341390),
  ),
  scaffoldBackgroundColor: Color(0x0C0F0A),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF341390),
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
  textColor: Color(0xFFFFB319),
  tileColor: Color(0xFF03000F),
  style: ListTileStyle.drawer,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
);
TextStyle presentationTitle = TextStyle(
  fontSize: 24,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.bold,
);
ListTileThemeData presentationContent = ListTileThemeData(
    style: ListTileStyle.list,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    tileColor: Color(0xFF341390),
    textColor: Colors.white,
    iconColor: Color.fromARGB(255, 255, 186, 10));
