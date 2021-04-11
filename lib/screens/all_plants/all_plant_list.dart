import 'package:flutter/material.dart';
import 'package:planty_app/models/plant_model.dart';
import 'package:planty_app/screens/all_plants/all_plants_tile.dart';
import 'package:provider/provider.dart';

class AllPlantList extends StatefulWidget {
  @override
  _AllPlantListState createState() => _AllPlantListState();
}

class _AllPlantListState extends State<AllPlantList> {
  @override
  Widget build(BuildContext context) {
    final plants = Provider.of<List<Plant>>(context) ?? [];
    print(plants.length);

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 3,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return AllPlantTile(
          plant: plants[index],
        );
      },
    );
  }
}
