import 'package:flutter/material.dart';
import 'package:planty_app/models/plant_model.dart';


class plantGuess extends StatefulWidget {
    PlantId plantId;
  plantGuess({this.plantId});
  @override
  _plantGuessState createState() => _plantGuessState();
}

class _plantGuessState extends State<plantGuess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text(widget.plantId.commonName)
      ],),
    );
  }
}