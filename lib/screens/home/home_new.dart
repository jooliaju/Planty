import "package:flutter/material.dart";
import 'package:hexcolor/hexcolor.dart';
import 'package:planty_app/constants.dart';
import 'package:planty_app/models/cards_model.dart';
import 'package:planty_app/models/plant_model.dart';
import 'package:planty_app/models/user.dart';
import 'package:planty_app/screens/plants/plant_listnew.dart';
import 'package:planty_app/screens/user/update_user.dart';
import 'package:planty_app/screens/plants/plant_screen.dart';
import 'package:planty_app/services/auth.dart';
import 'package:planty_app/services/database.dart';
import 'package:provider/provider.dart';
import 'user_list.dart';

class HomeScreenNew extends StatefulWidget {
  @override
  _HomeScreenNewState createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);
    Size size = MediaQuery.of(context).size;

    return StreamProvider<List<Plant>>.value(
      value: DatabaseService(uid: user.uid).plants,
      child: Scaffold(
          backgroundColor: kBackground,
          body: Container(
            margin: EdgeInsets.only(left: 20),
            child: Column(
              children: [
                //Custom AppBar
                Stack(
                  children: <Widget>[

                    Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:20),
                          child: Column(
                              children: <Widget>[
                              Padding(
                              padding: const EdgeInsets.all(0),
                              child: Image.asset("assets/icons/side_bar.png", scale: 2.5,),
                            ),

                            ]
                          ),
                        ),
                        Stack(
                          alignment: Alignment.topRight,
                          children: <Widget>[
                            Container(
                              child: Image.asset("assets/images/profile_pic.png", scale:3.5),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(35),
                              child: Container(
                              height: 60,
                              width: 60,
                              child: GestureDetector(
                                onTap: (){
                                  print("you need to add a profile page");
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white ,
                                  child: Image.asset("assets/images/human.png", fit: BoxFit.contain),
                                ),
                              )

                          ),
                            ),]
                        ),


                      ],
                    ),
                  ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: 110),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(text: TextSpan(
                                text: "Hey ",
                                style: TextStyle(
                                    color: kDefaultText,
                                    fontSize: 26
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "Malakai",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      )
                                  )
                                ]

                            )),
                            SizedBox(
                              height: size.height*0.01,
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
                  ]
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Your Lovely Plants", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kGreyBlue)),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text("See All", style: TextStyle(color: kGreyBlue, fontSize: 16 )),
                    )
                  ],
                ),
                SizedBox(height: size.height*0.02,),
                PlantListNew(),

                SizedBox(height: size.height*0.02,),
                Text("Tasks Today", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kGreyBlue)),
                SizedBox(height: size.height*0.02,),

                ListView.builder(
                  scrollDirection: Axis.vertical,

                  itemCount: 2,
                  padding: EdgeInsets.only(right: 20),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 70,
                      margin: EdgeInsets.only(bottom: 20),
                      padding:
                      EdgeInsets.only(left: 20, top: 12, bottom: 12, right: 20),
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
                )

              ],
            ),
          )),
    );
  }


  ///add a stream for database collection 'plants'
  // Container plantListNew() {
  //   final plants = Provider.of<List<Plant>>(context) ?? [];
  //   return Container(
  //             height: 250,
  //             child: ListView.builder(
  //                 scrollDirection: Axis.horizontal,
  //                 padding: EdgeInsets.only( right: 16),
  //                 itemCount: plants.length,
  //                 itemBuilder: (context, index){
  //                   return Container(
  //                     width: 200,
  //                     margin: EdgeInsets.only(right:10),
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(28),
  //                       color: Colors.red,
  //                     ),
  //
  //                   );
  //                 }),
  //           );
  // }
}
