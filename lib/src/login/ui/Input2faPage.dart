import 'dart:convert';

import 'package:PitWallet/src/Util/Util.dart';
import 'package:PitWallet/src/login/ui/createWallet.dart';
import 'package:PitWallet/src/pages/MainPage.dart';
import 'package:PitWallet/src/theme/light_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:PitWallet/src/Helper/ApiService.dart';
import 'package:PitWallet/src/widgets/BackgroundWidget.dart';
import 'package:PitWallet/src/widgets/title_text.dart';
import 'package:rxdart/rxdart.dart';

import '../../ResourceUtil.dart';

class TwoFAPage extends StatefulWidget {
  @override
  _TwoFAPageState createState() => _TwoFAPageState();
}

class _TwoFAPageState extends State<TwoFAPage> {
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
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
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
                            color: Colors.white,
                          ),
                          TitleText(
                            text: "Verify KYC",
                            color: Colors.white,
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Note: Enable 2FA to create a wallet',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                            child: Material(
                              color: Colors.white,
                              elevation: 10,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            TitleText(
                                              text: "2FA",
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            Switch(
                                              value: enable2FA,
                                              onChanged: (bool value) {
                                                if (value) googleAuthenUrl();
                                                setState(() {
                                                  enable2FA = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    if (enable2FA)
                                      Center(
                                        child: Image.network(
                                          urlGoogleAuthen,
                                          height: 250,
                                          width: 250,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Center(
                                      child: Text(
                                        '2FA QRCode',
                                        style: TextStyle(fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (enable2FA)
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
                      if (enable2FA)
                      Center(
                        child: InkWell(
                          onTap: () {
                            createWallet();
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
                                      text: "CREATE WALLET",
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
  void createWallet() async {
    var code2fa= code2FaController.text.toString();
    if(code2fa.isEmpty){
      Util.showToast('Please input Google authenticator code!');
      return;
    }
    onLoading(true);
    Map params = new Map<String, String>();
    params['username'] = ApiService.userProfile.data.username;
    params['gsecret'] = ApiService.userProfile.data.gsecret;
    params['code_2fa'] = code2fa;
    var encryptString = await ResourceUtil.stringEncryption(params);

    final response = await ApiService.createWallet(encryptString);
    onLoading(false);
    if (response.statusCode == 200) {
      var data = json.decode(response.data);
      if (data['status'] == 'no') {
        Util.showToast(data['mess']);
      } else {
        Util.showToast('Create success');
        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => MainPage()));
      }
    }
  }

  onLoading(bool isLoading) {
    _isLoadingSubject.sink.add(isLoading);
  }

  void googleAuthenUrl() async {
    Map params = new Map<String, String>();
    params['username'] = ApiService.userProfile.data.username;
    params['gsecret'] = ApiService.userProfile.data.gsecret;
    var encryptString = await ResourceUtil.stringEncryption(params);
    var dryp = await ResourceUtil.decryptedString(encryptString);
    print(dryp);
    final response = await ApiService.googleAuthenUrl(encryptString);
    if (response.statusCode == 200) {
      var data = json.decode(response.data);
      setState(() {
        urlGoogleAuthen = data['data'];
      });
    }
  }
}

class Item {
  Item(this.name, this.icon);

  final String name;
  final Widget icon;
}
