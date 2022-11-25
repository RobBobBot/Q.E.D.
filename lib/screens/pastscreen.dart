import 'package:flutter/material.dart';
import 'package:qed/screens/homescreen.dart';

class PastScreen extends StatefulWidget {
  const PastScreen({super.key});

  @override
  State<PastScreen> createState() => _PastScreenState();
}

class _PastScreenState extends State<PastScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Past Contests Screen'),
      appBar: AppBar(),
      drawer: MyDrawer(),
    );
  }
}
