import 'package:cipher2/cipher2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();test();

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
                                      child: SvgPicture.asset(
                                        ResourceUtil.icon('ic_qrcode_image.svg'),
                                        width: 250,
                                        height: 250,
                                        color: Colors.black.withOpacity(0.8),
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

  String plainText = 'Quan Dung';
  String key = '1245714587458745'; //combination of 16 character
  String iv = 'e16ce913a20dadb8';

  test() async {
    String encryptedString = await Cipher2.encryptAesCbc128Padding7(plainText, key, iv);
    print(encryptedString);
    decrypt('il8fTxDi4sg14u036UGThw==');
  }

  decrypt(String encryptedString) async {
    var decryptedString = await Cipher2.decryptAesCbc128Padding7(encryptedString, key, iv);
    print(decryptedString);
  }
}

class Item {
  Item(this.name, this.icon);

  final String name;
  final Widget icon;
}
