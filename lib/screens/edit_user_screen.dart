import 'package:flutter/material.dart';

import '../custom_widgets/mydrawer.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({super.key});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Settings'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: ListView(
              children: [
                TextFormField(initialValue: "Username"),
                TextFormField(initialValue: "Real Name"),
                TextFormField(initialValue: "Description"),
                Text('Status: elev (alt formfield)'),
                ElevatedButton(onPressed: () {}, child: Text('save'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
