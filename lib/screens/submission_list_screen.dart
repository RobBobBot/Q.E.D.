import 'package:flutter/material.dart';

import '../problem.dart';

class SubmissionListScreen extends StatefulWidget {
  SubmissionListScreen({required this.problem, super.key});
  Problem problem;
  @override
  State<SubmissionListScreen> createState() => _SubmissionListScreenState();
}

class _SubmissionListScreenState extends State<SubmissionListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submissions'),
      ),
      //body: ListView(children: widget.problem.submissions.map()),
    );
  }
}
