import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planty_app/models/user.dart';
import 'package:planty_app/services/database.dart';
import 'package:planty_app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class AddPlant extends StatefulWidget {
  @override
  _AddPlantState createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  final _formKey = GlobalKey<FormState>();

  final List<int> days = [0, 1, 2, 3, 4, 5, 6, 7];

  //form values
  String _name;
  String _type;
  String _bio;
  int _waterTime;
  String imageUrl;
  File _image;
  final picker = ImagePicker();



  TextStyle style =
      TextStyle(fontSize: 20, color: kGreyBlue, fontWeight: FontWeight.bold);


  //get photo from gallery
  Future getImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource
            .camera); //make a function for pick form gallery and one for camera

    setState(() async {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


  Future takeImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource
            .gallery); //make a function for pick form gallery and one for camera

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }



  uploadImage(File _image) async {
    String imageName = path.basename(_image.path);
    final _storage = FirebaseStorage.instance;
    var snapshot = await _storage.ref()
        .child('folderName/${imageName}')
        .putFile(_image);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    print(downloadUrl);
    setState(() {
      imageUrl = downloadUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          GestureDetector(
            onTap: takeImage,
            child: Stack(
              children: <Widget>[
                Container(
                  height: size.height * .36,

                  //shadow
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 8),
                      ]),
                  //show this image if there is no image selected
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: _image == null? Image(
                        width: size.width,
                        image: AssetImage("assets/images/add_plant_bg.png"),
                        fit: BoxFit.cover): Image.file(_image, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 130,
                  left: size.width * .3,
                  child: _image == null? Center(
                    child: Column(
                      children: [
                        Text(
                          "Add an image of \nyour plant!",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: size.width * 0.04),
                        Image.asset(
                          'assets/icons/add_image.png',
                          scale: 3.5,
                        )
                      ],
                    ),
                  ): Container(),
                )
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              child: Column(children: <Widget>[
                Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      "assets/icons/back_arrow_1.png",
                      scale: 3,
                    )),
                SizedBox(height: size.width * 0.09),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Type",
                      style: style,
                    ),
                    GestureDetector(
                      onTap: () {
                        ///add in plant identifier stuff
                      },
                      child: RichText(
                          text: TextSpan(
                              text: "not sure? try",
                              style: TextStyle(color: HexColor("566C71")),
                              children: <TextSpan>[
                            TextSpan(
                                text: " find plant ID",
                                style: TextStyle(color: HexColor("F6C84D")))
                          ])),
                    )
                  ],
                ),
                SizedBox(height: size.width * 0.03),
                TextFormField(
                  onChanged: (val) => setState(() => _type = val),

                  decoration: InputDecoration(
                    fillColor: kBackground,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.yellow,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        color: kBackground,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        color: kBackground,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.width * 0.1),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Give it a name", style: style)),
                SizedBox(height: size.width * 0.03),
                TextFormField(
                  onChanged: (val) => setState(() => _name = val),

                  decoration: InputDecoration(
                    fillColor: kBackground,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.yellow,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        color: kBackground,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        color: kBackground,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.width * 0.1),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("How often do you water it?", style: style)),
                SizedBox(height: size.width * 0.03),
                Align(
                  alignment: Alignment.centerLeft,
                  child: DropdownButton<int>(
                    value: _waterTime,
                    items: days.map((day) {
                      return DropdownMenuItem(
                        value: day ?? 3,
                        child: Text('$day days'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _waterTime = val),
                  ),
                ),
                SizedBox(height: size.width * 0.05),
                FlatButton(
                  height: 50,
                  minWidth: 150,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                  onPressed: () async{

                    await uploadImage(_image);
                    if (_formKey.currentState.validate()) {
                      print("this is the image url: ");
                      await DatabaseService(uid: user.uid)
                          .addPlant(_name,_bio,_type, _waterTime, imageUrl);
                    }

                    Navigator.pop(context);
                  },
                  color: kGreen,
                  child: Text("Add This Plant",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
