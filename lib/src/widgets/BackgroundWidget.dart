import 'package:flutter/material.dart';
import 'package:PitWallet/src/theme/light_color.dart';
import 'package:google_fonts/google_fonts.dart';

class BackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container( width: MediaQuery.of(context).size.width-60,
      height: MediaQuery.of(context).size.height * .27,
      color: LightColor.navyBlue1,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            left: -170,
            top: -170,
            child: CircleAvatar(
              radius: 130,
              backgroundColor: LightColor.lightBlue2,
            ),
          ),
          Positioned(
            left: -160,
            top: -190,
            child: CircleAvatar(
              radius: 130,
              backgroundColor: LightColor.lightBlue1,
            ),
          ),
          Positioned(
            right: -170,
            bottom: -170,
            child: CircleAvatar(
              radius: 130,
              backgroundColor: LightColor.yellow2,
            ),
          ),
          Positioned(
            right: -160,
            bottom: -190,
            child: CircleAvatar(
              radius: 130,
              backgroundColor: LightColor.yellow,
            ),
          )
        ],
      ),
    );
  }
}
