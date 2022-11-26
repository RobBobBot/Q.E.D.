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
  TextEditingController emailController = TextEditingController();
  String? emailError, passError;
  bool hasError = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> validateData() async {
    emailError = passError = null;
    hasError = false;
    emailError =
        (emailController.text == "" ? "This field is required!" : null);
    passError = (passController.text == "" ? "This field is required!" : null);
    if (emailError != null || passError != null) {
      hasError = true;
      setState(() {});
      return;
    }
    await QEDStore.instance
        .signInUser(email: emailController.text, password: emailController.text)
        .then((value) {
      if (value != null) {
        hasError = true;
        switch (value) {
          case 'invalid-email':
            emailError = 'The email is Invalid!';
            break;
          case 'user-not-found':
            emailError = 'The user does not exist!';
            break;
          case 'wrong-password':
            passError = 'The password is wrong!';
            break;
          case 'unknown':
            passError = emailError = "I don't know man...";
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
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FittedBox(
                  child: Text("Welcome to QED!",
                      style: Theme.of(context).textTheme.headline2)),
              TextField(
                decoration:
                    InputDecoration(hintText: "Email", errorText: emailError),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                decoration:
                    InputDecoration(hintText: "Password", errorText: passError),
                controller: passController,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
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
