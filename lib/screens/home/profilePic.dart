import 'package:flutter/material.dart';
import 'package:planty_app/models/user.dart';
import 'package:planty_app/screens/home/image.dart';
import 'package:planty_app/services/database.dart';
import 'package:provider/provider.dart';

class ProfilePic extends StatefulWidget {
  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  @override
  Widget build(BuildContext context) {
        UserModel user = Provider.of<UserModel>(context);

    return StreamProvider<List<UserInfo>>.value(
            value: DatabaseService(uid: user.uid).users,

      child: Padding(
                            padding: const EdgeInsets.all(40),
                            child: Container(
                                height: 60,
                                width: 60,
                                child: GestureDetector(
                                  onTap: () {
                                    print("you need to add a profile page");

                                    print("tappedssss");
                                  },
                                  child: Avatar()
                                )),
                          ),

     //  Image.asset("assets/images/profile_pic.png", scale: 3.5)
    );
  }
}
