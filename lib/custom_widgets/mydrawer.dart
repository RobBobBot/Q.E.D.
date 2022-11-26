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
      backgroundColor: Theme.of(context).bannerTheme.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              width: 180,
            ),
          ),
          ...drawerScreens
              .map(
                (e) => Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).hintColor,
                  ),
                  child: ListTile(
                    title: Text(nameToString[e]!),
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/$e');
                    },
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
