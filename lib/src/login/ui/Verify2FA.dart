import 'dart:convert';

import 'package:PitWallet/src/Util/Util.dart';
import 'package:PitWallet/src/login/ui/createWallet.dart';
import 'package:PitWallet/src/pages/MainPage.dart';
import 'package:PitWallet/src/theme/light_color.dart';
import 'package:PitWallet/src/widgets/PageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:PitWallet/src/Helper/ApiService.dart';
import 'package:PitWallet/src/widgets/BackgroundWidget.dart';
import 'package:PitWallet/src/widgets/title_text.dart';
import 'package:rxdart/rxdart.dart';

import '../../ResourceUtil.dart';

class Verify2FAPage extends StatefulWidget {
  @override
  _Verify2FAPageState createState() => _Verify2FAPageState();
}

class _Verify2FAPageState extends State<Verify2FAPage> {
  var enable2FA = false;
  var urlGoogleAuthen = '';
  var _isLoadingSubject = BehaviorSubject<bool>.seeded(false);

  Stream get isLoadingStream => _isLoadingSubject.stream;
  TextEditingController code2FaController = new TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _isLoadingSubject.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      streamLoading: isLoadingStream,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              BackgroundWidget(),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          BackButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            color: Colors.white,
                          ),
                          TitleText(
                            text: "Verify 2FA",
                            color: Colors.white,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleText(
                              text: "Google authenticator code",
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
                                controller: code2FaController,
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
                        child: InkWell(
                          onTap: () {
                            confirm2FA();
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 20, right: 20, top: 0),
                              width: 200,
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                  color: LightColor.lightBlue1, borderRadius: BorderRadius.all(Radius.circular(8))),
                              child: Center(
                                child: Wrap(
                                  children: <Widget>[
                                    TitleText(
                                      text: "VERIFY",
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
  void confirm2FA() async {
    var code2fa= code2FaController.text.toString();
    if(code2fa.isEmpty){
      Util.showToast('Please input Google authenticator code!');
      return;
    }
    onLoading(true);
    Map params = new Map<String, String>();
    params['gsecret'] = ApiService.userProfile.data.gsecret;
    params['code2fa'] = code2fa;
    var encryptString = await ResourceUtil.stringEncryption(params);
    final response = await ApiService.confirm2FA(encryptString);
    onLoading(false);
    if (response.statusCode == 200) {
      var data = json.decode(response.data);
      if (data['status'] == 'no') {
        Util.showToast(data['mess']);
      } else {
        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => MainPage()));
      }
    }
  }

  onLoading(bool isLoading) {
    _isLoadingSubject.sink.add(isLoading);
  }

}

class Item {
  Item(this.name, this.icon);

  final String name;
  final Widget icon;
}
