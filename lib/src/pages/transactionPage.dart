import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wallet_app/src/theme/light_color.dart';
import 'package:flutter_wallet_app/src/widgets/title_text.dart';

import '../ResourceUtil.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          LightColor.navyBlue1.withOpacity(0.8),
                          LightColor.navyBlue2.withOpacity(0.8),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                ),
                SafeArea(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: LightColor.navyBlue1,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.all(2),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              itemTabbar('Pitnex', 0),
                              itemTabbar('Stake', 1),
                              itemTabbar('Business', 2),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: new TextSpan(
                            style: new TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                            children: <TextSpan>[
                              new TextSpan(text: 'Total balance: '),
                              new TextSpan(
                                  text: '10.000 PIT',
                                  style: new TextStyle(fontWeight: FontWeight.bold, color: LightColor.yellow)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                itemBuilder: (ct, index) {
                  return itemTransaction(index);
                },
                itemCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemTransaction(int index) {
    var checkBackground = index % 2 == 0;
    return Container(
      color: checkBackground ? Colors.white : Colors.grey.withOpacity(0.1),
      padding: EdgeInsets.only(bottom: 10, top: 10, right: 10, left: 10),
      child: Row(
        children: [
          Material(
            type: MaterialType.circle,
            elevation: 1,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: !checkBackground
                  ? Icon(
                      Icons.arrow_downward,
                      color: Colors.green,
                      size: 24,
                    )
                  : Icon(
                      Icons.arrow_upward,
                      color: Colors.red,
                      size: 24,
                    ),
            ),
          ),
//          SvgPicture.asset(
//            ResourceUtil.icon('download.svg'),
//            width: 35,
//            height: 35,
//            color: checkBackground ? Colors.green : Colors.red,
//          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: new TextSpan(
                    style: new TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      new TextSpan(text: checkBackground ? 'Send to: ' : 'Received from: '),
                      new TextSpan(
                          text: 'p23de2c34a34',
                          style: new TextStyle(fontWeight: FontWeight.bold, color: LightColor.black)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.grey,
                      size: 12,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '24/08 18:12',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  checkBackground ? 'Withdraw from stake pitnex' : 'Pitnex Capital',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                )
              ],
            ),
          ),
          TitleText(
            text: checkBackground ? '-50 PIT' : '+80 PIT',
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 21,
          )
        ],
      ),
    );
  }

  Widget itemTabbar(String title, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
        decoration: BoxDecoration(
            color: index == currentIndex ? Colors.white : Colors.transparent, borderRadius: BorderRadius.circular(8)),
        child: Text(
          title,
          style: TextStyle(
              color: index == currentIndex ? LightColor.navyBlue1 : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
    );
  }
}
