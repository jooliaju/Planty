import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:planty_app/models/plant_model.dart';
import 'package:planty_app/screens/timeline/timeline.dart';
import 'package:planty_app/shared/constants.dart';
import 'package:intl/intl.dart';

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
    int _daysUntilWater = widget.plant.nextWaterDate.difference(DateTime.now()).inDays + 1;



    print(widget.plant.waterTime.toString());

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
                          image: NetworkImage(widget.plant.imageUrl),
                          fit: BoxFit.cover)
                      : Image.file(_image, fit: BoxFit.cover),
                ),
              ),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 45),
                 child: Row(
                  
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                  GestureDetector(
                    
                    onTap: () async {
                Navigator.pop(context);
              },
                    child: Image.asset("assets/icons/back_arrow_3.png", scale:3)),
                  GestureDetector(child: Image.asset("assets/icons/timeline_button.png", scale:3,),
                   onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Timeline(plant: widget.plant)),
                            );
                          },
                  )
              ]),
               ),
              Positioned(
                top: size.height * .48,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 35,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      child: Center(
                          child: Text(DateFormat.yMMMd().format(DateTime.now()),
                              style: TextStyle(color: HexColor("2C6975")))),
                    ),
                    Container(
                      height: size.height * .5,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: kGreen,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: kDefaultPadding,
                            top: kDefaultPadding,
                            bottom: kDefaultPadding),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.plant.name,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(widget.plant.type,
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset("assets/icons/water.png"),
                                        SizedBox(width: 10),
                                        Text(
                                          widget.plant.waterTime.toString() + " Days",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                            "assets/icons/temperature.png"),
                                        SizedBox(width: 10),
                                        Text(
                                          "25-30 C˚",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                            "assets/icons/sunlight.png"),
                                        SizedBox(width: 10),
                                        Text(
                                          "Natural Light",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  width: size.width * .5,
                                  height: size.width * .5,
                                  decoration: BoxDecoration(
                                      color: kLightGreen,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          bottomLeft: Radius.circular(25))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Text("Water in",
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                          _daysUntilWater.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 15),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Information',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "widget.plant.bio",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
