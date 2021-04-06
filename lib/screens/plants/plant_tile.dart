import 'package:flutter/material.dart';
import 'package:planty_app/models/plant_model.dart';
import 'package:planty_app/models/user.dart';

class PlantTile extends StatelessWidget {
  final Plant plant;

  PlantTile({this.plant});

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
          title: Text(plant.name),
        ),
      ),


    );
  }
}
