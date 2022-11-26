import 'package:flutter/material.dart';
import 'package:qed/contest.dart';

import '../contest_screens/contest_screen.dart';

class PresentationWidget extends StatelessWidget {
  final void Function()? onTap;
  final List<Widget> elements;
  PresentationWidget(
      {required this.title,
      super.key,
      required this.onTap,
      required this.elements});

  String title;

  //late var data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: elements,
    );
  }
}
