import 'package:flutter/material.dart';

class EmptyMessage extends StatelessWidget {
  EmptyMessage({required this.name, super.key});
  String name;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("We're sorry, there are no ${name} available :("),
    );
  }
}
