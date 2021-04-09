import 'package:flutter/material.dart';
import 'package:planty_app/models/plant_model.dart';

import 'package:planty_app/screens/plants/plant_tile.dart';
import 'package:planty_app/screens/plants/plant_tilenew.dart';
import 'package:provider/provider.dart';

class PlantListNew extends StatefulWidget {
  @override
  _PlantListNewState createState() => _PlantListNewState();
}

class _PlantListNewState extends State<PlantListNew> {


  @override
  Widget build(BuildContext context) {

    final plants = Provider.of<List<Plant>>(context) ?? [];
    print(plants.length);

    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: plants.length,
        itemBuilder: (context,index){
          return PlantTileNew( plant: plants[index]);
        },
      ),
    );
  }
}
