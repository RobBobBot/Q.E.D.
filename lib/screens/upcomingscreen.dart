import 'package:flutter/material.dart';
import 'package:qed/custom_widgets/presentation_widget.dart';
import 'package:qed/screens/homescreen.dart';

import '../custom_widgets/mydrawer.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: SingleChildScrollView(child: PresentationWidget(type: 'upcoming')),
      appBar: AppBar(),
      drawer: MyDrawer(),
    );
  }
}
