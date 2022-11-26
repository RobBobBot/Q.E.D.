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
  final int fieldNum = 5;

  final _formKey = GlobalKey<FormState>();

  late List<TextEditingController> controllers;

  @override
  void initState() {
    // TODO: implement initState
    controllers = List.filled(fieldNum, TextEditingController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(),
            flex: 1,
          ),
          Expanded(
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
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Sign up"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignIn(),
                    ),
                    (a) => false,
                  ),
                  child: Text("Return"),
                ),
                Text("or"),
                SignInButton(
                  Buttons.GoogleDark,
                  onPressed: () {
                    QEDStore.instance.singInWithGoogle();
                  },
                  padding: EdgeInsets.all(16.0),
                  elevation: 20.0,
                ),
              ],
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
