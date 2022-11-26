import 'package:flutter/material.dart';
import 'package:qed/theme_data.dart';

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
                  color: Color.fromARGB(0, 0, 0, 0),
                  margin: EdgeInsets.fromLTRB(5,5,5,0),
                  child: ListTileTheme(
                    data: drawerTile,
                    child: ListTile(
                      title: Text(
                        nameToString[e]!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.popAndPushNamed(context, '/$e');
                      },
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
