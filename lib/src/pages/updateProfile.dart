import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wallet_app/src/theme/light_color.dart';
import 'package:flutter_wallet_app/src/widgets/BackgroundWidget.dart';
import 'package:flutter_wallet_app/src/widgets/title_text.dart';

import '../ResourceUtil.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              BackgroundWidget(),
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        BackButton(
                          color: Colors.white,
                        ),
                        TitleText(
                          text: "Update Profile",
                          color: Colors.white,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        itemProfile('Full name', '', Icons.person),
                        itemProfile('Phone', '', Icons.phone),
                        itemProfile('Identity  ', '', Icons.assignment_ind),
                        itemProfile('Date Identity', '', Icons.date_range),
                        itemProfile('Address Identity', '', Icons.location_on),
                      ],
                    ),
                    Center(
                      child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                          width: 200,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              color: LightColor.lightBlue1, borderRadius: BorderRadius.all(Radius.circular(8))),
                          child: Center(
                            child: Wrap(
                              children: <Widget>[
                                TitleText(
                                  text: "UPDATE",
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget itemProfile(String title, String value, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(
            text: title,
            color: Colors.white,
            fontSize: 16,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(color: LightColor.navyBlue2, borderRadius: BorderRadius.all(Radius.circular(8))),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.53,
                ),
                prefixIcon: Icon(
                  iconData,
                  size: 26,
                  color: Colors.white,
                ),
                isDense: true,
                contentPadding: EdgeInsets.all(10),
              ),
              textAlign: TextAlign.left,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.go,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.53,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
