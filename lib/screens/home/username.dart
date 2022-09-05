import 'package:flutter/material.dart';
import 'package:planty_app/models/user.dart';
import 'package:planty_app/shared/constants.dart';
import 'package:provider/provider.dart';

class UserName extends StatefulWidget {
  @override
  _UserNameState createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<UserInfo>>(context) ?? [];

    return RichText(
        text: TextSpan(
            text: "Hey ",
            style: TextStyle(color: kDefaultText, fontSize: 26),
            children: <TextSpan>[
          TextSpan(text: users[0].username, style: TextStyle(fontWeight: FontWeight.bold))
        ]));
  }
}
