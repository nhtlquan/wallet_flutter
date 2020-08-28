import 'package:flutter/material.dart';
import 'package:flutter_wallet_app/src/ResourceUtil.dart';
import 'package:flutter_wallet_app/src/theme/light_color.dart';
import 'package:flutter_wallet_app/src/widgets/title_text.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}
//SELL Account 8710 CP, Phanmasta, Hexe, Alts Full Jin, Trade with MiddleMan service, Pm more info, Discord:
// NhtlQuan#0335
class _ProfilePageState extends State<ProfilePage> {
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
                            Center(
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://jshopping.in/images/detailed/591/ibboll-Fashion-Mens-Optical-Glasses-Frames-Classic-Square-Wrap-Frame-Luxury-Brand-Men-Clear-Eyeglasses-Frame.jpg"),
                                        fit: BoxFit.cover),
                                    border: Border.all(color: Colors.white, width: 5),
                                    borderRadius: BorderRadius.all(Radius.circular(50))),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TitleText(
                              text: "Nguyễn Văn Dũng",
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            TitleText(
                              text: "p23de2c34a34",
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
                                itemService(Icons.edit, 'Edit Profile', Colors.blueAccent),
                                itemService(Icons.lock, 'Password', Colors.red),
                                itemService(Icons.verified_user, '2FA', Colors.green),
                                itemService(Icons.person, 'KYC', LightColor.yellow),
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
                              itemDetail('Username', 'dungbinance@gmail.com', Icons.person, Colors.blue),
                              itemDetail('ParUser', 'info.lamgiau@gmail.com', Icons.link, Colors.yellow),
                              itemDetail('Join date', '20 thg 5, 2020', Icons.date_range, Colors.pink),
                              itemDetail('Active', 'Enable', Icons.compare, Colors.green),
                            ],
                          ),
                        ),
                      ),
                    )
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
