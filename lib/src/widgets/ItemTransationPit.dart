import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:PitWallet/src/Model/PitHistory.dart';
import 'package:PitWallet/src/Util/DateTimeUtil.dart';
import 'package:PitWallet/src/theme/light_color.dart';
import 'package:PitWallet/src/widgets/title_text.dart';
import 'package:flutter_svg/svg.dart';

import '../ResourceUtil.dart';

class ItemTransactionPit extends StatelessWidget {
  History historyWa;
  int index;

  ItemTransactionPit(this.historyWa, this.index);

  @override
  Widget build(BuildContext context) {
    var status = historyWa.type == Type.TRAN_SEND;
    return Container(
      color: index % 2 == 0 ? Colors.white : Colors.grey.withOpacity(0.1),
      padding: EdgeInsets.only(bottom: 10, top: 10, right: 10, left: 10),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
                ),
                child: SvgPicture.asset(
                  !status ? ResourceUtil.icon('ic_receive.svg') : ResourceUtil.icon('ic_send.svg'),
                  fit: BoxFit.fill,
                  width: 28,
                  height: 28,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      Icons.done,
                      size: 10,
                      color: Colors.white,
                    )),
              )
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: new TextSpan(
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            new TextSpan(text: status ? 'Send to ' : 'Received from '),
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
                        height: 3,
                      ),
                      Text(
                        'Success',
                        style: TextStyle(color: Colors.green, fontSize: 14),
                      )
                    ],
                  ),
                ),
                Container(
                  child: TitleText(
                    text: status ? '-' + historyWa.amount + ' PIT' : '+' + historyWa.amount + ' PIT',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
