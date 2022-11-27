import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qed/custom_widgets/tag_widget.dart';

import '../problem.dart';
import '../redux/app_state.dart';
import '../screens/problem_screen.dart';
import '../screens/submission_list_screen.dart';

enum ProblemType {
  past,
  active,
  upcoming,
  archived,
}

class ProblemListTile extends StatelessWidget {
  final Problem problem;
  final ProblemType type;
  const ProblemListTile({required this.type, super.key, required this.problem});

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      return ListTile(
        contentPadding: EdgeInsets.all(12),
        onTap: problem.statementLink == null
            ? null
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => type == ProblemType.active
                          ? SubmissionListScreen(problem: problem)
                          : ProblemScreen(
                              canSubmit: ProblemType.active == type,
                              problem: problem)),
                );
              },
        leading: Image.asset(
          'assets/images/symbols.png',
          width: 40,
        ),
        title: Text(problem.name),
        subtitle: problem.tags.length > 0
            ? Wrap(
                runSpacing: 8.0,
                spacing: 8.0,
                children:
                    problem.tags.map((e) => QedTag(name: e)).take(3).toList(),
              )
            : Text("originally by Proposer",
                style: TextStyle(fontWeight: FontWeight.w300)),
        trailing:
            (type == ProblemType.past || store.state.currentUser!.role >= 1)
                ? SubmissionsButton(problem: problem)
                : type == ProblemType.active
                    ? UploadButton(canSubmit: true, problem: problem)
                    : Container(),
      );
    });
  }
}

class UploadButton extends StatelessWidget {
  final bool canSubmit;
  UploadButton({required this.problem, super.key, required this.canSubmit});
  Problem problem;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text("Upload"),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProblemScreen(
                      problem: problem,
                      canSubmit: canSubmit,
                    )));
      },
    );
  }
}

class SubmissionsButton extends StatelessWidget {
  SubmissionsButton({required this.problem, super.key});
  Problem problem;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text("Submissions"),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SubmissionListScreen(problem: problem)));
      },
    );
  }
}
