import 'package:flutter/material.dart';
import 'package:planty_app/shared/constants.dart';
import 'package:planty_app/models/plant_model.dart';
import 'package:planty_app/models/user.dart';

class PlantTileNew extends StatelessWidget {
  final Plant plant;

  PlantTileNew({this.plant});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: kDefaultPadding),
        child: Container(
            width: 160,
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    plant.imageUrl,
                    fit: BoxFit.fill,
                    height: 180,
                    width: 200,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(kDefaultPadding - 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 20,
                            color: kGreen.withOpacity(0.23))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plant.name,
                            style: TextStyle(fontSize: 14, color: kDefaultText),
                          ),
                          Text(
                            plant.type,
                            style: TextStyle(
                                fontSize: 14,
                                color: kGreen,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Text("${plant.waterTime} days",
                          style: TextStyle(
                              fontSize: 14,
                              color: kGreen,
                              fontWeight: FontWeight.w600))
                    ],
                  ),
                )
              ],
            )));
  }
}
