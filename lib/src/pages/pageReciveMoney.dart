import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wallet_app/src/theme/light_color.dart';
import 'package:flutter_wallet_app/src/widgets/BackgroundWidget.dart';
import 'package:flutter_wallet_app/src/widgets/title_text.dart';

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
                                      'p23de2c34a34',
                                      style: TextStyle(fontSize: 18,color: Colors.grey, fontStyle: FontStyle.italic),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Stack(
                                      children: [
                                        Center(
                                          child: SvgPicture.asset(
                                            ResourceUtil.icon('ic_qrcode_image.svg'),
                                            width: 250,
                                            height: 250,
                                            color: Colors.black.withOpacity(0.8),
                                          ),
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
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://jshopping.in/images/detailed/591/ibboll-Fashion-Mens-Optical-Glasses-Frames-Classic-Square-Wrap-Frame-Luxury-Brand-Men-Clear-Eyeglasses-Frame.jpg"),
                                    fit: BoxFit.cover),
                                border: Border.all(color: Colors.blueAccent, width: 5),
                                borderRadius: BorderRadius.all(Radius.circular(50))),
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
