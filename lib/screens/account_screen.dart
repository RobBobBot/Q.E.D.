import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qed/custom_widgets/mydrawer.dart';
import 'package:qed/redux/app_state.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          actions: [
            store.state.currentUser!.role == 2
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
                      backgroundImage: NetworkImage(
                          store.state.currentUser!.profilePictureURL),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(store.state.currentUser!.nickname),
                        Text(store.state.currentUser!.name),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(store.state.currentUser!.description),
                const SizedBox(height: 10),
                Text('Role: ${store.state.currentUser!.role}'),
                Text('Rating: ${store.state.currentUser!.rating}'),
                Text(
                    'Solved problems: ${store.state.currentUser!.problemsSolved}'),
              ],
            ),
          ),
        ),
      );
    });
  }
}
