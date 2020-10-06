import 'package:flutter/material.dart';
import 'package:PitWallet/src/theme/light_color.dart';
import 'package:google_fonts/google_fonts.dart';

class BalanceCard extends StatelessWidget {
  String name;
  String balance;
  String unit;

  BalanceCard({Key key, this.name, this.balance, this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: Container(
            color: LightColor.navyBlue1,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: LightColor.lightNavyBlue),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          balance + ' ' + unit,
                          style: GoogleFonts.muli(
                              textStyle: Theme.of(context).textTheme.display1,
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              color: LightColor.yellow2),
                        ),
                      ],
                    ),
                    Text(
                      ' Your balance',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: 85,
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            border: Border.all(color: Colors.white, width: 1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text("Top up", style: TextStyle(color: Colors.white)),
                          ],
                        ))
                  ],
                ),
                Positioned(
                  left: -170,
                  top: -190,
                  child: CircleAvatar(
                    radius: 130,
                    backgroundColor: LightColor.lightBlue2,
                  ),
                ),
                Positioned(
                  left: -180,
                  top: -210,
                  child: CircleAvatar(
                    radius: 130,
                    backgroundColor: LightColor.lightBlue1,
                  ),
                ),
                Positioned(
                  right: -190,
                  bottom: -190,
                  child: CircleAvatar(
                    radius: 130,
                    backgroundColor: Colors.pink,
                  ),
                ),
                Positioned(
                  right: -180,
                  bottom: -210,
                  child: CircleAvatar(
                    radius: 130,
                    backgroundColor:Colors.deepPurple,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
