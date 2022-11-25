import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qed/firebase/firebase_options.dart';
import 'package:qed/firebase/qedstore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
