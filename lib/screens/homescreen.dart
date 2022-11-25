import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QED"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            TextButton(
              onPressed: () {},
              child: Container(),
            )
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final List<String> drawerScreens = [
    'home',
    'upcoming',
    'past',
    'probarchive'
  ];
  final nameToString = {
    'home': 'Home Screen',
    'upcoming': 'Upcoming & Active Contests',
    'past': 'Past Contests',
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
              Navigator.popAndPushNamed(context, '/${drawerScreens[index]}');
            },
          );
        }),
      ),
    );
  }
}
