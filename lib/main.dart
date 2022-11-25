import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qed/problem.dart';
import 'package:qed/redux/app_actions.dart';
import 'package:qed/screens/homescreen.dart';
import 'package:qed/screens/pastscreen.dart';
import 'package:qed/screens/probarchivescreen.dart';
import 'package:qed/screens/signin.dart';
import 'package:qed/screens/signup.dart';
import 'package:qed/screens/upcomingscreen.dart';
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
  Future.delayed(Duration(seconds: 3)).then((val) {
    print("finished bro");
    store.dispatch(AddProblemAction(
      Problem(
        id: 1,
        name: "Bruh Problem",
        statementLink: "statement",
        tags: {"bruh"},
      ),
    ));
  });
  store.dispatch(AddContestActions(await QEDStore.instance.getContests()));
  runApp(App(store: store));
}

class App extends StatelessWidget {
  Store<AppState> store;
  App({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    ///TODO: test pls delete
    return StoreProvider<AppState>(
      store: store,
      child: StoreBuilder<AppState>(
        builder: (context, vm) {
          return MaterialApp(
            initialRoute:
                vm.state.currentUser != null ? '/home' : '/home', //TODO
            routes: {
              '/home': (context) => HomeScreen(),
              '/upcoming': (context) => UpcomingScreen(),
              '/past': (context) => PastScreen(),
              '/probarchive': (context) => ProbArchiveScreen(),
              '/signin': (context) => SignIn(),
              '/signup': (context) => SignUp(),
            },
          );
        },
      ),
    );
  }
}
