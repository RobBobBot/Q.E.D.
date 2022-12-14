import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qed/contest.dart';
import 'package:qed/custom_widgets/contest_list_tile.dart';
import 'package:qed/custom_widgets/presentation_widget.dart';
import 'package:qed/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:qed/theme_data.dart';

import '../contest_screens/active_contest_screen.dart';
import '../custom_widgets/mydrawer.dart';
import '../firebase/qedstore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Contest> contests = [];
  @override
  void initState() {
    updateContests();
    super.initState();
  }

  Widget _TitleWidget(String title) {
    return ListTile(
      title: Text(
        '${title[0].toUpperCase()}${title.substring(1)} Contests',
        style: presentationTitle,
      ),
      trailing: Text("more..."),
      onTap: () => Navigator.pushNamed(context, '/${title}list'),
    );
  }

  Future<void> updateContests() async {
    var value = await QEDStore.instance.getContests();
    setState(() {
      contests = value;
      print(contests);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Contest> pastContests = [], activeContests = [], upcomingContests = [];
    Timestamp currentTime = Timestamp.fromDate(DateTime.now());
    for (var contest in contests) {
      if (contest.isFinished()) {
        pastContests.add(contest);
        continue;
      }
      if (contest.isUpcoming()) {
        upcomingContests.add(contest);
        continue;
      }
      activeContests.add(contest);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 40,
            ),
            SizedBox(width: 10),
            Text(
              "Q.E.D.",
              style: TextStyle(fontFamily: 'Roboto'),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushNamed(context, '/account');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: updateContests,
          child: ListView(
            children: [
              _TitleWidget('active'),
              PresentationWidget(
                title: 'Active Contests',
                onTap: () {
                  Navigator.pushNamed(context, '/activelist');
                },
                elements: activeContests
                    .map((e) => ContestListTile(contest: e))
                    .take(3)
                    .toList(),
              ),
              _TitleWidget('upcoming'),
              PresentationWidget(
                title: 'Upcoming contests',
                onTap: () {
                  Navigator.pushNamed(context, '/upcominglist');
                },
                elements: upcomingContests
                    .map((e) => ContestListTile(contest: e))
                    .take(3)
                    .toList(),
              ),
              _TitleWidget('past'),
              PresentationWidget(
                title: 'Past contests',
                onTap: () {
                  Navigator.pushNamed(context, '/pastlist');
                },
                elements: pastContests
                    .map((e) => ContestListTile(contest: e))
                    .take(3)
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
