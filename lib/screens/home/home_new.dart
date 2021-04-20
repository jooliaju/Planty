import "package:flutter/material.dart";
import 'package:planty_app/screens/all_plants/all_plants.dart';
import 'package:planty_app/screens/idCam/idCam_screen.dart';
import 'package:planty_app/shared/constants.dart';
import 'package:planty_app/models/plant_model.dart';
import 'package:planty_app/models/user.dart';
import 'package:planty_app/screens/home/plant_listnew.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:planty_app/services/auth.dart';
import 'package:planty_app/services/database.dart';
import 'package:provider/provider.dart';

class HomeScreenNew extends StatefulWidget {
  @override
  _HomeScreenNewState createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);
    Size size = MediaQuery.of(context).size;

    return StreamProvider<List<Plant>>.value(
      value: DatabaseService(uid: user.uid).plants,
      child: Scaffold(
          key: _scaffoldKey,


          //Side Drawer
          drawer:  buildDrawer(context),

          backgroundColor: kBackground,
          body: Container(
            child: Column(
              children: [
                //Custom AppBar
                Stack(children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: kDefaultPadding),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: kDefaultPadding),
                          child: Column(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: GestureDetector(
                                onTap: () {
                                  _scaffoldKey.currentState.openDrawer();
                                },
                                child: Image.asset(
                                  "assets/icons/side_bar.png",
                                  scale: 3,
                                ),
                              ),
                            ),
                          ]),
                        ),
                        Stack(alignment: Alignment.topRight, children: <Widget>[
                          Container(
                            child: Image.asset("assets/images/profile_pic.png",
                                scale: 3.5),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(40),
                            child: Container(
                                height: 60,
                                width: 60,
                                child: GestureDetector(
                                  onTap: () {
                                    print("you need to add a profile page");

                                    print("tappedssss");
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Image.asset(
                                        "assets/images/human.png",
                                        fit: BoxFit.contain),
                                  ),
                                )),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: kDefaultPadding),
                    child: Padding(
                      padding: EdgeInsets.only(top: 130),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: "Hey ",
                                  style: TextStyle(
                                      color: kDefaultText, fontSize: 26),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: "Malakai",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ])),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text(
                            "Let’s keep your plants healthy!",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
                SizedBox(
                  height: size.height * 0.02,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Your Lovely Plants",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kGreyBlue)),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllPlants()),
                            );
                          },
                          child: Text("See All",
                              style: TextStyle(color: kGreyBlue, fontSize: 16)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                PlantListNew(),

                SizedBox(
                  height: size.height * 0.02,
                ),
                FlatButton(
                  onPressed: () {
                    _auth.signOut();
                  },
                  child: Text("sign out temp"),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: kDefaultPadding),
                    child: Text("Tasks Today",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kGreyBlue)),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),

                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 5,
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 70,
                        margin: EdgeInsets.only(bottom: kDefaultPadding),
                        padding: EdgeInsets.only(
                            left: kDefaultPadding,
                            top: 12,
                            bottom: 12,
                            right: kDefaultPadding),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 10,
                              spreadRadius: 5,
                              offset: Offset(5, 5),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
          child:  ListView(
            padding: EdgeInsets.zero,
            children:  <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Fill this in',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: Text('Find Plant Id'),
                onTap:(){
                  Navigator.pop(context); //closes drawer after we navigate to new page

                   Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => idCamScreen(
                      
                    )),
              );
                                 
                },
              ),
              ListTile(
                title: Text('Profile'),
                onTap: (){},

              ),
              ListTile(
                title: Text('Settings'),
                onTap: (){},

              ),
            ],
          ),
        );
  }
}
