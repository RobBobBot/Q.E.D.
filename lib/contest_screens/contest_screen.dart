import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qed/contest.dart';
import 'package:qed/custom_widgets/loading_list_tile.dart';
import 'package:qed/custom_widgets/tag_widget.dart';
import 'package:qed/problem.dart';
import 'package:qed/redux/app_state.dart';
import 'package:qed/screens/problem_screen.dart';

class ContestScreen extends StatefulWidget {
  final Contest contest;

  ///Are NEVOIE de un Contest object, nu il genereaza el din Firebase.
  ///DAAAr genereaza problemele concursului din Firebase daca nu le gaseste in store.
  const ContestScreen({super.key, required this.contest});

  @override
  State<ContestScreen> createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController ticker;
  @override
  initState() {
    ticker = AnimationController(vsync: this, duration: Duration(seconds: 1));
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
                    children: widget.contest.tags
                        .map((e) => QedTag(name: e))
                        .toList(),
                    runSpacing: 8.0,
                    spacing: 8.0,
                  ),
                ),
                Divider(),
                Text("Contest Problems:"),
              ] +
              widget.contest.problemIDs.map((value) {
                if (store.state.problems[value] != null) {
                  return ActiveContestProblemListTile(
                      problem: store.state.problems[value]!);
                }
                return LoadingListTile();
              }).toList(),
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

class ActiveContestProblemListTile extends StatelessWidget {
  final Problem problem;
  const ActiveContestProblemListTile({super.key, required this.problem});

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
      trailing: ElevatedButton(
        child: Text("Upload"),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProblemScreen(problem: problem)));
        },
      ),
    );
  }
}
