import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planty_app/models/user.dart';
import 'package:planty_app/services/database.dart';
import 'package:planty_app/shared/loading.dart';
import 'package:provider/provider.dart';

class AddPlant extends StatefulWidget {
  @override
  _AddPlantState createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  final _formKey = GlobalKey<FormState>();
  final List<int> days = [0 ,1 ,2 ,3 ,4 ,5 ,6 ,7];

  //form values
  String _plantName;
  String _plantType;
  int _waterTime; //in days

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            print("lol1 ${snapshot.hasData}");
            return Form(
              key: _formKey,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("temp form"),
                ),
                body: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: userData.plantName,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Plant Name'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a plant name' : null,
                      onChanged: (val) => setState(() => _plantName = val),
                    ),
                    TextFormField(
                      initialValue: userData.plantType,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Plant Type'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a plant breed' : null,
                      onChanged: (val) => setState(() => _plantType = val),
                    ),
                    DropdownButton<int>(
                      value: _waterTime ?? userData.waterTime,
                      items: days.map((day) {
                        return DropdownMenuItem(
                          value: day ?? 3,
                          child: Text('$day days'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _waterTime = val ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        print(_plantType);
                        print(_plantName);
                        print(_waterTime);

                        Navigator.pop(context);
                      },
                      child: Text("update"),
                    )
                  ],
                ),
              ),
            );


          }

          else {

            return Loading();
          }
        });
  }
}
