import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planty_app/animations/FadeAnimation.dart';
import 'package:planty_app/screens/auth/sign_up.dart';
import 'package:planty_app/services/auth.dart';
import 'package:planty_app/shared/constants.dart';
import 'package:planty_app/shared/loading.dart';

class LoginPage extends StatefulWidget {

  final Function toggleView;
  LoginPage({ this.toggleView });

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final auth = FirebaseAuth.instance;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {


    final emailField = 
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          "Email",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(height: 10),
        
        TextFormField(
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),

         ),
      validator: (val) => val.isEmpty ? "Enter an email" : null,
      onChanged: (val) {
        setState(() {
          email = val;
        });
      },
    )
    ],);
   

    final passwordField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          "Password",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(height: 10),

        TextFormField(
        obscureText: true,
        style: style,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            ),
        validator: (val) =>
            val.length < 6 ? "Enter a password that is 6+ chars long" : null,
        onChanged: (val) {
          setState(() {
            password = val;
          });
        })],
    );
    

    // final loginButton = Material(
    //   elevation: 5.0,
    //   borderRadius: BorderRadius.circular(30.0),
    //   color: Color(0xff01A0C7),
    //   child: MaterialButton(
    //     minWidth: MediaQuery.of(context).size.width,
    //     padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    //     onPressed: () async {
    //       if (_formKey.currentState.validate()) {
    //         setState(() {
    //           loading = true;
    //         });

    //         print("email entered: " + email);
    //         print("password entered: " + password);

    //         dynamic result =
    //             await authService.signInWithEmailAndPassword(email, password);
    //         if (result == null) {
    //           setState(() {
    //             loading = false;
    //             error = "Please supply a valid email";
    //           });
    //         }
    //       }
    //     },
    //     child: Text("Login",
    //         textAlign: TextAlign.center,
    //         style: style.copyWith(
    //             color: Colors.white, fontWeight: FontWeight.bold)),
    //   ),
    // );


    final loginButton = MaterialButton(
      minWidth: double.infinity,
      height: 60,
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          setState(() {
            loading = true;
          });

          print("email entered: " + email);
          print("password entered: " + password);

          dynamic result =
              await authService.signInWithEmailAndPassword(email, password);
          if (result == null) {
            setState(() {
              loading = false;
              error = "Please supply a valid email";
            });
          }
        }
      },
      color: kDeepBlue,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Text(
        "Login",
        style: TextStyle(
            fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18),
      ),
    );

    return loading ? Loading() :Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              FadeAnimation(
                                  1,
                                  Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              FadeAnimation(
                                  1.2,
                                  Text(
                                    "Login to your account",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey[700]),
                                  )),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: <Widget>[
                                FadeAnimation(1.2, emailField),
                                SizedBox(
                                  height: 20,
                                ),
                                FadeAnimation(1.3, passwordField),
                              ],
                            ),
                          ),
                          FadeAnimation(
                              1.4,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Container(
                                    padding: EdgeInsets.only(top: 3, left: 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border(
                                          bottom:
                                              BorderSide(color: Colors.black),
                                          top: BorderSide(color: Colors.black),
                                          left: BorderSide(color: Colors.black),
                                          right:
                                              BorderSide(color: Colors.black),
                                        )),
                                    child: loginButton),
                              )),
                          FadeAnimation(
                              1.5,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Don't have an account?"),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignupPage()));
                                    },
                                    child: Text(
                                      "Sign up",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                  // FadeAnimation(
                  //     1.2,
                  //     Container(
                  //       height: MediaQuery.of(context).size.height / 3,
                  //       decoration: BoxDecoration(
                  //           image: DecorationImage(
                  //               image: AssetImage('assets/background.png'),
                  //               fit: BoxFit.cover)),
                  //     ))
                ],
              ),
            ),
          );
  }

  Widget makeInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
