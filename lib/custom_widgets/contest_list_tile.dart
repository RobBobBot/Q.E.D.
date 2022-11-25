import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qed/contest.dart';
import 'package:qed/contest_screens/active_contest_screen.dart';

class ContestListTile extends StatelessWidget {
  final Contest contest;
  const ContestListTile({super.key, required this.contest});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contest.name),
      leading: Icon(Icons.picture_as_pdf_outlined),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ActiveContestScreen(contest: contest))),
    );
  }
}
