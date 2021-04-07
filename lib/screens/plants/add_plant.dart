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
  String _type;
  String _bio;
  int _waterTime;

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);

    return Form(
      key: _formKey,
      child: Scaffold(
                  appBar: AppBar(
                    title: Text("temp form"),
                  ),
                  body: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Plant Name'),
                        validator: (val) =>
                        val.isEmpty ? 'Please enter a plant name' : null,
                        onChanged: (val) => setState(() => _name = val),
                      ),

                      RaisedButton(
                        onPressed: () async {
                          print(_name);


                          if(_formKey.currentState.validate()){
                            await DatabaseService(uid: user.uid).addPlant(_name, _type, _bio, _waterTime);
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



  }

