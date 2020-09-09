import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallet_app/src/Helper/ApiService.dart';
import 'package:flutter_wallet_app/src/Util/Util.dart';
import 'package:flutter_wallet_app/src/pages/buyPitMoney.dart';
import 'package:flutter_wallet_app/src/pages/pageReciveMoney.dart';
import 'package:flutter_wallet_app/src/pages/profilePage.dart';
import 'package:flutter_wallet_app/src/pages/transactionPage.dart';
import 'package:flutter_wallet_app/src/theme/light_color.dart';
import 'package:flutter_wallet_app/src/theme/theme.dart';
import 'package:flutter_wallet_app/src/widgets/balance_card.dart';
import 'package:flutter_wallet_app/src/widgets/bottom_navigation_bar.dart';
import 'package:flutter_wallet_app/src/widgets/title_text.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../ResourceUtil.dart';
import 'HomePage.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MainPage> {
  int _page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white, boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              duration: Duration(milliseconds: 300),
              tabBackgroundColor: LightColor.navyBlue1,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                  iconActiveColor: LightColor.yellow2,
                ),
                GButton(
                  icon: Icons.history,
                  text: 'History',
                  iconActiveColor: LightColor.yellow2,
                ),
                GButton(
                  icon: Icons.supervisor_account,
                  text: 'Team',
                  iconActiveColor: LightColor.yellow2,
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                  iconActiveColor: LightColor.yellow2,
                ),
              ],
              selectedIndex: _page,
              onTabChange: (index) {
                setState(() {
                  _page = index;
                });
              }),
        ),
      ),
      body: getBody(),
    );
  }

  getBody() {
    switch (_page) {
      case 0:
        return HomePage();
      case 1:
        return TransactionPage();
      case 2:
        return Container(
          child: Center(
              child: TitleText(
            text: 'Coming soon',
          )),
        );
      case 3:
        return ProfilePage();
    }
  }

}
