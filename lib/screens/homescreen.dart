import 'package:flutter/material.dart';
import 'package:qed/custom_widgets/presentation_widget.dart';

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
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: widgets[index],
            );
          },
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
