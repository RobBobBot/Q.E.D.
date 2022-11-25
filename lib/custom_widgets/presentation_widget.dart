import 'package:flutter/material.dart';
import 'package:qed/contest.dart';

import '../contest_screens/active_contest_screen.dart';

class PresentationWidget extends StatelessWidget {
  PresentationWidget({required this.type, super.key});

  String type;
  var typeToTitle = {
    'active': 'Active Contest',
    'upcoming': 'Upcoming Contests',
    'past': 'Past Contests',
    'problems': 'Training Problems'
  };

  late var data;

  @override
  Widget build(BuildContext context) {
    data = [
      ListTile(
        title: Text(type),
      )
    ];

    return Column(
      children: [Text(typeToTitle[type] ?? 'error'), ...data],
    );
  }
}
