import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qed/contest.dart';
import 'package:qed/contest_screens/active_contest_screen.dart';
import 'package:qed/contest_screens/finished_contest_screen.dart';
import 'package:qed/theme_data.dart';

import '../contest_screens/upcoming_contest_screen.dart';

class ContestListTile extends StatelessWidget {
  final Contest contest;
  const ContestListTile({super.key, required this.contest});

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      data: presentationContent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(contest.name),
          leading: Icon(
            Icons.leaderboard,
          ),
          subtitle: Text("by Organizer"),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => contest.isFinished()
                    ? FinishedContestScreen(contest: contest)
                    : contest.isUpcoming()
                        ? UpcomingContestScreen(contest: contest)
                        : ActiveContestScreen(contest: contest)),
          ),
        ),
      ),
    );
  }
}
