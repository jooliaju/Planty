import 'package:flutter/material.dart';
import 'package:planty_app/models/plant_model.dart';

import 'package:planty_app/old/plant_tile.dart';
import 'package:planty_app/screens/home/plant_tilenew.dart';
import 'package:planty_app/screens/plant_profile/plant_profile.dart';
import 'package:planty_app/shared/constants.dart';
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
      height: 270,
      child: ListView.builder(
        padding: EdgeInsets.only(right: kDefaultPadding),
        scrollDirection: Axis.horizontal,
        itemCount: plants.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlantProfile(
                      plant: plants[index],
                    )),
              );
            },

              child: PlantTileNew(plant: plants[index]));
        },
      ),
    );
  }
}
