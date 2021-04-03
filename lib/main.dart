import 'package:flutter/material.dart';
// import 'package:planty_app/screens/auth/signIn.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:planty_app/models/user.dart';
import 'package:planty_app/screens/auth/signIn.dart';
import 'package:planty_app/screens/wrapper.dart';
import 'package:planty_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      value: AuthService().user, //accesses the user stream, listening to this stream, wraps the materialapp
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
       
        home: Wrapper (),

      ),
    );
  }
}
