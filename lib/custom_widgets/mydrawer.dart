import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final List<String> drawerScreens = [
    'home',
    'activelist',
    'upcominglist',
    'pastlist',
    'probarchive',
  ];
  final nameToString = {
    'home': 'Home Screen',
    'activelist': 'Active Contests',
    'upcominglist': 'Upcoming Contests',
    'pastlist': 'Past Contests',
    'probarchive': 'Problem Archive',
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
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/${drawerScreens[index]}',
                (route) => false,
              );
            },
          );
        }),
      ),
    );
  }
}
