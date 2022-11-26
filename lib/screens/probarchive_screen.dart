import 'package:flutter/material.dart';
import 'package:qed/screens/homescreen.dart';
import '../custom_widgets/mydrawer.dart';

class ProbArchiveScreen extends StatefulWidget {
  const ProbArchiveScreen({super.key});

  @override
  State<ProbArchiveScreen> createState() => _ProbArchiveScreenState();
}

class _ProbArchiveScreenState extends State<ProbArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Problem Archive Screen'),
      appBar: AppBar(),
      drawer: MyDrawer(),
    );
  }
}
