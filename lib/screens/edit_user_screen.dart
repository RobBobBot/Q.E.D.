import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qed/firebase/qedstore.dart';
import 'package:qed/redux/app_state.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({super.key});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  TextEditingController usernameController = TextEditingController(),
      realNameController = TextEditingController(),
      descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      usernameController.text = store.state.currentUser!.nickname;
      realNameController.text = store.state.currentUser!.name;
      descriptionController.text = store.state.currentUser!.description;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile Settings'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: ListView(
                children: [
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  TextFormField(
                    controller: realNameController,
                    decoration: const InputDecoration(labelText: 'Real Name'),
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  (store.state.currentUser!.role != 'student')
                      ? const Text('You already have the teacher Role.')
                      : Row(
                          children: [
                            const Text('Request teacher role?'),
                            SizedBox(width: 32),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Request'),
                            )
                          ],
                        ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    LogOutWarning());
                          },
                          child: Text('Log Out')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel')),
                      ElevatedButton(onPressed: () {}, child: Text('Save')),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class LogOutWarning extends StatelessWidget {
  const LogOutWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Warning'),
      content: const Text('Are you sure you want to log out?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/signin', (route) => false);
            QEDStore.instance.signOutUser();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
