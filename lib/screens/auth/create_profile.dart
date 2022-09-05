import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:planty_app/animations/FadeAnimation.dart';
import 'package:planty_app/models/user.dart';
import 'package:planty_app/screens/home/home_new.dart';
import 'package:planty_app/services/database.dart';
import 'package:planty_app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;


class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  bool loading = false;

  String displayName;

  final _formKey = GlobalKey<FormState>();

  String avatarUrl;
  File _image;
  final picker = ImagePicker();

    //get photo from gallery
  Future getImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource
            .gallery); //make a function for pick form gallery and one for camera

    setState(()  {
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
    var snapshot =
        await _storage.ref().child('folderName/${imageName}').putFile(_image);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    print(downloadUrl);
    setState(() {
      avatarUrl = downloadUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);

    final displayNameField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Display Name",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(height: 10),
        TextFormField(
            obscureText: true,
            style: style,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400])),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400])),
            ),
            validator: (val) =>
                val.length == 0 ? "We need a name for you!" : null,
            onChanged: (val) {
              setState(() {
                displayName = val;
              });
            })
      ],
    );

    final nextButton = MaterialButton(
        minWidth: double.infinity,
        height: 60,
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            setState(() {
              loading = true;
            });
          }
          
          
                           await uploadImage(_image);

          await DatabaseService(uid: user.uid).updateUserData(displayName, avatarUrl);

          Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => HomeScreenNew(),
              ),
              (route) =>
                  false); //if you want to disable back feature set to false
        },
        color: kYellow,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text(
        "Next",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      ),
      SizedBox(width: 10),
      Icon(Icons.arrow_forward)
      ],)
        
        
        );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 200),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                        1,
                        Text(
                          "Complete your profile",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                        1.2,
                        Text(
                          "Create an account, it's free",
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                        )),
                    SizedBox(
                      height: 20,
                    ),

                  ],
                ),

                Column(children: [
                    
                    _image != null? GestureDetector(onTap: getImage,
                                          child: CircleAvatar(
                        radius: 100,
                        backgroundImage: FileImage(_image)
                      ),
                    ): GestureDetector(
                      onTap: getImage,
                      child: Image.asset('assets/images/temp_profile_pic.png', scale: 2,)),



                    FadeAnimation(1, displayNameField),


                    SizedBox(height: 40,),
                   Container(
                              padding: EdgeInsets.only(top: 3, left: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border(
                                    bottom: BorderSide(color: Colors.black),
                                    top: BorderSide(color: Colors.black),
                                    left: BorderSide(color: Colors.black),
                                    right: BorderSide(color: Colors.black),
                                  )),
                              child: nextButton)
                ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
