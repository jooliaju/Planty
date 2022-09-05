
import 'package:flutter/material.dart';
import 'package:planty_app/screens/auth/login.dart';
import 'package:planty_app/screens/auth/sign_in.dart';
import 'package:planty_app/screens/auth/sign_up.dart';
import 'package:planty_app/screens/auth/welcome.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInPage();
    } else {
      return SignupPage(toggleView:  toggleView);
    }
  }
}