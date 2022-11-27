import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qed/custom_widgets/mydrawer.dart';
import 'package:qed/firebase/qedstore.dart';
import 'package:qed/redux/app_state.dart';
import 'package:qed/screens/loading_screen.dart';

class OtherPersonScreen extends StatefulWidget {
  final String uid;
  const OtherPersonScreen({super.key, required this.uid});

  @override
  State<OtherPersonScreen> createState() => _OtherPersonScreenState();
}

class _OtherPersonScreenState extends State<OtherPersonScreen> {
  var toRoleName = ['Student', 'Teacher', 'Admin'];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BasicUserInfo>(builder: (context, snap) {
      if (!snap.hasData) {
        return LoadingScreen();
      }
      BasicUserInfo info = snap.data!;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          actions: [
            info.role == 2
                ? IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.admin_panel_settings))
                : const Text(""),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/edituser');
                },
                icon: const Icon(Icons.settings)),
          ],
        ),
        drawer: MyDrawer(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 50,
                      backgroundImage: NetworkImage(info.profilePictureURL),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          info.nick,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.white),
                        ),
                        //Text(store.state.currentUser!.name),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                //Text(store.state.currentUser!.description),
                const SizedBox(height: 10),
                Text('Role: ${toRoleName[info.role]}'),
                Text('Rating: ${info.rating}'),
                Text('Solved problems: ${info.problemsSolved}'),
              ],
            ),
          ),
        ),
      );
    });
  }
}
