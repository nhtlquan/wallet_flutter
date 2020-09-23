import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:PitWallet/src/Helper/ApiService.dart';
import 'package:PitWallet/src/Helper/Constant.dart';
import 'package:PitWallet/src/Model/HistoryHome.dart';
import 'package:PitWallet/src/Model/HistoryWallet.dart';
import 'package:PitWallet/src/Model/PitHistory.dart';
import 'package:PitWallet/src/Util/DateTimeUtil.dart';
import 'package:PitWallet/src/Util/Util.dart';
import 'package:PitWallet/src/theme/light_color.dart';
import 'package:PitWallet/src/widgets/ItemTransationPit.dart';
import 'package:PitWallet/src/widgets/ItemTransationStake.dart';
import 'package:PitWallet/src/widgets/title_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../ResourceUtil.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  var currentIndex = 0;
  List<History> listHistoryPit = new List();
  List<HistoryWa> listHistoryStake = new List();
  List<HistoryWa> listHistoryBusiness = new List();
  RefreshController refreshController = RefreshController(initialRefresh: false);

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
                  height: 120,
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
//                        SizedBox(
//                          height: 10,
//                        ),
//                        RichText(
//                          text: new TextSpan(
//                            style: new TextStyle(
//                              fontSize: 18.0,
//                              color: Colors.white,
//                            ),
//                            children: <TextSpan>[
//                              new TextSpan(text: 'Total balance: '),
//                              new TextSpan(
//                                  text: '10.000 PIT',
//                                  style: new TextStyle(fontWeight: FontWeight.bold, color: LightColor.yellow)),
//                            ],
//                          ),
//                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SmartRefresher(
                header: MaterialClassicHeader(
                  color: Constant.TEXTCOLOR_GREEN_AB,
                ),
                onRefresh: _onRefresh,
                controller: refreshController,
                child: changeHistory(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget changeHistory() {
    print(currentIndex);
    switch (currentIndex) {
      case 0:
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: EdgeInsets.all(0),
          itemBuilder: (ct, index) {
            return ItemTransactionPit(listHistoryPit[index]);
          },
          itemCount: listHistoryPit.length,
        );
      case 1:
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: EdgeInsets.all(0),
          itemBuilder: (ct, index) {
            return ItemTransationStake(listHistoryStake[index], WalletType.s);
          },
          itemCount: listHistoryStake.length,
        );
      case 2:
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: EdgeInsets.all(0),
          itemBuilder: (ct, index) {
            return ItemTransationStake(listHistoryBusiness[index], WalletType.b);
          },
          itemCount: listHistoryBusiness.length,
        );
    }
  }

  Widget itemTabbar(String title, int index) {
    return InkWell(
      onTap: () {
        currentIndex = index;
        setState(() {});
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
      setState(() {});
    }
  }

  void getWalletHistories(WalletType walletType) async {
    Map params = new Map<String, String>();
    params['username'] = ApiService.userProfile.data.username;
    params['wallet_type'] = walletType.toString().split('.').last;
    print(walletType.toString().split('.').last);
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
      refreshController.refreshCompleted();
      setState(() {});
    }
  }
}
