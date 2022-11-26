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
  TextEditingController passController = TextEditingController();
  TextEditingController userController = TextEditingController();
  String? userError, passError;
  bool hasError = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> validateData() async {
    userError = passError = null;
    hasError = false;
    userError = (userController.text == "" ? "This field is required!" : null);
    passError = (passController.text == "" ? "This field is required!" : null);
    if (userError != null || passError != null) {
      hasError = true;
      setState(() {});
      return;
    }
    await QEDStore.instance
        .signInUser(email: userController.text, password: userController.text)
        .then((value) {
      if (value != null) {
        hasError = true;
        switch (value) {
          case 'invalid-email':
            userError = 'The email is Invalid!';
            break;
          case 'user-not-found':
            userError = 'The user does not exist!';
            break;
          case 'wrong-password':
            passError = 'The password is wrong!';
            break;
          case 'unknown':
            passError = userError = "I don't know man...";
            break;
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FittedBox(
                  child: Text("Welcome to Q.E.D.!",
                      style: Theme.of(context).textTheme.headline2)),
              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  errorText: userError,
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 164, 139, 233),
                  ),
                ),
                controller: userController,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Password",
                  errorText: passError,
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 164, 139, 233),
                  ),
                ),
                controller: passController,
                obscureText: true,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SignInButton(
                  Buttons.Email,
                  onPressed: () async {
                    await validateData();
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(hasError
                                ? 'Something went wrong...'
                                : 'Loading...')),
                      );
                    }
                  },
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
      ),
    );
  }
}
