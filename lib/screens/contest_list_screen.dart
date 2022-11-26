import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qed/custom_widgets/empty_message.dart';
import '../contest.dart';
import '../custom_widgets/contest_list_tile.dart';
import '../custom_widgets/mydrawer.dart';
import '../custom_widgets/presentation_widget.dart';
import '../redux/app_state.dart';

class ContestListScreen extends StatefulWidget {
  ContestListScreen({required this.type, super.key});
  String type;

  @override
  State<ContestListScreen> createState() => _ContestListScreenState();
}

class _ContestListScreenState extends State<ContestListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreBuilder<AppState>(builder: (context, store) {
        List<Contest> contestsToShow = [];
        Timestamp currentTime = Timestamp.fromDate(DateTime.now());
        for (var contest in store.state.contests.values) {
          if (contest.timeEnd.compareTo(currentTime) < 0) {
            if(widget.type == 'past') contestsToShow.add(contest);
          } else if (contest.timeBegin.compareTo(currentTime) > 0) {
            if(widget.type == 'upcoming') contestsToShow.add(contest);
          } else if (widget.type == 'active') {
            contestsToShow.add(contest);
          }
        }
        return contestsToShow.isEmpty
            ? EmptyMessage(name: '${widget.type} contests')
            : SingleChildScrollView(
                child: PresentationWidget(
                  elements: contestsToShow
                      .map((e) => ContestListTile(contest: e))
                      .toList(),
                  onTap: () {},
                  title: '${widget.type} Contests',
                ),
              );
      }),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(widget.type.substring(0,1).toUpperCase() + widget.type.substring(1) + ' Contests'),
      ),
      drawer: MyDrawer(),
    );
  }
}
