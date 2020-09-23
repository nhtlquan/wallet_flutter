import 'package:flutter/material.dart';
import 'package:PitWallet/src/Model/HistoryWallet.dart';
import 'package:PitWallet/src/Util/DateTimeUtil.dart';
import 'package:PitWallet/src/Util/Util.dart';
import 'package:PitWallet/src/theme/light_color.dart';
import 'package:PitWallet/src/widgets/title_text.dart';

class ItemTransationStake extends StatelessWidget {
  HistoryWa historyWa;
  WalletType walletType;

  ItemTransationStake(this.historyWa, this.walletType);

  @override
  Widget build(BuildContext context) {
    var checkBackground = historyWa.type == '0';
    var wallet = walletType == WalletType.s ?'S.PIT':'B.PIT';
    var mount =Util.doubleToString( Util.round(double.parse(historyWa.money), 2));
    return Container(
      color:  Colors.white,
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
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
//                RichText(
//                  text: new TextSpan(
//                    style: new TextStyle(
//                      fontSize: 16.0,
//                      color: Colors.black,
//                    ),
//                    children: <TextSpan>[
//                      new TextSpan(text: checkBackground ? 'Send to: ' : 'Received from: '),
//                      new TextSpan(
//                          text: 'p23de2c34a34',
//                          style: new TextStyle(fontWeight: FontWeight.bold, color: LightColor.black)),
//                    ],
//                  ),
//                ),
                Text(
                  historyWa.note,
                  style: TextStyle(color: Colors.black, fontSize: 14),
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
                      DateTimeUtil.getDateTimeStamp(int.parse(historyWa.cdate)),
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),

              ],
            ),
          ),
          TitleText(
            text: checkBackground ? '$mount $wallet' : '+$mount $wallet',
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 21,
          )
        ],
      ),
    );
  }
}
