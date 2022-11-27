import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:qed/firebase/qedstore.dart';
import 'package:qed/screens/signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var hintMap = {
    0: 'name',
    1: 'nickname',
    2: 'email',
    3: 'password',
    4: 'confirm password'
  };
  late List<TextEditingController> controllers;

  String? emailValidator(String? value) {
    if (value == null) return 'Please enter an email';
    return null;
    int posa = value.indexOf('@');
    int posd = value.indexOf('.');
    if (posa == -1 || posd == -1 || posa > posd)
      return 'Please enter a vallid email.';
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null) return 'Please enter a password';
    if (value.length < 3) return 'Please enter a stronger password.';
    if (value != controllers.last.text) return 'The passwords must match.';
  }

  final int fieldNum = 5;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    controllers = List.generate(fieldNum, (index) => TextEditingController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                fieldNum,
                (index) => TextFormField(
                  controller: controllers[index],
                  decoration: InputDecoration(
                    hintText: hintMap[index],
                  ),
                  validator: index == 2
                      ? emailValidator
                      : index == 3
                          ? passwordValidator
                          : (value) => null,
                  obscureText: (index == 3 || index == 4) ? true : false,
                  keyboardType: index == 2
                      ? TextInputType.emailAddress
                      : index == 3 || index == 4
                          ? TextInputType.visiblePassword
                          : TextInputType.name,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await QEDStore.instance
                        .signUpUser(
                            name: controllers[0].text,
                            nickname: controllers[1].text,
                            email: controllers[2].text,
                            password: controllers[3].text)
                        .then(
                            (value) => Navigator.popAndPushNamed(context, '/'));
                  }
                },
                child: Text("Sign up"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(
                  context,
                ),
                child: Text("Return"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("or"),
              ),
              SignInButton(
                Buttons.GoogleDark,
                onPressed: () async {
                  await QEDStore.instance
                      .singInWithGoogle()
                      .then((value) => Navigator.popAndPushNamed(context, '/'));
                },
                padding: EdgeInsets.all(16.0),
                elevation: 20.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
