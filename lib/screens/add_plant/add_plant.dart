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
  String _name;
  String _bio;
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
                      initialValue: userData.name,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Plant Name'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a plant name' : null,
                      onChanged: (val) => setState(() => _name = val),
                    ),
                    TextFormField(
                      initialValue: userData.bio,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Plant Type'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a plant breed' : null,
                      onChanged: (val) => setState(() => _bio = val),
                    ),
                    DropdownButton<int>(
                      value: _waterTime ?? userData.waterTime,
                      items: days.map((day) {
                        return DropdownMenuItem(
                          value: day ?? 0,
                          child: Text('$day days'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _waterTime = val ),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        print(_bio);
                        print(_name);
                        print(_waterTime);


                        if(_formKey.currentState.validate()){
                          await DatabaseService(uid: user.uid).updateUserData(_name ?? userData.name, _bio ?? userData.bio, _waterTime ?? userData.waterTime, null);
                        }


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
