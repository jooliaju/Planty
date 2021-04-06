// import "package:flutter/material.dart";
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//
//       ),
//     );
//   }
//
import "package:flutter/material.dart";
import 'package:planty_app/models/plant_model.dart';
import 'package:planty_app/models/user.dart';
import 'package:planty_app/screens/plants/add_plant.dart';
import 'package:planty_app/screens/plants/plant_list.dart';
import 'package:planty_app/services/auth.dart';
import 'package:planty_app/services/database.dart';
import 'package:provider/provider.dart';

class PlantScreen extends StatefulWidget {
  @override
  _PlantScreenState createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);

    return StreamProvider<List<Plant>>.value(
      value: DatabaseService(uid: user.uid).plants,
      child: Scaffold(
        backgroundColor: Colors.lightGreen[100],
        body: SafeArea(
            child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PlantList(),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddPlant()),
                        );
                      },
                      child: Text(
                        'Add Plant',
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
