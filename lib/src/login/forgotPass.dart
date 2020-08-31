import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wallet_app/src/theme/light_color.dart';
import 'package:flutter_wallet_app/src/widgets/BackgroundWidget.dart';
import 'package:flutter_wallet_app/src/widgets/title_text.dart';

import '../ResourceUtil.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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
                          text: "Forgot Password",
                          color: Colors.white,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleText(
                            text: "Email",
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: LightColor.navyBlue2, borderRadius: BorderRadius.all(Radius.circular(8))),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  height: 1.53,
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline,
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
                                  text: "RESET",
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
}
