import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qed/screens/active_contest_screen.dart';
import 'package:qed/screens/homescreen.dart';
import 'package:qed/screens/pastscreen.dart';
import 'package:qed/screens/probarchivescreen.dart';
import 'package:qed/screens/upcomingscreen.dart';
import 'package:qed/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        '/upcoming': (context) => UpcomingScreen(),
        '/past': (context) => PastScreen(),
        '/probarchive': (context) => ProbArchiveScreen(),
        '/active': (context) => ActiveContestScreen(thereIsActiveContest: true),
      },
    );
  }
}
