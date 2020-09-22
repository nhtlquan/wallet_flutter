import 'dart:convert';

import 'package:auro_avatar/auro_avatar.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ff_contact_avatar/ff_contact_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallet_app/src/Helper/ApiService.dart';
import 'package:flutter_wallet_app/src/Helper/Constant.dart';
import 'package:flutter_wallet_app/src/Model/HistoryHome.dart';
import 'package:flutter_wallet_app/src/Model/HistoryWallet.dart';
import 'package:flutter_wallet_app/src/Model/PitHistory.dart';
import 'package:flutter_wallet_app/src/Util/DateTimeUtil.dart';
import 'package:flutter_wallet_app/src/Util/Util.dart';
import 'package:flutter_wallet_app/src/pages/money_payment_page.dart';
import 'package:flutter_wallet_app/src/pages/pageReciveMoney.dart';
import 'package:flutter_wallet_app/src/pages/qrpaymentPage.dart';
import 'package:flutter_wallet_app/src/theme/light_color.dart';
import 'package:flutter_wallet_app/src/widgets/balance_card.dart';
import 'package:flutter_wallet_app/src/widgets/title_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:snaplist/snaplist_view.dart';

import '../ResourceUtil.dart';
import 'buyPitMoney.dart';
import 'money_transfer_page.dart';

class HomePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  double pitBalance = 0, stakeBalance = 0, businessBalance = 0;
  RefreshController refreshController = RefreshController(initialRefresh: false);
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
    getWallet(); // lấy thông tin ví
    getWalletBalance(WalletType.s); // lấy thông tin ví
    getWalletBalance(WalletType.b); // lấy thông tin ví
    getWallet(); // lấy thông tin ví
    getPitHistories();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SmartRefresher(
        header: MaterialClassicHeader(
          color: Constant.TEXTCOLOR_GREEN_AB,
        ),
        controller: refreshController,
        onRefresh: _onRefresh,
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
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: false,
                    onPageChanged: (int index, CarouselPageChangedReason reason) {
                      currentPage = index;
                      changeHistory();
                    },
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                  ),
                  items: [
                    BalanceCard(
                      balance: pitBalance.toString(),
                      name: 'PITNEX WALLET',
                      unit: 'PIT',
                    ),
                    BalanceCard(
                      balance: stakeBalance.toString(),
                      name: 'STAKE WALLET',
                      unit: 'S.PIT',
                    ),
                    BalanceCard(
                      balance: businessBalance.toString(),
                      name: 'BUSSINESS WALLET',
                      unit: 'B.PIT',
                    )
                  ],
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
            ),
          ),
        ),
      ),
    );
  }

  Widget _transectionList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: listHistory.length > 10 ? 10 : listHistory.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var item = listHistory[index];
          return _transection(item.title, item.dateTime, item.amount);
        });
  }

  changeHistory() {
    listHistory.clear();
    switch (currentPage) {
      case 0:
        for (var item in listHistoryPit) {
          var money = item.type == Type.TRAN_RECEIVED ? '+' + item.amount : '-' + item.amount;
          listHistory
              .add(new HistoryHome(item.memo, '$money PIT', DateTimeUtil.getDateTimeStamp(int.parse(item.cdate))));
        }
        break;
      case 1:
        for (var item in listHistoryStake) {
          var money = item.type == '1' ? '+' + item.money : item.money;
          listHistory
              .add(new HistoryHome(item.note, '$money S.PIT', DateTimeUtil.getDateTimeStamp(int.parse(item.cdate))));
        }
        break;
      case 2:
        for (var item in listHistoryBusiness) {
          var money = item.type == '1' ? '+' + item.money : item.money;
          listHistory
              .add(new HistoryHome(item.note, '$money B.PIT', DateTimeUtil.getDateTimeStamp(int.parse(item.cdate))));
        }
        break;
    }
    setState(() {});
  }

  Widget _appBar(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          child: InitialNameAvatar(
            ApiService.userProfile.data.fullname,
            circleAvatar: true,
            borderColor: Colors.white,
            borderSize: 2.0,
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: 10.0,
            textSize: 18.0,
          ),
        ),
        SizedBox(width: 5),
        TitleText(text: "Hello, "),
        Text(ApiService.userProfile.data.fullname,
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
              Navigator.push(context, CupertinoPageRoute(builder: (context) => MoneyTransferPage()));
            },
            child: _icon(Icons.send, "Send", context)),
        InkWell(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => ReceiveMoneyPage()));
            },
            child: _icon(Icons.arrow_downward, "Receive", context)),
        InkWell(
            onTap: () async {
              var result = await BarcodeScanner.scan();
              var qrCode = result.rawContent;
              if (qrCode.contains('|')) {
                var singCode = qrCode.substring(0, qrCode.indexOf('|'));
                var toWallet = qrCode.substring(qrCode.indexOf('|') + 1, qrCode.length);
                print(singCode);
                print(toWallet);
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => MoneyPaymentPage(
                              toWallet: toWallet,
                              singCode: singCode,
                            )));
              }
              print(result.rawContent);
            },
            child: _icon(Icons.payment, "Payment", context)),
        InkWell(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => QRPaymentPage()));
            },
            child: _icon(Icons.add_shopping_cart, "QR Payment", context)),
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

  Widget _transection(String text, String time, String amount) {
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
      title: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
      subtitle: Text(time),
      trailing: Container(
          height: 30,
          width: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: LightColor.lightGrey,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Text(amount,
              style: GoogleFonts.muli(fontSize: 12, fontWeight: FontWeight.bold, color: LightColor.navyBlue2))),
    );
  }

  void getPitBalance() async {
    Map params = new Map<String, String>();
    params['wallet'] = ApiService.PIT_WALLET;
    var encryptString = await ResourceUtil.stringEncryption(params);
    var dryp = await ResourceUtil.decryptedString(encryptString);
    print(dryp);
    final response = await ApiService.getPitBalance(encryptString);
    if (response.statusCode == 200) {
      var data = json.decode(response.data);
      pitBalance = double.parse(data['balance']);
      setState(() {});
    }
    refreshController.refreshCompleted();
  }

  void getWalletBalance(WalletType walletType) async {
    Map params = new Map<String, String>();
    params['wallet_type'] = walletType.toString().split('.').last;
    params['username'] = ApiService.userProfile.data.username;
    var encryptString = await ResourceUtil.stringEncryption(params);
    final response = await ApiService.getWalletBalance(encryptString);
    if (response.statusCode == 200) {
      var data = json.decode(response.data);
      if (walletType == WalletType.s)
        stakeBalance = double.parse(data['balance']);
      else
        businessBalance = double.parse(data['balance']);
      setState(() {});
    }
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
      changeHistory();
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
    }
  }

  void confirm2FA() async {
    Map params = new Map<String, String>();
    params['gsecret'] = ApiService.userProfile.data.gsecret;
    params['code2fa'] = '088164';
    var encryptString = await ResourceUtil.stringEncryption(params);
    final response = await ApiService.confirm2FA(encryptString);
    if (response.statusCode == 200) {}
  }

  void getWallet() async {
    // lấy thông tin ví
    Map params = new Map<String, String>();
    params['username'] = ApiService.userProfile.data.username;
    var encryptString = await ResourceUtil.stringEncryption(params);
    final response = await ApiService.getWallet(encryptString);
    if (response.statusCode == 200) {
      var data = json.decode(response.data);
      if (data['status'] == 'no') {
        Util.showToast(data['mess']);
      } else {
        ApiService.PIT_WALLET = data['wallet'];
        getPitBalance();
      }
    }
  }
}
