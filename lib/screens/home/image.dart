import 'package:flutter/material.dart';
import 'package:planty_app/models/user.dart';
import 'package:planty_app/shared/constants.dart';
import 'package:provider/provider.dart';

class Avatar extends StatefulWidget {
  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<UserInfo>>(context) ?? [];

    return CircleAvatar(
      backgroundColor: Colors.white,
      backgroundImage: NetworkImage(users[0].avatarUrl),
    );
  }
}


// ddd
