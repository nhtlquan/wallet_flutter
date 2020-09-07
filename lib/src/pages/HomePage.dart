import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallet_app/src/pages/pageReciveMoney.dart';
import 'package:flutter_wallet_app/src/theme/light_color.dart';
import 'package:flutter_wallet_app/src/widgets/balance_card.dart';
import 'package:flutter_wallet_app/src/widgets/title_text.dart';
import 'package:google_fonts/google_fonts.dart';

import 'buyPitMoney.dart';

class HomePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomePage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _appBar(context),
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
                  child: _operationsWidget(context),
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
      ),
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

  Widget _appBar(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage:
          NetworkImage("https://static.comicvine.com/uploads/original/11133/111336417/6168632-gal_gadot.jpg"),
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

  Widget _operationsWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/transfer');
            },
            child: _icon(Icons.send, "Send", context)),
        InkWell(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => ReceiveMoneyPage()));
            },
            child: _icon(Icons.arrow_downward, "Receive", context)),
        InkWell(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => BuyPitPage()));
            },
            child: _icon(Icons.payment, "Payment", context)),
        InkWell(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => BuyPitPage()));
            },
            child: _icon(Icons.add_shopping_cart, "Buy PIT", context)),
      ],
    );
  }

  Widget _icon(IconData icon, String text, BuildContext context) {
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
}

