import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planty_app/models/plant_model.dart';

import 'package:planty_app/old/plant_tile.dart';
import 'package:provider/provider.dart';

class PlantList extends StatefulWidget {
  @override
  _PlantListState createState() => _PlantListState();
}

class _PlantListState extends State<PlantList> {


  @override
  Widget build(BuildContext context) {

    final plants = Provider.of<List<Plant>>(context) ?? [];
    print(plants);

    return Expanded(
      child: ListView.builder(
        itemCount: plants.length,
        itemBuilder: (context,index){
          return PlantTile(
              plant: plants[index]);
        },
      ),
    );
  }
}
