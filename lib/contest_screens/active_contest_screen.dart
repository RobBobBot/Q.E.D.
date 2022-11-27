import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qed/contest.dart';
import 'package:qed/custom_widgets/loading_list_tile.dart';
import 'package:qed/custom_widgets/tag_widget.dart';
import 'package:qed/firebase/qedstore.dart';
import 'package:qed/problem.dart';
import 'package:qed/redux/app_state.dart';
import 'package:qed/screens/problem_screen.dart';

import '../custom_widgets/problem_list_tile.dart';

class ActiveContestScreen extends StatefulWidget {
  final Contest contest;

  ///Are NEVOIE de un Contest object, nu il genereaza el din Firebase.
  ///DAAAr genereaza problemele concursului din Firebase daca nu le gaseste in store.
  const ActiveContestScreen({super.key, required this.contest});

  @override
  State<ActiveContestScreen> createState() => _ActiveContestScreenState();
}

class _ActiveContestScreenState extends State<ActiveContestScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController ticker;

  late List<Problem?> problems = [null];

  @override
  initState() {
    ticker = AnimationController(vsync: this, duration: Duration(seconds: 1));
    for (var id in widget.contest.problemIDs) {
      QEDStore.instance.getProblem(id).then((value) => setState(
            () {
              problems.add(value);
            },
          ));
    }
    print("here");
    ticker
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          ticker
            ..reset()
            ..forward();
          setState(() {});
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    ticker.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    Duration timeLeft = widget.contest.timeEnd.toDate().difference(currentTime);
    String timeLeftString;
    if (timeLeft.inHours > 10) {
      timeLeftString = timeLeft.toString().substring(0, 8);
    } else {
      timeLeftString = timeLeft.toString().substring(0, 7);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contest.name),
        centerTitle: true,
      ),
      body: StoreBuilder<AppState>(builder: (context, store) {
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children:
                    widget.contest.tags.map((e) => QedTag(name: e)).toList(),
                runSpacing: 8.0,
                spacing: 8.0,
              ),
            ),
            Divider(),
            Text("Contest Problems:"),
            ...problems.map((value) {
              return value == null
                  ? LoadingListTile()
                  : ProblemListTile(type: ProblemType.active, problem: value);
            }).toList()
          ],
        );
      }),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).bottomAppBarColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            child: Text("Time left: $timeLeftString",
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
