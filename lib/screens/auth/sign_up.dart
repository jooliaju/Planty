import 'package:flutter/material.dart';
import 'package:planty_app/animations/FadeAnimation.dart';
import 'package:planty_app/screens/auth/login.dart';
import 'package:planty_app/services/auth.dart';
import 'package:planty_app/shared/constants.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

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
    


final signUpButton = MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () async {
          //add logging stuff too

          if (_formKey.currentState.validate()) {
            setState(() {
              loading = true;
            });

            print("email entered: " + email);
            print("password entered: " + password);

            dynamic result =
                await authService.registerWithEmailAndPassword(email, password);

                
            if (result == null) {
              setState(() {
                error = "Please supply a valid email";
                loading = false;
              });
            }
          }
        },
                  color: kLightGreen,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Text("Sign up", style: TextStyle(
                    fontWeight: FontWeight.w600, 
                    fontSize: 18
                  ),),
                );


    
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeAnimation(1, Text("Sign up", style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),)),
                  SizedBox(height: 20,),
                  FadeAnimation(1.2, Text("Create an account, It's free", style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700]
                  ),)),
                ],
              ),
              Column(
                children: <Widget>[
                  FadeAnimation(1.2, emailField),
                  FadeAnimation(1.3, passwordField),
                  FadeAnimation(1.4, makeInput(label: "Confirm Password", obscureText: true)),
                ],
              ),
              FadeAnimation(1.5, Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                  )
                ),
                child: signUpButton
              )),
              FadeAnimation(1.6, Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?"),
                  GestureDetector(
                    onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));

                    },
                                      child: Text(" Login", style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18
                    ),),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87
        ),),
        SizedBox(height: 5,),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400])
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400])
            ),
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }
}