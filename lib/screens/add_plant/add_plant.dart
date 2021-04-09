import 'package:flutter/material.dart';

class AddPlant extends StatefulWidget {
  @override
  _AddPlantState createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container( height: size.height*.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 6
                ),]
              ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image(
                    
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
