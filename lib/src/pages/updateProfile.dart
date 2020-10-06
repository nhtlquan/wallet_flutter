import 'dart:convert';

import 'package:PitWallet/src/Helper/ApiService.dart';
import 'package:PitWallet/src/Util/Util.dart';
import 'package:PitWallet/src/widgets/PageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:PitWallet/src/theme/light_color.dart';
import 'package:PitWallet/src/widgets/BackgroundWidget.dart';
import 'package:PitWallet/src/widgets/title_text.dart';
import 'package:rxdart/rxdart.dart';

import '../ResourceUtil.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {

  var fullNameController = new TextEditingController(text: ApiService.userProfile.data.fullname);
  var phoneController = new TextEditingController(text: ApiService.userProfile.data.phone);
  var identityController = new TextEditingController(text: ApiService.userProfile.data.cmt);
  var addressController = new TextEditingController(text: ApiService.userProfile.data.cmtPlace);
  var _isLoadingSubject = BehaviorSubject<bool>.seeded(false);

  Stream get isLoadingStream => _isLoadingSubject.stream;

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
                            text: "Update Profile",
                            color: Colors.white,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          itemProfile('Full name', '', Icons.person, fullNameController),
                          itemProfile('Phone', '', Icons.phone, phoneController),
                          itemProfile('Identity  ', '', Icons.assignment_ind, identityController),
                          itemProfile('Date Identity', '', Icons.date_range,null ),
                          itemProfile('Address Identity', '', Icons.location_on, addressController),
                        ],
                      ),
                      Center(
                        child: InkWell(
                          onTap: (){
                            updateProfile();
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
                                      text: "UPDATE",
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
              ),
            ],
          ),
        ));
  }

  Widget itemProfile(String title, String value, IconData iconData, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(
            text: title,
            color: Colors.white,
            fontSize: 16,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(color: LightColor.navyBlue2, borderRadius: BorderRadius.all(Radius.circular(8))),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.53,
                ),
                prefixIcon: Icon(
                  iconData,
                  size: 26,
                  color: Colors.white,
                ),
                isDense: true,
                contentPadding: EdgeInsets.all(10),
              ),
              textAlign: TextAlign.left,
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
    );
  }
  void updateProfile() async {
    var fullName = fullNameController.text.toString();
    if (fullName.isEmpty) {
      Util.showToast('Please input full name!');
      return;
    }
    var phone = phoneController.text.toString();
    if (phone.isEmpty) {
      Util.showToast('Please input phone!');
      return;
    }
    var identity = identityController.text.toString();
    if (identity.isEmpty) {
      Util.showToast('Please input identity!');
      return;
    }
    var placeIdentity = addressController.text.toString();
    if (placeIdentity.isEmpty) {
      Util.showToast('Please input place identity!');
      return;
    }
    onLoading(true);
    Map params = new Map<String, String>();
    params['username'] = ApiService.userProfile.data.username;
    params['fullname'] = fullName;
    params['phone'] = phone;
    params['cmt'] = identity;
    params['cmt_date'] = 'n/A';
    params['cmt_place'] = placeIdentity;
    print(params);
    var encryptString = await ResourceUtil.stringEncryption(params);
    final response = await ApiService.updateInfo(encryptString);
    onLoading(false);
    if (response.statusCode == 200) {
      var data = json.decode(response.data);
      if (data['status'] == 'no') {
        Util.showToast(data['mess']);
      } else {
        ApiService.userProfile.data.fullname = fullName;
        ApiService.userProfile.data.phone = phone;
        ApiService.userProfile.data.cmt = identity;
        ApiService.userProfile.data.cmtPlace = placeIdentity;
        Util.showToast('Update profile success!');
      }
    }
  }

  onLoading(bool isLoading) {
    _isLoadingSubject.sink.add(isLoading);
  }}
