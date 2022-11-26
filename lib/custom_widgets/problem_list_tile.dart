import 'package:flutter/material.dart';
import 'package:qed/custom_widgets/tag_widget.dart';

import '../problem.dart';
import '../screens/problem_screen.dart';
import '../screens/submission_list_screen.dart';

class ProblemListTile extends StatelessWidget {
  final Problem problem;
  final String type;
  const ProblemListTile({required this.type, super.key, required this.problem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProblemScreen(problem: problem)),
        );
      },
      leading: Image.asset(
        'assets/images/symbols.png',
        width: 40,
      ),
      title: Text(problem.name),
      subtitle: Wrap(
        children: problem.tags.map((e) => QedTag(name: e)).toList(),
        runSpacing: 8.0,
        spacing: 8.0,
      ),
      trailing: type == 'finished'
          ? SubmissionsButton(problem: problem)
          : UploadButton(problem: problem),
    );
  }
}

class UploadButton extends StatelessWidget {
  UploadButton({required this.problem, super.key});
  Problem problem;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text("Upload"),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProblemScreen(problem: problem)));
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
