import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qed/classes/submission.dart';
import 'package:qed/firebase/qedstore.dart';
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
    submissions = widget.problem.submissions;
  }

  List<Submission> submissions = [];
  Future<void> reload() async {
    var value = await QEDStore.instance.getProblem(widget.problem.id);
    setState(() {
      submissions = value.submissions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      widget.problem.submissions.sort((a, b) {
        if (a.score == b.score) return a.upvotes - b.upvotes;
        return a.score - b.score;
      });
      return Scaffold(
        appBar: AppBar(
          title: Text('Submissions'),
        ),
        body: RefreshIndicator(
          onRefresh: reload,
          child: ListView(
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
                subtitle:
                    Text('upvotes: ${e.upvotes}, score: ${e.getFinalScore()}'),
                trailing: store.state.currentUser!.role == 0
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            upvoted = !upvoted;
                            e.upvotes += upvoted ? 1 : -1;
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
                        icon: Icon((graded == -1) ? Icons.edit : Icons.numbers),
                      ),
                title: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Text(snapshot.data!);
                    }
                    return Text("Loading...");
                  },
                  future: e.getUploaderName(),
                ),
              );
            },
          ).toList()),
        ),
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
  double gradeValue = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: const Text('Grading'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Please enter the grade you want to give this submission (0-7):'),
            Slider(
                label: '$gradeValue',
                min: 0,
                max: 7,
                divisions: 14,
                value: gradeValue,
                onChanged: (e) {
                  setState(() {
                    gradeValue = e;
                  });
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text('0'),
                Text('3.5'),
                Text('7'),
              ],
            )
          ],
        ),
        actions: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
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
          )
        ],
      ),
    );
  }
}
