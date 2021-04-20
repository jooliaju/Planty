import 'package:flutter/material.dart';
import 'package:planty_app/models/user.dart';

class UserTile extends StatelessWidget {
  final UserInfo user;

  UserTile({this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 8),

      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.green
          ),
          title: Text(user.name),
          subtitle: Text(user.bio),
        ),
      ),


    );
  }
}
