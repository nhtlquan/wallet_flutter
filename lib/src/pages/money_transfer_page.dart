import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_wallet_app/src/ResourceUtil.dart';
import 'package:flutter_wallet_app/src/theme/light_color.dart';
import 'package:flutter_wallet_app/src/widgets/BackgroundWidget.dart';
import 'package:flutter_wallet_app/src/widgets/title_text.dart';

class MoneyTransferPage extends StatefulWidget {
  MoneyTransferPage({Key key}) : super(key: key);

  @override
  _MoneyTransferPageState createState() => _MoneyTransferPageState();
}

class _MoneyTransferPageState extends State<MoneyTransferPage> {

  Widget _transferButton() {
    return Column(
      children: [
        Row(
          children: [
            TitleText(
              text: "Fee:",
              color: Colors.white,
            ),
            Spacer(),
            TitleText(
              text: "1.00 PIT",
              color: Colors.white,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            TitleText(
              text: "Total:",
              color: Colors.white,
            ),
            Spacer(),
            TitleText(
              text: "2.00 PIT",
              color: Colors.white,
            ),
          ],
        ),
        Container(
            margin: EdgeInsets.only(bottom: 10, top: 20),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(color: LightColor.navyBlue2, borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Center(
              child: Wrap(
                children: <Widget>[
                  Transform.rotate(
                    angle: 70,
                    child: Icon(
                      Icons.swap_calls,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  TitleText(
                    text: "Continue",
                    color: Colors.white,
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _icon(IconData icon, bool isBackground) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                  color: isBackground ? LightColor.lightGrey : Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Icon(icon),
            ),
            !isBackground
                ? SizedBox()
                : Text(
                    "Change",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: LightColor.navyBlue2),
                  )
          ],
        ));
  }

  Widget _countButton(String text) {
    return Material(
        child: InkWell(
            onTap: () {
              print("Sfsf");
            },
            child: Container(
              alignment: Alignment.center,
              child: TitleText(
                text: text,
              ),
            )));
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
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          BackButton(
                            color: Colors.white,
                          ),
                          SizedBox(width: 20),
                          TitleText(
                            text: "Send Money",
                            color: Colors.white,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 55,
                            width: 60,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://static.comicvine.com/uploads/original/11133/111336417/6168632-gal_gadot.jpg"),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.all(Radius.circular(50))),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total balance',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                              ),
                              TitleText(
                                text: "10,000 PIT",
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TitleText(
                        text: "Recipient",
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: LightColor.navyBlue2, borderRadius: BorderRadius.all(Radius.circular(8))),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      size: 26,
                                      color: Colors.white,
                                    ),
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(10)),
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.search,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  height: 1.53,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Center(
                              child:   SvgPicture.asset(
                                ResourceUtil.icon('ic_qrcode.svg'),
                                width: 32,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TitleText(
                        text: "Amount",
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: LightColor.navyBlue2, borderRadius: BorderRadius.all(Radius.circular(8))),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.monetization_on,
                                      size: 26,
                                      color: Colors.white,
                                    ),
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(10)),
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.search,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  height: 1.53,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.compare_arrows,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: LightColor.navyBlue2, borderRadius: BorderRadius.all(Radius.circular(8))),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: Container(
                                      width: 21,
                                      child: Center(
                                        child: Text(
                                          'VNĐ',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(10)),
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.search,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  height: 1.53,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TitleText(
                        text: "Note",
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 150,
                        margin: EdgeInsets.only(bottom: 20),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            color: LightColor.navyBlue2, borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.all(10)),
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.search,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.53,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(),
                      ),
                      _transferButton()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
