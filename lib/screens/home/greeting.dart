import 'package:flutter/material.dart';
import 'package:planty_app/models/user.dart';
import 'package:planty_app/screens/home/username.dart';
import 'package:planty_app/services/database.dart';
import 'package:planty_app/shared/constants.dart';
import 'package:provider/provider.dart';

class Greeting extends StatefulWidget {
  @override
  _GreetingState createState() => _GreetingState();
}

class _GreetingState extends State<Greeting> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
            UserModel user = Provider.of<UserModel>(context);


    return StreamProvider<List<UserInfo>>.value(
          value: DatabaseService(uid: user.uid).users,

          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserName(),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            "Let’s keep your plants healthy!",
            style: TextStyle(
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
