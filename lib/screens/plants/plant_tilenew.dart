import 'package:flutter/material.dart';
import 'package:planty_app/constants.dart';
import 'package:planty_app/models/plant_model.dart';
import 'package:planty_app/models/user.dart';

class PlantTileNew extends StatelessWidget {
  final Plant plant;

  PlantTileNew({this.plant});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 8),

      child: Container(
        width: 200,
        margin: EdgeInsets.only(right:20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kGreyBlue,
        ),
        child: Center(child: Text(plant.name, style: TextStyle(color: Colors.white),)),

      )


    );
  }
}
