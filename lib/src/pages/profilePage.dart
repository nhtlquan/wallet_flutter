import 'package:PitWallet/src/login/ui/login_page.dart';
import 'package:auro_avatar/auro_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:PitWallet/src/Helper/ApiService.dart';
import 'package:PitWallet/src/ResourceUtil.dart';
import 'package:PitWallet/src/Util/DateTimeUtil.dart';
import 'package:PitWallet/src/login/2faPage.dart';
import 'package:PitWallet/src/login/changePassword.dart';
import 'package:PitWallet/src/login/kycPage.dart';
import 'package:PitWallet/src/pages/updateProfile.dart';
import 'package:PitWallet/src/theme/light_color.dart';
import 'package:PitWallet/src/widgets/title_text.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

//SELL Account 8710 CP, Phanmasta, Hexe, Alts Full Jin, Trade with MiddleMan service, Pm more info, Discord:
// NhtlQuan#0335
class _ProfilePageState extends State<ProfilePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white70,
      child: Container(
        color: Colors.white24,
        child: Stack(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        LightColor.navyBlue1,
                        LightColor.navyBlue2,
//                      ResourceUtil.hexToColor('66c0fe'),
//                      ResourceUtil.hexToColor('6883f8'),
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: TitleText(
                        text: "Profile",
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 50),
                          child: Material(
                            color: Colors.white,
                            elevation: 3,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 160,
                              width: double.infinity,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
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
                                textSize: 31.0,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TitleText(
                              text: ApiService.userProfile.data.fullname,
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            TitleText(
                              text: ApiService.PIT_WALLET,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                              height: 1,
                              color: Colors.grey.withOpacity(0.2),
                              width: double.infinity,
                            ),
                            Container(
                              height: 50,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: GridView.count(
                                  childAspectRatio: 1 / 1,
                                  mainAxisSpacing: 0.5,
                                  crossAxisSpacing: 0.5,
                                  padding: EdgeInsets.all(0.0),
                                  crossAxisCount: 4,
                                  children: <Widget>[
                                    itemInfo('My Packet', '10,000', ' P'),
                                    itemInfo('Stake', '3,741.9', ' S.P'),
                                    itemInfo('Business', '1,596', ' B.P'),
                                    itemInfo('My rate', '53.38', ' %'),
                                  ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Material(
                        color: Colors.white,
                        elevation: 3,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 100,
                          child: GridView.count(
                              childAspectRatio: 1 / 1,
                              mainAxisSpacing: 0.5,
                              crossAxisSpacing: 0.5,
                              padding: EdgeInsets.all(0.0),
                              crossAxisCount: 4,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context, CupertinoPageRoute(builder: (context) => UpdateProfilePage()));
                                  },
                                  child: itemService(Icons.edit, 'Edit Profile', Colors.blueAccent),
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context, CupertinoPageRoute(builder: (context) => ChangePasswordPage()));
                                    },
                                    child: itemService(Icons.lock, 'Password', Colors.red)),
                                InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          CupertinoPageRoute(builder: (context) => TwoFactorAuthenticationPage()));
                                    },
                                    child: itemService(Icons.verified_user, '2FA', Colors.green)),
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context, CupertinoPageRoute(builder: (context) => VerifyKYCPage()));
                                    },
                                    child: itemService(Icons.person, 'KYC', LightColor.yellow)),
                              ]),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              itemDetail('Username', ApiService.userProfile.data.username, Icons.person, Colors.blue),
                              itemDetail(
                                  'ParUser', ApiService.userProfile.data.parUser ?? '', Icons.link, Colors.yellow),
                              itemDetail(
                                  'Join date',
                                  DateTimeUtil.getDateTimeStamp(int.parse(ApiService.userProfile.data.cdate ?? '0')),
                                  Icons.date_range,
                                  Colors.pink),
                              itemDetail('Active', ApiService.userProfile.data.isactive == '1' ? "Enable" : 'Disable',
                                  Icons.compare, Colors.green),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: InkWell(
                        onTap: (){
                          ApiService.userProfile = null;
                          Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => LoginPage()));
                        },
                        child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            decoration: BoxDecoration(
                                color: LightColor.navyBlue1, borderRadius: BorderRadius.all(Radius.circular(8))),
                            child: Center(
                              child: Wrap(
                                children: <Widget>[
                                  TitleText(
                                    text: "Logout",
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
            )
          ],
        ),
      ),
    );
  }

  Widget itemService(IconData icon, String title, Color color) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: LightColor.navyBlue2, borderRadius: BorderRadius.circular(15)),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TitleText(
            text: title,
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget itemDetail(String title, String value, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(
            icon,
            size: 26,
            color: LightColor.lightNavyBlue,
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                text: title,
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 5,
              ),
              TitleText(
                text: value,
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget itemInfo(String title, String value, unit) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TitleText(
                    text: value,
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  TitleText(
                    text: unit,
                    color: Colors.black87,
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
          TitleText(
            text: title,
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
