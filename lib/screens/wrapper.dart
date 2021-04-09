import 'package:flutter/material.dart';
import 'package:planty_app/models/user.dart';
import 'package:planty_app/screens/auth/signIn.dart';
import 'package:planty_app/old/home.dart';
import 'package:planty_app/screens/home/home_new.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user =
        Provider.of<UserModel>(context); //accesses user data from provider
    print(user);
    //returns home or auth page

    if (user == null) {
      return SignInPage();
    } else {

      ///temp!

      return HomeScreenNew();
      // return HomeScreen();

    }
  }
}
