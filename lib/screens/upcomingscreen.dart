import 'package:flutter/material.dart';
import 'package:qed/screens/homescreen.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Upcoming Contests Screen'),
      appBar: AppBar(),
      drawer: MyDrawer(),
    );
  }
}
