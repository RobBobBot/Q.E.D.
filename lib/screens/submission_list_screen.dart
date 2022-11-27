import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qed/redux/app_state.dart';
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
  void initState() {
    // TODO: implement initState
    print(widget.problem.submissions);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Submissions'),
        ),
        body: ListView(
            children: widget.problem.submissions.map(
          (e) {
            bool upvoted = false;
            double graded = -1;
            return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SubmissionScreen(
                                submission: e,
                              )));
                },
                title: Text(e.getUploaderName()),
                subtitle: Text('upvotes: ${e.upvotes}, score: ${e.score}'),
                trailing: store.state.currentUser!.role == 0
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            upvoted = !upvoted;
                          });
                        },
                        icon: upvoted
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border),
                      )
                    : IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => GradeDialog(
                                  grade: graded == -1 ? 0 : graded));
                        },
                        icon:
                            Icon((graded == -1) ? Icons.edit : Icons.numbers)));
          },
        ).toList()),
      );
    });
  }
}

class GradeDialog extends StatefulWidget {
  GradeDialog({required this.grade, super.key});
  double grade;

  @override
  State<GradeDialog> createState() => _GradeDialogState();
}

class _GradeDialogState extends State<GradeDialog> {
  final _formKey = GlobalKey<FormState>();
  var gradeController = TextEditingController();
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Grading'),
      content: const Text(
          'Please enter the grade you want to give this submission (0-7):'),
      actions: <Widget>[
        Form(
          key: _formKey,
          child: Row(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null) return 'Please enter a value';
                  if (double.tryParse(value) == null) {
                    return 'Enter a number from 0 to 7';
                  }
                  if (double.tryParse(value)! < 0) {
                    return 'Enter a number from 0 to 7';
                  }
                  if (double.tryParse(value)! > 7) {
                    return 'Enter a number from 0 to 7';
                  }
                  return null;
                },
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Submission graded!')),
                    );
                  }
                },
                child: const Text('Grade'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
