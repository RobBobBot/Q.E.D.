import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qed/redux/app_state.dart';
import 'package:qed/screens/homescreen.dart';
import 'package:qed/screens/signin.dart';

class ScreenRouter extends StatelessWidget {
  const ScreenRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: ((context, snapshot) {
        if (snapshot.data != null) return HomeScreen();
        return SignIn();
      }),
      stream: FirebaseAuth.instance.authStateChanges(),
    );
  }
}
