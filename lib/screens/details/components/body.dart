import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planty_app/constants.dart';
import 'package:planty_app/screens/details/components/plant_photo.dart';

import 'icon_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height*.8, //big picture takes up 80% of screen height
            child: Row(
              children: <Widget>[
                Expanded( //basically a column will fill up the max amount of space up to the other child of the Row (container)
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60, left: 8),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                              icon: SvgPicture.asset("assets/icons/back_arrow.svg"),
                              onPressed: null
                          ),
                        ),
                        Spacer(),
                        IconCard(icon: "assets/icons/sun.svg"),
                        IconCard(icon: "assets/icons/icon_2.svg"),
                        IconCard(icon: "assets/icons/icon_3.svg"),
                        IconCard(icon: "assets/icons/icon_4.svg")
                      ],
                    ),
                  ),
                ),
                plantPhoto(size: size),

              ],
            ),
          ),
          Row(
            children: <Widget>[
              RichText(
                  text: TextSpan(
                      text: "Ju",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 50
                      )
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}
