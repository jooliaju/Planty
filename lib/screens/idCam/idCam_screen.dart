import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:planty_app/models/plant_model.dart';
import 'package:planty_app/screens/idCam/plant_guess.dart';
import 'package:planty_app/services/plant_id_service.dart';

class idCamScreen extends StatefulWidget {
  @override
  _idCamScreenState createState() => _idCamScreenState();
}

class _idCamScreenState extends State<idCamScreen> {
  File _image;
  final picker = ImagePicker();
  PlantId plantId;
  Dio dio = new Dio();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: 800,
              width: 400,
              child: _image == null
                  ? Text(
                      'Snap or upload a photo of your plant!') //replace with filler image if there is no photo uploaded
                  : Image.file(_image),
            ),
          ),
          Row(
            children: [
              FlatButton.icon(
                onPressed: getImage,
                icon: Icon(Icons.add_a_photo),
                label: Text("Camera"),
              ),
              FlatButton.icon(
                onPressed: takeImage,
                icon: Icon(Icons.photo_album_rounded),
                label: Text("Album"),
              ),
              RaisedButton.icon(
                  onPressed: () {
                    _image == null
                        ? print("no photo available to send a request")
                        : setState(() async {
                            String fileName = _image.path.split("/").last;

                            plantId = await PlantIdService().upload(
                                imageFile: fileName, imagePath: _image.path);
                            print(plantId.commonName);

                            print(plantId.scientificName);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      plantGuess(plantId: plantId)),
                            );
                          });
                  },
                  icon: Icon(Icons.arrow_forward_ios),
                  label: Text("next"))
            ],
          )
        ],
      ),
    );
  }
}
