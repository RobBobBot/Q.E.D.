import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qed/redux/app_state.dart';
import 'package:qed/theme_data.dart';

class _drawerScreenData {
  String name;
  String route;
  int minPermissionLevel;
  _drawerScreenData(this.name, this.route, this.minPermissionLevel);
}

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final drawerScreens = [
    _drawerScreenData('Home', '/home', 0),
    _drawerScreenData('Active Contest List', '/activelist', 0),
    _drawerScreenData('Upcoming Contest List', '/upcominglist', 0),
    _drawerScreenData('Past Contest List', '/pastlist', 0),
    _drawerScreenData('Problem Archive', '/probarchive', 0),
    _drawerScreenData('Make a Contest', '/createcontest', 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).bannerTheme.backgroundColor,
      child: StoreBuilder<AppState>(builder: (context, store) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 180,
              ),
            ),
            SizedBox(height: 20),
            ...drawerScreens
                .where((element) =>
                    store.state.currentUser!.role >= element.minPermissionLevel)
                .map(
                  (e) => Container(
                    margin: EdgeInsets.all(5),
                    color: Color.fromARGB(0, 0, 0, 0),
                    child: ListTileTheme(
                      data: drawerTile,
                      child: ListTile(
                        title: Text(
                          e.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            e.route,
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ),
                )
                .toList(),
          ],
        );
      }),
    );
  }
}
