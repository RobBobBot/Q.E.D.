import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qed/contest.dart';
import 'package:qed/contest_screens/active_contest_screen.dart';
import 'package:qed/firebase/firebase_options.dart';
import 'package:qed/firebase/qedstore.dart';
import 'package:qed/redux/app_actions.dart';
import 'package:qed/redux/app_reducer.dart';
import 'package:qed/redux/app_state.dart';
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Store<AppState> store = Store<AppState>(appReducer, initialState: AppState());
  FirebaseAuth.instance.authStateChanges().listen(
    (user) async {
      if (user == null) {
        store.dispatch(UserChangedAction(null));
      } else {
        store.dispatch(
            UserChangedAction(await QEDStore.instance.getUserData(user.uid)));
      }
    },
  );
  runApp(App(store: store));
}

class App extends StatelessWidget {
  Store<AppState> store;
  App({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child:
            MaterialApp(home: StoreBuilder<AppState>(builder: ((context, vm) {
          AppState st = vm.state;
          if (st.currentUser != null) {
            return ActiveContestScreen(
                contest: Contest(
                    name: "Test Contest (Testest)",
                    problemIDs: {1, 2, 3},
                    tags: {"heart-warming", "linear algebra", "matrices"}));
          }
          return Text("sd");
        }))));
  }
}
