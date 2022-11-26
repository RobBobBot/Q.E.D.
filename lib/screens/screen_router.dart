import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qed/redux/app_state.dart';
import 'package:qed/screens/homescreen.dart';
import 'package:qed/screens/signin.dart';

class ScreenRouter extends StatelessWidget {
  const ScreenRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      if (store.state.currentUser != null) {
        return HomeScreen();
      }
      return SignIn();
    });
  }
}
