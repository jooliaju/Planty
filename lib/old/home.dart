import "package:flutter/material.dart";
import 'package:planty_app/models/user.dart';
import 'package:planty_app/screens/user/update_user.dart';
import 'package:planty_app/old/plant_screen.dart';
import 'package:planty_app/services/auth.dart';
import 'package:planty_app/services/database.dart';
import 'package:provider/provider.dart';
import 'user_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);

    return StreamProvider<List<UserInfo>>.value(
      value: DatabaseService(uid: user.uid).users,
      child: Scaffold(
        backgroundColor: Colors.lightGreen[100],
        body: SafeArea(
            child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Helllooooooo!!!'),
                    RaisedButton(
                      onPressed: () {
                        _auth.signOut();
                      },
                      child: Text(
                        'Sign Out',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blueGrey,
                    ),
                    UserList(),
                    RaisedButton(
                      // onPressed: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => UpdateUser()),
                      //   );
                      // },
                      child: Text(
                        'Update User',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blueGrey,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlantScreen()),
                        );
                      },
                      child: Text(
                        'Plant Screen',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blueGrey,
                    ),
                    RaisedButton(
                      onPressed: () {
                        print(user.uid);
                      },
                      child: Text(
                        'Print current UID',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blueGrey,
                    ),
                  ],
                ))),
      ),
    );
  }
}
