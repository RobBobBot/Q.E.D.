import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qed/screens/homescreen.dart';
import 'package:qed/screens/pastscreen.dart';
import 'package:qed/screens/probarchivescreen.dart';
import 'package:qed/screens/upcomingscreen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qed/contest.dart';
import 'package:qed/contest_screens/active_contest_screen.dart';
import 'package:qed/firebase/firebase_options.dart';
import 'package:qed/redux/app_reducer.dart';
import 'package:qed/redux/app_state.dart';
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Store<AppState> store = Store<AppState>(appReducer, initialState: AppState());
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
        initialRoute: '/home',
        routes: {
          '/home': (context) => HomeScreen(),
          '/upcoming': (context) => UpcomingScreen(),
          '/past': (context) => PastScreen(),
          '/probarchive': (context) => ProbArchiveScreen(),
        },
      ),
    );
  }
}
