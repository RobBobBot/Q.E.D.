import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qed/problem.dart';
import 'package:qed/redux/app_actions.dart';
import 'package:qed/screens/account_screen.dart';
import 'package:qed/screens/contest_list_screen.dart';
import 'package:qed/screens/homescreen.dart';
import 'package:qed/screens/probarchive_screen.dart';
import 'package:qed/screens/signin.dart';
import 'package:qed/screens/signup.dart';
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
  await FirebaseAuth.instance.signOut();
  FirebaseAuth.instance.authStateChanges().listen(
    (user) async {
      if (user == null) {
        store.dispatch(UserChangedAction(null));
      } else {
        store.dispatch(
            UserChangedAction(await QEDStore.instance.getUserData(user)));
      }
    },
  );

  ///dummy problem
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
  QEDStore.instance
      .getContests()
      .then((value) => store.dispatch(AddContestActions(value)));
  runApp(App(store: store));
}

class App extends StatelessWidget {
  Store<AppState> store;
  App({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          home: StoreBuilder<AppState>(builder: ((context, vm) {
            if (vm.state.currentUser != null) {
              return HomeScreen();
            }
            return SignUp();
          })),
          routes: {
            '/home': (context) => HomeScreen(),
            '/upcominglist': (context) => ContestListScreen(type: 'upcoming'),
            '/pastlist': (context) => ContestListScreen(type: 'past'),
            '/probarchive': (context) => ProbArchiveScreen(),
            '/signin': (context) => SignIn(),
            '/signup': (context) => SignUp(),
            '/account': (context) => AccountScreen(),
            '/activelist': (context) => ContestListScreen(type: 'active'),
          },
        ));
  }
}
