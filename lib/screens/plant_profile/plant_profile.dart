import 'dart:io';

import 'package:flutter/material.dart';
import 'package:planty_app/models/plant_model.dart';
import 'package:planty_app/shared/constants.dart';

class PlantProfile extends StatefulWidget {
  Plant plant;
  PlantProfile({this.plant});
  @override
  _PlantProfileState createState() => _PlantProfileState();
}

class _PlantProfileState extends State<PlantProfile> {
  File _image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackground,
      body: Column(
        children: [
          Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                height: size.height * .55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6),
                    ]),
                child: ClipRRect(
                  child: _image == null
                      ? Image(
                          width: size.width,
                          image: AssetImage("assets/images/bonsai.png"),
                          fit: BoxFit.cover)
                      : Image.file(_image, fit: BoxFit.cover),
                ),
              ),
              Positioned(
                top: size.height * .5,
                child: Container(
                    alignment: Alignment.center,
                    height: size.height * .5,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: kGreen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                      ),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
