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
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:planty_app/models/plant.dart';
import 'package:planty_app/screens/add_plant/add_plant.dart';
import 'package:planty_app/services/auth.dart';
import 'package:planty_app/services/database.dart';
import 'package:provider/provider.dart';
import 'plantList.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Plant>>.value(
      value: DatabaseService().plants,
      child: Scaffold(
        backgroundColor: Colors.lightGreen[100],
        body: SafeArea(
          child: Align(
              alignment: Alignment.center,



              child: Column (
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Helllooooooo!!!'),
                  RaisedButton(
                    onPressed: (){
                      _auth.signOut();
                    },
                    child: Text('Sign Out',
                    style: TextStyle(
                      color: Colors.white
                    )
                      ,),
                    color: Colors.blueGrey,),

                  PlantList(),

                  RaisedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddPlant()),
                      );

                    },
                    child: Text('Add Plant',
                      style: TextStyle(
                          color: Colors.white
                      )
                      ,),
                    color: Colors.blueGrey,),

                ],
              )

          )
        ),
      ),
    );
  }
}
