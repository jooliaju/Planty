
import 'package:flutter/material.dart';
import 'package:planty_app/services/auth.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:planty_app/shared/loading.dart';



class SignInPage extends StatefulWidget {
  SignInPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final auth = FirebaseAuth.instance;
  final AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;


  // text field states
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    final emailField = TextFormField(

      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),

      validator: (val)=> val.isEmpty? "Enter an email": null,
      onChanged: (val) {

        setState(() {
          email = val;
        });


      },
    );

    final passwordField = TextFormField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),

          validator: (val)=> val.length < 6 ? "Enter a password that is 6+ chars long": null,
          onChanged: (val) {

            setState(() {
              password = val;
            });



          }
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async{
          if (_formKey.currentState.validate()) {

            setState(() {
              loading = true;
            });

            print("email entered: " + email);
            print("password entered: " + password);

            dynamic result = await authService.signInWithEmailAndPassword(email, password);
            if (result==null){
              setState(() {
                loading = false;
                error = "Please supply a valid email";
              });
            }

          }


        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final signUpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.deepOrange,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async{
          //add logging stuff too

          if (_formKey.currentState.validate()) {
            setState(() {
              loading = true;
            });

            print("email entered: " + email);
            print("password entered: " + password);

            dynamic result = await authService.registerWithEmailAndPassword(email, password);
            if (result==null){
              setState(() {
                error = "Please supply a valid email";
                loading = false;
              });
            }

          }

        },
        child: Text("Sign up",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return loading?  Loading() : Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 155.0,
                      child: Align(

                        alignment: Alignment.center,
                        child: Text(
                          "lol pls add logo here :)",
                          style: TextStyle (
                              fontSize: 30
                          ),
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 45.0),
                          emailField,
                          SizedBox(height: 25.0),
                          passwordField,
                          SizedBox(
                            height: 35.0,
                          ),
                          loginButton,
                          SizedBox(
                            height: 15.0,
                          ),
                          signUpButton,
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          )
                        ],
                      ),

                    ),

                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}