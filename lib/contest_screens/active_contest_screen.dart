import 'package:flutter/material.dart';
import 'package:qed/contest.dart';
import 'package:qed/custom_widgets/tag_widget.dart';

class ActiveContestScreen extends StatelessWidget {
  final Contest contest;

  ///DOC: Are NEVOIE de un Contest object, nu il genereaza el din Firebase
  const ActiveContestScreen({super.key, required this.contest});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Wrap(
            children: contest.tags.map((e) => ContestTag(name: e)).toList(),
            runSpacing: 8.0,
          ),
        ],
      ),
    );
  }
}
