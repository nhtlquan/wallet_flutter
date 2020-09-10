import 'package:flutter/material.dart';
import 'package:flutter_wallet_app/src/Model/PitHistory.dart';
import 'package:flutter_wallet_app/src/Util/DateTimeUtil.dart';
import 'package:flutter_wallet_app/src/theme/light_color.dart';
import 'package:flutter_wallet_app/src/widgets/title_text.dart';

class ItemTransactionPit extends StatelessWidget {
  History historyWa;

  ItemTransactionPit(this.historyWa);

  @override
  Widget build(BuildContext context) {
    print(historyWa.type);
    var status = historyWa.type == Type.TRAN_SEND;
    return Container(
      color: Colors.white ,
      padding: EdgeInsets.only(bottom: 10, top: 10, right: 10, left: 10),
      child: Row(
        children: [
          Material(
            type: MaterialType.circle,
            elevation: 1,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: !status
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
                RichText(
                  text: new TextSpan(
                    style: new TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      new TextSpan(text: status ? 'Send to: ' : 'Received from: '),
                      new TextSpan(
                          text: status ? historyWa.toWallet : historyWa.fromWallet,
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
                      DateTimeUtil.getDateTimeStamp(int.parse(historyWa.cdate)),
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  historyWa.memo,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                )
              ],
            ),
          ),
          TitleText(
            text: status ? '-' + historyWa.amount + ' PIT' : '+' + historyWa.amount + ' PIT',
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 21,
          )
        ],
      ),
    );
  }
}
