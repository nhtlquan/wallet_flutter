import 'dart:convert';

import 'package:PitWallet/src/login/ui/Input2faPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:PitWallet/src/Helper/ApiService.dart';
import 'package:PitWallet/src/Helper/ChooseImageHelper.dart';
import 'package:PitWallet/src/Util/Util.dart';
import 'package:PitWallet/src/widgets/BackgroundWidget.dart';
import 'package:PitWallet/src/widgets/title_text.dart';

class InputKycPage extends StatefulWidget {
  InputKycPage({Key key}) : super(key: key);

  @override
  _InputKycPageState createState() => _InputKycPageState();
}

class _InputKycPageState extends State<InputKycPage> {
  var enable2FA = true;

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
                            onPressed: (){
                              Navigator.pop(context);
                            },
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
                          'Note: Please update KYC to create a wallet, KYC will be verify',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  TitleText(
                                    text: "Front face",
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                _showChooseImageAvatar('kyc1');
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      ApiService.BASE_URL + ApiService.userProfile.data.kyc1,
                                      height: 300,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 300,
                                      color: Colors.black.withOpacity(0.4),
                                      child: Center(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.cloud_upload,
                                              color: Colors.white,
                                              size: 60,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            TitleText(
                                              text: 'Choose File',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  TitleText(
                                    text: "Back face",
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(
                                children: [
                                  Image.network(
                                    ApiService.BASE_URL + ApiService.userProfile.data.kyc2,
                                    width: double.infinity,
                                    height: 300,
                                    fit: BoxFit.cover,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _showChooseImageAvatar('kyc2');
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 300,
                                      color: Colors.black.withOpacity(0.4),
                                      child: Center(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.cloud_upload,
                                              color: Colors.white,
                                              size: 60,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            TitleText(
                                              text: 'Choose File',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _showChooseImageAvatar(String kycName) {
    var choose = new ChooseImageHelper(context: this.context, isCrop: true);
    choose.title = "Choose your KYC image";
    choose.onShowLoading = () {};
    choose.onHideLoading = () {};
    choose.onChooseImage = (File file) async {
      var response = await ApiService.uploadFile(file, kycName);
      if (response.statusCode == 200) {
        var data = json.decode(response.data);
        if (kycName == 'kyc1')
          ApiService.userProfile.data.kyc1 = data['kyc1'];
        else
          ApiService.userProfile.data.kyc2 = data['kyc2'];
        setState(() {});
        if (ApiService.userProfile.data.kyc1.isNotEmpty && ApiService.userProfile.data.kyc2.isNotEmpty) {
//          Navigator.push(context, CupertinoPageRoute(builder: (context) => TwoFAPage()));
        Util.showToast('KYC will be verify, please wait!');
        }
      } else {
        Util.showToast('Upload fail');
      }
    };
    choose.show();
  }
}
