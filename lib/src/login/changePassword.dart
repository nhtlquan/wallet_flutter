import 'dart:convert';

import 'package:PitWallet/src/Helper/ApiService.dart';
import 'package:PitWallet/src/Util/ProjectUtil.dart';
import 'package:PitWallet/src/Util/Util.dart';
import 'package:PitWallet/src/widgets/PageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:PitWallet/src/theme/light_color.dart';
import 'package:PitWallet/src/widgets/BackgroundWidget.dart';
import 'package:PitWallet/src/widgets/title_text.dart';
import 'package:rxdart/rxdart.dart';

import '../ResourceUtil.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  var _isLoadingSubject = BehaviorSubject<bool>.seeded(false);

  Stream get isLoadingStream => _isLoadingSubject.stream;
  TextEditingController oldController = new TextEditingController();
  TextEditingController newController = new TextEditingController();
  TextEditingController confirmController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _isLoadingSubject.close();
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
                          text: "Change Password",
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
                            text: "Old Password",
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
                                  Icons.lock,
                                  size: 24,
                                  color: Colors.white,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(10),
                              ),
                              textAlign: TextAlign.left,
                              controller: oldController,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
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
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleText(
                            text: "New Password",
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
                                  Icons.lock,
                                  size: 24,
                                  color: Colors.white,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(10),
                              ),
                              controller: newController,
                              textAlign: TextAlign.left,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
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
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleText(
                            text: "Confirm Password",
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
                                  Icons.lock,
                                  size: 24,
                                  color: Colors.white,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(10),
                              ),
                              textAlign: TextAlign.left,
                              obscureText: true,
                              controller: confirmController,
                              keyboardType: TextInputType.visiblePassword,
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
                            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                            width: 200,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: LightColor.lightBlue1, borderRadius: BorderRadius.all(Radius.circular(8))),
                            child: Center(
                              child: Wrap(
                                children: <Widget>[
                                  TitleText(
                                    text: "CHANGE",
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void confirm2FA() async {
    var oldpass = oldController.text.toString();
    if (oldpass.isEmpty) {
      Util.showToast('Please input old Password!');
      return;
    }
    var newpass = newController.text.toString();
    if (newpass.isEmpty) {
      Util.showToast('Please input new Password!');
      return;
    }
    var confirmPass = confirmController.text.toString();
    if (newpass != confirmPass) {
      Util.showToast('Confirm password wrong!');
      return;
    }
    onLoading(true);
    Map params = new Map<String, String>();
    params['username'] = ApiService.userProfile.data.username;
    params['oldpass'] = oldpass;
    params['newpass'] = newpass;
    print(params);
    var encryptString = await ResourceUtil.stringEncryption(params);
    final response = await ApiService.changePassword(encryptString);
    onLoading(false);
    if (response.statusCode == 200) {
      var data = json.decode(response.data);
      if (data['status'] == 'no') {
        Util.showToast(data['mess']);
      } else {
        Util.showToast('Change password success!');
      }
    }
  }

  onLoading(bool isLoading) {
    _isLoadingSubject.sink.add(isLoading);
  }
}
