import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:PitWallet/src/widgets/BackgroundWidget.dart';
import 'package:PitWallet/src/widgets/title_text.dart';

import '../ResourceUtil.dart';

class BuyPitPage extends StatefulWidget {
  @override
  _BuyPitPageState createState() => _BuyPitPageState();
}

class _BuyPitPageState extends State<BuyPitPage> {
  Item selectedUser ;
  List<Item> users = <Item>[
    Item(
      'Bitcoin',
      SvgPicture.asset(
        ResourceUtil.icon('bitcoin.svg'),
        width: 32,
      ),
    ),
    Item(
      'Ethereum',
      SvgPicture.asset(
        ResourceUtil.icon('ethereum.svg'),
        width: 32,
      ),
    ),
    Item(
      'Tether',
      SvgPicture.asset(
        ResourceUtil.icon('tether.svg'),
        width: 32,
      ),
    ),
  ];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedUser = users[0];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
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
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          color: Colors.white,
                        ),
                        SizedBox(width: 20),
                        TitleText(
                          text: "Buy Pitnex",
                          color: Colors.white,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50, left: 20, right: 20),
                          child: Material(
                            color: Colors.white,
                            elevation: 10,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Center(
                                      child: TitleText(
                                        text: "Pay for get pitnex",
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Center(
                                      child: DropdownButton<Item>(
                                        elevation: 3,
                                        value: selectedUser,
                                        onChanged: (Item Value) {
                                          setState(() {
                                            selectedUser = Value;
                                          });
                                        },
                                        items: users.map((Item user) {
                                          return DropdownMenuItem<Item>(
                                            value: user,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                user.icon,
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  user.name,
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                                SizedBox(
                                                  width: 120,
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Center(
                                      child: SvgPicture.asset(
                                        ResourceUtil.icon('ic_qrcode_image.svg'),
                                        width: 250,
                                        height: 250,
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Center(
                                      child: Text(
                                        '0x906ab391c25a20c059c1fad',
                                        style: TextStyle(fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class Item {
  Item(this.name, this.icon);

  final String name;
  final Widget icon;
}
