import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qed/contest.dart';
import 'package:qed/custom_widgets/contest_list_tile.dart';
import 'package:qed/custom_widgets/presentation_widget.dart';
import 'package:qed/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:firebase_core/firebase_core.dart';

import '../contest_screens/active_contest_screen.dart';
import '../custom_widgets/mydrawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QED"),
      ),
      body: SafeArea(
        child: StoreBuilder<AppState>(builder: (context, store) {
          List<Contest> pastContests = [],
              activeContests = [],
              upcomingContests = [];
          Timestamp currentTime = Timestamp.fromDate(DateTime.now());
          for (var contest in store.state.contests.values) {
            if (contest.timeEnd.compareTo(currentTime) < 0) {
              pastContests.add(contest);
              continue;
            }
            if (contest.timeBegin.compareTo(currentTime) > 0) {
              upcomingContests.add(contest);
              continue;
            }
            activeContests.add(contest);
          }

          return ListView(
            children: [
              PresentationWidget(
                  title: 'Active Contests',
                  onTap: null,
                  elements: activeContests
                      .map((e) => ContestListTile(contest: e))
                      .toList()),
              PresentationWidget(
                  title: 'Upcoming contests',
                  onTap: null,
                  elements: upcomingContests
                      .map((e) => ContestListTile(contest: e))
                      .toList()),
              PresentationWidget(
                  title: 'Old contests',
                  onTap: null,
                  elements: pastContests
                      .map((e) => ContestListTile(contest: e))
                      .toList()),
            ],
          );
        }),
      ),
      drawer: MyDrawer(),
    );
  }
}
