import 'dart:convert';

import 'package:PitWallet/src/Model/PacketList.dart';
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

import '../ResourceUtil.dart';

class UpgradePacket extends StatefulWidget {
  @override
  _UpgradePacketState createState() => _UpgradePacketState();
}

class _UpgradePacketState extends State<UpgradePacket> {
  var enable2FA = false;
  var urlGoogleAuthen = '';
  var _isLoadingSubject = BehaviorSubject<bool>.seeded(false);

  Stream get isLoadingStream => _isLoadingSubject.stream;
  TextEditingController code2FaController = new TextEditingController();
  var listOfDropdownMenuItems = new List<ItemPacket>();
  ItemPacket packet;

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
    getPacket();
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
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.white,
                          ),
                          TitleText(
                            text: "Upgrade packet",
                            color: Colors.white,
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Note: Upgrade requests will be approved within 2 business days',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleText(
                              text: "Select packet",
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton(
                                      value: packet,
                                      dropdownColor: Colors.white,
                                      iconEnabledColor: LightColor.lightBlue1,
                                      items: listOfDropdownMenuItems.map((location) {
                                        return DropdownMenuItem(
                                          child: new Text(location.name),
                                          value: location,
                                        );
                                      }).toList(),
                                      // [
                                      //   DropdownMenuItem(
                                      //     child: Text(
                                      //       "Standard (1000 PIT)",
                                      //     ),
                                      //     value: 1,
                                      //   ),
                                      //   DropdownMenuItem(
                                      //     child: Text(
                                      //       "Second Item",
                                      //     ),
                                      //     value: 2,
                                      //   ),
                                      //   DropdownMenuItem(
                                      //       child: Text(
                                      //         "Third Item",
                                      //       ),
                                      //       value: 3),
                                      //   DropdownMenuItem(
                                      //       child: Text(
                                      //         "Fourth Item",
                                      //       ),
                                      //       value: 4)
                                      // ],
                                      onChanged: (value) {
                                        setState(() {
                                          packet = value;
                                        });
                                      }),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TitleText(
                              text: "2FA Code",
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
                            confirmUpgrade();
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
                                      text: "Upgrade",
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void confirmUpgrade() async {
    var code2fa = code2FaController.text.toString();
    if (code2fa.isEmpty) {
      Util.showToast('Please input Google authenticator code!');
      return;
    }
    onLoading(true);
    Map params = new Map<String, String>();
    params['username'] = ApiService.userProfile.data.username;
    params['gsecret'] = ApiService.userProfile.data.gsecret;
    params['code_2fa'] = code2fa;
    params['packet'] = packet.value;
    print(params);
    var encryptString = await ResourceUtil.stringEncryption(params);
    final response = await ApiService.updatePacket(encryptString);
    onLoading(false);
    if (response.statusCode == 200) {
      var data = json.decode(response.data);
      if (data['status'] == 'no') {
        Util.showToast(data['mess']);
      } else {
        Util.showToast('Upgrade packet success');
      }
    }
  }

  onLoading(bool isLoading) {
    _isLoadingSubject.sink.add(isLoading);
  }

  void getPacket() async {
    Map params = new Map<String, String>();
    params['packet'] = 'packet';
    var encryptString = await ResourceUtil.stringEncryption(params);
    final response = await ApiService.packetList(encryptString);
    onLoading(false);
    if (response.statusCode == 200) {
      var data = json.decode(response.data);
      if (data['status'] == 'no') {
        Util.showToast(data['mess']);
      } else {
        PacketList packetList = PacketList.fromJson(json.decode(response.data));
        var dataPacket = packetList.data;
        dataPacket.forEach((key, value) {
          listOfDropdownMenuItems.add(new ItemPacket(value.name + ' (' + value.price + ' PIT)', value.price));
        });
        setState(() {});
      }
    }
  }
}

class ItemPacket {
  ItemPacket(this.name, this.value);

  final String name;
  final String value;
}
