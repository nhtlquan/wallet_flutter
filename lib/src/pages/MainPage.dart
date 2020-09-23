import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:PitWallet/src/pages/profilePage.dart';
import 'package:PitWallet/src/pages/transactionPage.dart';
import 'package:PitWallet/src/theme/light_color.dart';
import 'package:PitWallet/src/widgets/title_text.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'HomePage.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MainPage> with SingleTickerProviderStateMixin {
  int _page = 0;
  PageController pageController;
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this, initialIndex: 0)
      ..addListener(() {
        setState(() {
          _page = tabController.index;
        });
      });
    pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {
          _page = pageController.page.floor();
        });
      });
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
                  tabController.animateTo(index, duration: Duration(microseconds: 300), curve: Curves.bounceIn);
                });
              }),
        ),
      ),
      body: TabBarView(controller: tabController, children: [
        HomePage(),
        TransactionPage(),
        Container(
          child: Center(
              child: TitleText(
            text: 'Coming soon',
          )),
        ),
        ProfilePage()
      ]),
    );
  }
}
