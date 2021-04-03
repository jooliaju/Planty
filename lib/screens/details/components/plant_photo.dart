
import 'package:flutter/cupertino.dart';

import '../../../constants.dart';

class plantPhoto extends StatelessWidget {
  const plantPhoto({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height*.8,
      width: size.width*.75,
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(
              offset: Offset(0,10),
              blurRadius: 60,
              color: kPrimaryColour.withOpacity(.3)
          )],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(63),
            bottomLeft: Radius.circular(63),

          ),
          image: DecorationImage(
              alignment: Alignment.centerLeft,
              fit: BoxFit.cover,
              image: AssetImage("assets/images/img.png")
          )
      ),
    );
  }
}
