import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:qed/main.dart';
import 'package:qed/screens/signup.dart';

import '../firebase/qedstore.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
                child: Text("Welcome to QED!",
                    style: Theme.of(context).textTheme.headline2)),
            TextField(
              decoration: InputDecoration(hintText: "Username"),
            ),
            TextField(
              decoration: InputDecoration(hintText: "Password"),
              obscureText: true,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SignInButton(
                Buttons.Email,
                onPressed: () {},
                padding: EdgeInsets.all(16.0),
                elevation: 20.0,
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Or sign with an external platform:"),
            ),
            SignInButton(
              Buttons.GoogleDark,
              onPressed: () {
                QEDStore.instance.singInWithGoogle();
              },
              padding: EdgeInsets.all(16.0),
              elevation: 20.0,
            ),
            Divider(),
            TextButton(
              child: Text(" New user? Sign up here!"),
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUp(),
                ),
                (a) => false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
