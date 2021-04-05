import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planty_app/models/plant_model.dart';
import 'package:planty_app/models/user.dart';
import 'package:planty_app/screens/home/user_tile.dart';
import 'package:planty_app/screens/plants/plant_tile.dart';
import 'package:provider/provider.dart';

class PlantList extends StatefulWidget {
  @override
  _PlantListState createState() => _PlantListState();
}

class _PlantListState extends State<PlantList> {
  @override
  Widget build(BuildContext context) {

    final users = Provider.of<List<UserInfo>>(context) ?? [];
    print(users);

    return Expanded(
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context,index){
          return PlantTile(
              plant: users[index]);
        },
      ),
    );
  }
}
