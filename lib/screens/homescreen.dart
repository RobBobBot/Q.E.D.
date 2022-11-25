import 'package:flutter/material.dart';
import 'package:qed/contest.dart';
import 'package:qed/custom_widgets/presentation_widget.dart';

import '../contest_screens/active_contest_screen.dart';
import '../custom_widgets/mydrawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool thereIsActiveContest = true;
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    if (thereIsActiveContest) widgets.add(PresentationWidget(type: 'active'));
    widgets.add(PresentationWidget(type: 'upcoming'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QED"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/account');
            },
            icon: Icon(Icons.account_box),
          )
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActiveContestScreen(
                      contest: Contest(
                        id: 1,
                        name: "Bruh contest",
                        tags: {"b", "r", "u", "h"},
                        problemIDs: {1, 2, 3},
                      ),
                    ),
                  ),
                );
              },
              child: widgets[index],
            );
          },
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
