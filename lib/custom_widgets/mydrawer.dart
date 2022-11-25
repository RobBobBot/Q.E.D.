import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final List<String> drawerScreens = [
    'home',
    'upcoming',
    'past',
    'probarchive',
    'active'
  ];
  final nameToString = {
    'home': 'Home Screen',
    'upcoming': 'Upcoming Contests',
    'past': 'Past Contests',
    'probarchive': 'Problem Archive',
    'active': 'Active Contests',
  };

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: drawerScreens.length,
        itemBuilder: ((context, index) {
          return ListTile(
            title: Text(nameToString[drawerScreens[index]]!),
            onTap: () {
              Navigator.popAndPushNamed(context, '/${drawerScreens[index]}');
            },
          );
        }),
      ),
    );
  }
}
