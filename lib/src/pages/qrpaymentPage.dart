import 'dart:convert';

import 'package:auro_avatar/auro_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wallet_app/src/Helper/ApiService.dart';
import 'package:flutter_wallet_app/src/theme/light_color.dart';
import 'package:flutter_wallet_app/src/widgets/BackgroundWidget.dart';
import 'package:flutter_wallet_app/src/widgets/title_text.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../ResourceUtil.dart';

class QRPaymentPage extends StatefulWidget {
  @override
  _QRPaymentPageState createState() => _QRPaymentPageState();
}

class _QRPaymentPageState extends State<QRPaymentPage> {
  var qrPayment = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentQRUrl();
  }

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
                          text: "QR Payment",
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
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 70,
                                    ),
                                    TitleText(
                                      text: "Business:",
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      ApiService.userProfile.data.username,
                                      style: TextStyle(fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Stack(
                                      children: [
                                        QrImage(
                                          data: qrPayment,
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
//                                    Container(
//                                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
//                                      decoration: BoxDecoration(
//                                        gradient: new LinearGradient(
//                                            colors: [
//                                              LightColor.lightBlue2,
//                                              Colors.blue,
//                                            ],
//                                            begin: const FractionalOffset(0.0, 0.0),
//                                            end: const FractionalOffset(1.0, 0.0),
//                                            stops: [0.0, 1.0],
//                                            tileMode: TileMode.clamp),
//                                        borderRadius: BorderRadius.circular(50),
//                                      ),
//                                      child: Text(
//                                        'Copy Wallet',
//                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                                      ),
//                                    ),
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

  void paymentQRUrl() async {
    // lấy thông tin ví
    Map params = new Map<String, String>();
    params['username'] = ApiService.userProfile.data.username;
    var encryptString = await ResourceUtil.stringEncryption(params);
    final response = await ApiService.paymentQRUrl(encryptString);
    if (response.statusCode == 200) {
      var data = json.decode(response.data);
      if (data['status'] == 'yes') {
        setState(() {
          qrPayment = data['data'];
        });
      }
    }
  }
}
