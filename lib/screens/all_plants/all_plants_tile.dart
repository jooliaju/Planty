import 'dart:io';

import 'package:flutter/material.dart';
import 'package:planty_app/shared/constants.dart';
import 'package:planty_app/models/plant_model.dart';
import 'package:planty_app/models/user.dart';

class AllPlantTile extends StatelessWidget {
  final Plant plant;

  AllPlantTile({this.plant});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      margin: EdgeInsets.only(bottom: kDefaultPadding + 10, left: 40),
      decoration: BoxDecoration(
        color: kGreen,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200],
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(5, 5),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 140,
            height: 175,
            child: ClipRRect(
              child: Image.network(
                plant.imageUrl,
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
