import 'package:flutter/material.dart';
import 'package:planty_app/models/plant_model.dart';
import 'package:planty_app/shared/constants.dart';

class plantGuess extends StatefulWidget {
  PlantId plantId;
  plantGuess({this.plantId});
  @override
  _plantGuessState createState() => _plantGuessState();
}

class _plantGuessState extends State<plantGuess> {
  @override
  Widget build(BuildContext context) {
    var score = widget.plantId.score*100;
    print(score);

    return Scaffold(
      backgroundColor: kBackground,
      body: Center(
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.plantId.commonName),
            Text(widget.plantId.scientificName),

            Text(score.toInt().toString() + "% sure that this is the right plant"), //shows percentage

          ],
        ),
      ),
    );
  }
}
