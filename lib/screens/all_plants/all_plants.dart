import "package:flutter/material.dart";
import 'package:planty_app/screens/all_plants/all_plant_list.dart';
import 'package:planty_app/screens/all_plants/all_plants_tile.dart';
import 'package:planty_app/shared/constants.dart';
import 'package:planty_app/models/plant_model.dart';
import 'package:planty_app/models/user.dart';
import 'package:planty_app/screens/add_plant/add_plant.dart';
import 'package:planty_app/screens/home/plant_listnew.dart';

import 'package:planty_app/services/auth.dart';
import 'package:planty_app/services/database.dart';
import 'package:provider/provider.dart';

class AllPlants extends StatefulWidget {
  @override
  _AllPlantsState createState() => _AllPlantsState();
}

class _AllPlantsState extends State<AllPlants> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);
    Size size = MediaQuery.of(context).size;

    return StreamProvider<List<Plant>>.value(
      value: DatabaseService(uid: user.uid).plants,
      child: Scaffold(
          backgroundColor: kBackground,
          body: Container(
            child: Column(
              children: [
                //Custom AppBar
                Container(
                  margin: EdgeInsets.only(left: kDefaultPadding),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: kDefaultPadding),
                        child: Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                "assets/icons/back_arrow_2.png",
                                scale: 3,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        child: Image.asset("assets/images/leaf.png", scale: 3),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: size.width * 0.05,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("My Plants",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26)),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddPlant()),
                            );
                          },
                          child: Image.asset("assets/icons/add.png", scale: 3))
                    ],
                  ),
                ),

                AllPlantList()
              ],
            ),
          )),
    );
  }
}
