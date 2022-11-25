import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qed/contest.dart';
import 'package:qed/custom_widgets/loading_list_tile.dart';
import 'package:qed/custom_widgets/tag_widget.dart';
import 'package:qed/problem.dart';
import 'package:qed/redux/app_state.dart';

class ActiveContestScreen extends StatelessWidget {
  final Contest contest;

  ///Are NEVOIE de un Contest object, nu il genereaza el din Firebase.
  ///DAAAr genereaza problemele concursului din Firebase daca nu le gaseste in store.
  const ActiveContestScreen({super.key, required this.contest});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contest.name),
        centerTitle: true,
      ),
      body: StoreBuilder<AppState>(builder: (context, store) {
        return ListView(
          children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: contest.tags.map((e) => QedTag(name: e)).toList(),
                    runSpacing: 8.0,
                    spacing: 8.0,
                  ),
                ),
                Divider(),
                Text("Contest Problems:"),
              ] +
              contest.problemIDs.map((value) {
                if (store.state.problems[value] != null) {
                  return ActiveContestProblemListTile(
                      problem: store.state.problems[value]!);
                }
                return LoadingListTile();
              }).toList(),
        );
      }),
    );
  }
}

class ActiveContestProblemListTile extends StatelessWidget {
  final Problem problem;
  const ActiveContestProblemListTile({super.key, required this.problem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.picture_as_pdf),
      title: Text(problem.name),
      subtitle: Wrap(
        children: problem.tags.map((e) => QedTag(name: e)).toList(),
        runSpacing: 8.0,
        spacing: 8.0,
      ),
    );
  }
}
