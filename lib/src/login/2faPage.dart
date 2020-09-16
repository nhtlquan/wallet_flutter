import 'dart:convert';

import 'package:cipher2/cipher2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wallet_app/src/Helper/ApiService.dart';
import 'package:flutter_wallet_app/src/widgets/BackgroundWidget.dart';
import 'package:flutter_wallet_app/src/widgets/title_text.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';

import '../ResourceUtil.dart';

class TwoFactorAuthenticationPage extends StatefulWidget {
  @override
  _TwoFactorAuthenticationPageState createState() => _TwoFactorAuthenticationPageState();
}

class _TwoFactorAuthenticationPageState extends State<TwoFactorAuthenticationPage> {
  var enable2FA = true;
  var urlGoogleAuthen = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    googleAuthenUrl();
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
                        TitleText(
                          text: "Verify 2FA",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
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
                                      height: 40,
                                    ),
                                  ],
                                ),
                              ),
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
