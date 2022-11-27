import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qed/custom_widgets/mydrawer.dart';
import 'package:qed/redux/app_state.dart';
import 'package:qed/screens/loading_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var toRoleName = ['Student', 'Teacher', 'Admin'];

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      return AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: store.state.currentUser == null
            ? LoadingScreen()
            : Scaffold(
                appBar: AppBar(
                  title: const Text('Profile'),
                  centerTitle: true,
                  actions: [
                    store.state.currentUser != null &&
                            store.state.currentUser!.role == 2
                        ? IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/teacherrequests');
                            },
                            icon: const Icon(Icons.admin_panel_settings))
                        : Container(),
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
                              backgroundImage: NetworkImage(store
                                          .state.currentUser ==
                                      null
                                  ? "https://firebasestorage.googleapis.com/v0/b/unihackqed.appspot.com/o/Users%2FDefaultProfilePicture.jpeg?alt=media&token=21040947-0dab-469f-874a-847d2800c588"
                                  : store.state.currentUser!.profilePictureURL),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.cover,
                                  child: Text(
                                    store.state.currentUser == null
                                        ? 'error'
                                        : store.state.currentUser!.nickname,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                                Text(store.state.currentUser!.name),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Text(store.state.currentUser!.description),
                        const SizedBox(height: 10),
                        Text(
                            'Role: ${toRoleName[store.state.currentUser!.role]}'),
                        Text('Rating: ${store.state.currentUser!.rating}'),
                        Text(
                            'Solved problems: ${store.state.currentUser!.problemsSolved}'),
                      ],
                    ),
                  ),
                ),
              ),
      );
    });
  }
}
