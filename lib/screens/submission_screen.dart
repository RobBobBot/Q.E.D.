import 'package:flutter/material.dart';
import 'package:qed/classes/submission.dart';

class SubmissionScreen extends StatelessWidget {
  SubmissionScreen({required this.submission, super.key});
  Submission submission;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${submission.getUploaderName}\'s submission'),
      ),
    );
  }
}
