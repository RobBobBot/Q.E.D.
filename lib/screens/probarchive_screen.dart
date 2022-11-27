import 'package:flutter/material.dart';
import 'package:qed/custom_widgets/problem_list_tile.dart';
import 'package:qed/firebase/qedstore.dart';
import 'package:qed/screens/homescreen.dart';
import '../custom_widgets/mydrawer.dart';
import '../problem.dart';

class ProbArchiveScreen extends StatefulWidget {
  const ProbArchiveScreen({super.key});

  @override
  State<ProbArchiveScreen> createState() => _ProbArchiveScreenState();
}

class _ProbArchiveScreenState extends State<ProbArchiveScreen> {
  List<Problem> problems = [];

  Future<void> addProblems() async {
    var value = await QEDStore.instance.getAllProblems();
    setState(() {
      problems = value;
    });
  }

  @override
  void initState() {
    addProblems();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: addProblems,
        child: ListView(
          children: problems
              .map((problem) =>
                  ProblemListTile(type: ProblemType.archived, problem: problem))
              .toList(),
        ),
      ),
      appBar: AppBar(),
      drawer: MyDrawer(),
    );
  }
}
