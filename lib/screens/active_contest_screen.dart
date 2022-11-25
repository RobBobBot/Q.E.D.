import 'package:flutter/material.dart';
import 'package:qed/custom_widgets/mydrawer.dart';
import 'package:qed/custom_widgets/presentation_widget.dart';

class ActiveContestScreen extends StatelessWidget {
  bool thereIsActiveContest;

  ActiveContestScreen({required this.thereIsActiveContest, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: thereIsActiveContest
          ? PresentationWidget(type: 'active')
          : Text('there are no active contests :('),
      drawer: MyDrawer(),
    );
  }
}
