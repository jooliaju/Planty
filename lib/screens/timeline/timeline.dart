import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planty_app/models/plant_model.dart';
import 'package:planty_app/models/timeline_model.dart';
import 'package:planty_app/models/user.dart';
import 'package:planty_app/screens/timeline/entry_list.dart';
import 'package:planty_app/services/database.dart';
import 'package:planty_app/shared/constants.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class Timeline extends StatefulWidget {
  Plant plant;
  Timeline({this.plant});
  @override
  
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  String imageUrl;
  File _image;
  final picker = ImagePicker();
  

  //get photo from gallery
  Future takeImage(String uid) async {
    final pickedFile = await picker.getImage(
        source: ImageSource
            .camera); //make a function for pick form gallery and one for camera

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

    _showImage(uid);
  }

  Future getImage(String uid) async {
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
    _showImage(uid);
  }

  uploadImage(File _image) async {
    String imageName = path.basename(_image.path);
    final _storage = FirebaseStorage.instance;
    var snapshot =
        await _storage.ref().child('Timeline/${imageName}').putFile(_image);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    print(downloadUrl);
    setState(() {
      imageUrl = downloadUrl;
    });
  }

  Future _showDialog(String uid) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Submit a photo"),
          content: new Text("Post a photo to update the timeline"),
          actions: <Widget>[
            FlatButton(
              child: Text("Album"),
              onPressed: () async {
                getImage(uid);
                Navigator.of(context).pop();
                _image != null ? _showImage(uid) : Container();
              },
            ),
            FlatButton(
              child: Text("Camera"),
              onPressed: () async {
                takeImage(uid);
                Navigator.of(context).pop();
                _image != null ? _showImage(uid) : Container();
              },
            ),
            FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future _showImage(String uid) {

    

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Image Captured!"),
          content: new Container(
            height: 400,
            child: _image != null
                ? Image.file(_image, fit: BoxFit.cover)
                : Container(),
          ),
          actions: <Widget>[

            FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                               Navigator.of(context).pop();

              },
            ),

            FlatButton(
              child: new Text("Post"),
              onPressed: () async{


                await uploadImage(_image);

                 await DatabaseService(uid: uid, plantId: widget.plant.plantId)
                          .addTimeline(updatedAt: DateTime.now(), imageUrl: imageUrl);
              },
            ),
          ],
        );
      },
    );

    if (_image == null ){
                      Navigator.of(context).pop();

    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);

    Size size = MediaQuery.of(context).size;

    return StreamProvider<List<TimelineModel>>.value(
      value: DatabaseService(plantId: widget.plant.plantId).timelines,
      child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                height: size.height * .3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    color: kBackground),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                  'assets/icons/back_arrow_2.png',
                                  scale: 2.8)),
                          Image.asset('assets/images/little_plants.png',
                              scale: 3.5)
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.plant.name,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(children: [
                            Text(
                              "Timeline",
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            Image.asset('assets/icons/timeline.png',
                                scale: 3.1),
                            Spacer(),
                            GestureDetector(
                                onTap: () {
                                  _showDialog(user.uid);
                                  setState(() {
                                    _image = null;
                                  });
                                },
                                child: Container(
                                  child: Image.asset(
                                    'assets/icons/add.png',
                                    scale: 3.3,
                                    
                                  ),
                                   decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(5, 5),
                            blurRadius: 18,
                            color: kLightGreen.withOpacity(0.5))
                      ]),
                                ))
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          EntryList()
        ],
      ),
    ));
  }
}
