import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qed/firebase/qedstore.dart';
import 'package:qed/redux/app_actions.dart';
import 'package:qed/redux/app_state.dart';
import 'package:qed/screens/loading_screen.dart';

class RoleInfo extends StatefulWidget {
  final String uid, name;
  final int role;
  const RoleInfo(
      {super.key, required this.role, required this.name, required this.uid});

  @override
  State<RoleInfo> createState() => _RoleInfoState();
}

class _RoleInfoState extends State<RoleInfo> {
  @override
  Widget build(BuildContext context) {
    bool requested = false;

    switch (widget.role) {
      case 0:
        return Row(
          children: [
            const Text('Request teacher role?'),
            SizedBox(width: 32),
            ElevatedButton(
              onPressed: requested
                  ? null
                  : () {
                      QEDStore.instance.addRequest(widget.uid, widget.name);
                      setState(() {
                        requested = true;
                      });
                    },
              child: Text('Request'),
            )
          ],
        );
      case 1:
        return const Text('You are a teacher!');
      case 2:
        return const Text('You are an admin!');
      default:
        return const Text("You are an error!");
    }
  }
}

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
      usernameController.text = store.state.currentUser == null
          ? ""
          : store.state.currentUser!.nickname;
      realNameController.text =
          store.state.currentUser == null ? "" : store.state.currentUser!.name;
      descriptionController.text = store.state.currentUser == null
          ? ""
          : store.state.currentUser!.description;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile Settings'),
          centerTitle: true,
        ),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: store.state.currentUser == null
              ? LoadingScreen()
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      child: ListView(
                        children: [
                          TextFormField(
                            controller: usernameController,
                            decoration:
                                const InputDecoration(labelText: 'Username'),
                          ),
                          TextFormField(
                            controller: realNameController,
                            decoration:
                                const InputDecoration(labelText: 'Real Name'),
                          ),
                          TextFormField(
                            controller: descriptionController,
                            decoration:
                                const InputDecoration(labelText: 'Description'),
                          ),
                          RoleInfo(
                            role: store.state.currentUser!.role,
                            name: store.state.currentUser!.name,
                            uid: store.state.currentUser!.firebaseUser.uid,
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
                              ElevatedButton(
                                  onPressed: () {
                                    QEDStore.instance.updateUser(
                                        nickname: usernameController.text,
                                        name: realNameController.text,
                                        desc: descriptionController.text,
                                        uid: store.state.currentUser!
                                            .firebaseUser.uid);

                                    store.dispatch(UserUpdateAction(
                                        realNameController.text,
                                        usernameController.text,
                                        descriptionController.text));

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                const Text('Saved Changes!')));
                                  },
                                  child: Text('Save')),
                            ],
                          )
                        ],
                      ),
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
          onPressed: () async {
            await QEDStore.instance.signOutUser();
            await Navigator.pushNamedAndRemoveUntil(
                context, '/', (route) => false);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
