import 'package:flutter/material.dart';
import 'package:qed/screens/submission_screen.dart';

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
      body: ListView(
          children: widget.problem.submissions.map(
        (e) {
          bool upvoted = false;
          return ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SubmissionScreen(submission: e,)));
            },
            title: Text(e.getUploaderName()),
            subtitle: Text('upvotes: ${e.upvotes}, score: ${e.score}'),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  upvoted = !upvoted;
                });
              },
              icon:
                  upvoted ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
            ),
          );
        },
      ).toList()),
    );
  }
}
