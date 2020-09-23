import 'package:auro_avatar/auro_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:PitWallet/src/Helper/ApiService.dart';
import 'package:PitWallet/src/theme/light_color.dart';
import 'package:PitWallet/src/widgets/BackgroundWidget.dart';
import 'package:PitWallet/src/widgets/title_text.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../ResourceUtil.dart';

class ReceiveMoneyPage extends StatefulWidget {
  @override
  _ReceiveMoneyPageState createState() => _ReceiveMoneyPageState();
}

class _ReceiveMoneyPageState extends State<ReceiveMoneyPage> {
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
                        SizedBox(width: 20),
                        TitleText(
                          text: "Receive Pitnex",
                          color: Colors.white,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50, left: 20, right: 20),
                          child: Material(
                            color: Colors.white,
                            elevation: 10,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 70,
                                    ),
                                    TitleText(
                                      text: "Wallet ID:",
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      ApiService.PIT_WALLET,
                                      style: TextStyle(fontSize: 18,color: Colors.grey, fontStyle: FontStyle.italic),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Stack(
                                      children: [
                                        QrImage(
                                          data: ApiService.PIT_WALLET,
                                          version: QrVersions.auto,
                                          size: 250.0,
                                        ),
//                                        Center(
//                                          child: Container(
//                                            margin: EdgeInsets.only(top: 90),
//                                            decoration: BoxDecoration(
//
//                                              borderRadius: BorderRadius.circular(0)
//                                            ),
//                                            padding: EdgeInsets.all(10),
//                                            child: Image.asset(
//                                              ResourceUtil.icon('ic_logo_app.png'),
//                                              height: 60
//                                              ,
//                                            ),
//                                          ),
//                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                      decoration: BoxDecoration(
                                        gradient: new LinearGradient(
                                            colors: [
                                              LightColor.lightBlue2,
                                              Colors.blue,
                                            ],
                                            begin: const FractionalOffset(0.0, 0.0),
                                            end: const FractionalOffset(1.0, 0.0),
                                            stops: [0.0, 1.0],
                                            tileMode: TileMode.clamp),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Text(
                                        'Copy Wallet',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            child: InitialNameAvatar(
                              ApiService.userProfile.data.fullname,
                              circleAvatar: true,
                              borderColor: Colors.white,
                              borderSize: 2.0,
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              padding: 10.0,
                              textSize: 26.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
