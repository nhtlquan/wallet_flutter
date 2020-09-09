import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wallet_app/src/Helper/ApiService.dart';
import 'package:flutter_wallet_app/src/Model/HistoryHome.dart';
import 'package:flutter_wallet_app/src/Model/HistoryWallet.dart';
import 'package:flutter_wallet_app/src/Model/PitHistory.dart';
import 'package:flutter_wallet_app/src/Util/DateTimeUtil.dart';
import 'package:flutter_wallet_app/src/Util/Util.dart';
import 'package:flutter_wallet_app/src/theme/light_color.dart';
import 'package:flutter_wallet_app/src/widgets/title_text.dart';

import '../ResourceUtil.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  var currentIndex = 0;
  List<History> listHistoryPit = new List();
  List<HistoryWa> listHistoryStake = new List();
  List<HistoryWa> listHistoryBusiness = new List();
  List<HistoryHome> listHistory = new List();
  var currentPage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void _onRefresh() {
    getData();
  }

  void getData() {
    getWalletHistories(WalletType.s);
    getWalletHistories(WalletType.b);
    getPitHistories();
  }

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
                itemCount: listHistory.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
  changeHistory() {
    listHistory.clear();
    switch (currentPage) {
      case 0:
        for (var item in listHistoryPit) {
          listHistory.add(new HistoryHome(
              item.memo, '-' + item.amount + ' PIT', DateTimeUtil.getDateTimeStamp(int.parse(item.cdate))));
        }
        break;
      case 1:
        for (var item in listHistoryStake) {
          listHistory.add(new HistoryHome(
              item.note, '-' + item.money + ' S.PIT', DateTimeUtil.getDateTimeStamp(int.parse(item.cdate))));
        }
        break;
      case 2:
        for (var item in listHistoryBusiness) {
          listHistory.add(new HistoryHome(
              item.note, '-' + item.money + ' B.PIT', DateTimeUtil.getDateTimeStamp(int.parse(item.cdate))));
        }
        break;
    }
    setState(() {});
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

  void getPitHistories() async {
    Map params = new Map<String, String>();
    params['username'] = ApiService.userProfile.data.username;
    var encryptString = await ResourceUtil.stringEncryption(params);
    final response = await ApiService.getPitHistories(encryptString);
    if (response.statusCode == 200) {
      var data = json.decode(response.data);
      PitHistory pitHistory = PitHistory.fromJson(data);
      listHistoryPit = pitHistory.data;
//      changeHistory();
    }
  }

  void getWalletHistories(WalletType walletType) async {
    Map params = new Map<String, String>();
    params['username'] = ApiService.userProfile.data.username;
    params['wallet_type'] = walletType
        .toString()
        .split('.')
        .last;
    print(walletType
        .toString()
        .split('.')
        .last);
    params['page'] = '1';
    params['wallet'] = ApiService.PIT_WALLET;
    var encryptString = await ResourceUtil.stringEncryption(params);
    final response = await ApiService.getWalletHistories(encryptString);
    if (response.statusCode == 200) {
      var data = json.decode(response.data);
      HistoryWallet pitHistory = HistoryWallet.fromJson(data);
      if (walletType == WalletType.s)
        listHistoryStake = pitHistory.data;
      else
        listHistoryBusiness = pitHistory.data;
    }
  }
