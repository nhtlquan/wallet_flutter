import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wallet_app/src/Helper/ApiService.dart';
import 'package:flutter_wallet_app/src/Helper/ChooseImageHelper.dart';
import 'package:flutter_wallet_app/src/Util/Util.dart';
import 'package:flutter_wallet_app/src/theme/light_color.dart';
import 'package:flutter_wallet_app/src/widgets/BackgroundWidget.dart';
import 'package:flutter_wallet_app/src/widgets/title_text.dart';

import '../ResourceUtil.dart';

class VerifyKYCPage extends StatefulWidget {
  @override
  _VerifyKYCPageState createState() => _VerifyKYCPageState();
}

class _VerifyKYCPageState extends State<VerifyKYCPage> {
  var enable2FA = true;

  @override
  Widget build(BuildContext context) {
    print(ApiService.userProfile.data.kyc1);
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
//                      Center(
//                        child: Container(
//                            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
//                            width: 200,
//                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                            decoration: BoxDecoration(
//                                color: LightColor.lightBlue1, borderRadius: BorderRadius.all(Radius.circular(8))),
//                            child: Center(
//                              child: Wrap(
//                                children: <Widget>[
//                                  TitleText(
//                                    text: "Update",
//                                    color: Colors.white,
//                                  ),
//                                ],
//                              ),
//                            )),
//                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _showChooseImageAvatar(String kycName)  {
    var choose = new ChooseImageHelper(context: this.context, isCrop: true);
    choose.title = "Choose your KYC image";
    choose.onShowLoading = () {};
    choose.onHideLoading = () {};
    choose.onChooseImage = (File file)  async{
      var response =await ApiService.uploadFile(file, kycName);
      if (response.statusCode == 200) {
        var data = json.decode(response.data);
        if(kycName == 'kyc1')
          ApiService.userProfile.data.kyc1 = data['kyc1'];
        else
          ApiService.userProfile.data.kyc2 = data['kyc2'];
        setState(() {

        });
      } else {
        Util.showToast('Upload fail');
      }

    };
    choose.show();
  }
}
