import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallet_app/src/pages/pageReciveMoney.dart';
import 'package:flutter_wallet_app/src/theme/light_color.dart';
import 'package:flutter_wallet_app/src/theme/theme.dart';
import 'package:flutter_wallet_app/src/widgets/balance_card.dart';
import 'package:flutter_wallet_app/src/widgets/bottom_navigation_bar.dart';
import 'package:flutter_wallet_app/src/widgets/title_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  Widget _appBar() {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(
              "https://jshopping.in/images/detailed/591/ibboll-Fashion-Mens-Optical-Glasses-Frames-Classic-Square-Wrap-Frame-Luxury-Brand-Men-Clear-Eyeglasses-Frame.jpg"),
        ),
        SizedBox(width: 15),
        TitleText(text: "Hello,"),
        Text(' Janth,',
            style: GoogleFonts.muli(fontSize: 18, fontWeight: FontWeight.w600, color: LightColor.navyBlue2)),
        Expanded(
          child: SizedBox(),
        ),
        Icon(
          Icons.short_text,
          color: Theme.of(context).iconTheme.color,
        )
      ],
    );
  }

  Widget _operationsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/transfer');
            },
            child: _icon(Icons.send, "Send")),
        InkWell(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => ReceiveMoneyPage()));
            },
            child: _icon(Icons.arrow_downward, "Receive")),
        _icon(Icons.payment, "Payment"),
        _icon(Icons.add_shopping_cart, "Buy PIT"),
      ],
    );
  }

  Widget _icon(IconData icon, String text) {
    return Column(
      children: <Widget>[
        Container(
          height: 80,
          width: 80,
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: <BoxShadow>[BoxShadow(color: Color(0xfff3f3f3), offset: Offset(5, 5), blurRadius: 10)]),
          child: Material(
              elevation: 3,
              type: MaterialType.canvas,
              color: Colors.white,
              shadowColor: Color(0xfff3f3f3),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Icon(icon)),
        ),
        Text(text,
            style: GoogleFonts.muli(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xff76797e))),
      ],
    );
  }

  Widget _transectionList() {
    return Column(
      children: <Widget>[
        _transection("Flight Ticket", "23 Feb 2020"),
        _transection("Electricity Bill", "25 Feb 2020"),
        _transection("Flight Ticket", "03 Mar 2020"),
      ],
    );
  }

  Widget _transection(String text, String time) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: LightColor.navyBlue1,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Icon(Icons.hd, color: Colors.white),
      ),
      contentPadding: EdgeInsets.symmetric(),
      title: TitleText(
        text: text,
        fontSize: 14,
      ),
      subtitle: Text(time),
      trailing: Container(
          height: 30,
          width: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: LightColor.lightGrey,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Text('-20 PIT',
              style: GoogleFonts.muli(fontSize: 12, fontWeight: FontWeight.bold, color: LightColor.navyBlue2))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.white, boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))]),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                  gap: 8,
                  activeColor: Colors.white,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  duration: Duration(milliseconds: 800),
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
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: _appBar(),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TitleText(text: "My wallet"),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height * .27,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (index, ct) {
                    return BalanceCard();
                  },
                  itemCount: 3,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TitleText(
                  text: "Service",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: _operationsWidget(),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TitleText(
                  text: "Transactions",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: _transectionList(),
              ),
            ],
          )),
        )));
  }
}
