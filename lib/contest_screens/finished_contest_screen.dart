import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qed/contest.dart';
import 'package:qed/contest_screens/leaderboard_screen.dart';
import 'package:qed/custom_widgets/loading_list_tile.dart';
import 'package:qed/custom_widgets/tag_widget.dart';
import 'package:qed/problem.dart';
import 'package:qed/redux/app_state.dart';
import 'package:qed/screens/problem_screen.dart';
import 'package:qed/theme_data.dart';

import '../custom_widgets/problem_list_tile.dart';
import '../firebase/qedstore.dart';

class FinishedContestScreen extends StatefulWidget {
  final Contest contest;

  const FinishedContestScreen({super.key, required this.contest});

  @override
  State<FinishedContestScreen> createState() => _FinishedContestScreenState();
}

class _FinishedContestScreenState extends State<FinishedContestScreen> {
  late List<Problem?> problems = [null];

  @override
  initState() {
    for (var id in widget.contest.problemIDs) {
      QEDStore.instance.getProblem(id).then((value) => setState(
            () {
              problems.add(value);
            },
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contest.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Tags:", style: presentationTitle),
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: Wrap(
                children:
                    widget.contest.tags.map((e) => QedTag(name: e)).toList(),
                runSpacing: 8.0,
                spacing: 8.0,
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Contest Problems:", style: presentationTitle),
            ),
            ...problems.map((value) {
              if (value != null) {
                return ProblemListTile(type: ProblemType.past, problem: value);
              }
              return LoadingListTile();
            }).toList(),
            ListTile(
              title: Text('Leaderboard'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LeaderboardScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
