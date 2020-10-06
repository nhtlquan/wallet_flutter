import 'dart:convert';

import 'package:PitWallet/src/pages/UpgradePacket.dart';
import 'package:auro_avatar/auro_avatar.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ff_contact_avatar/ff_contact_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:PitWallet/src/Helper/ApiService.dart';
import 'package:PitWallet/src/Helper/Constant.dart';
import 'package:PitWallet/src/Model/HistoryHome.dart';
import 'package:PitWallet/src/Model/HistoryWallet.dart';
import 'package:PitWallet/src/Model/PitHistory.dart';
import 'package:PitWallet/src/Util/DateTimeUtil.dart';
import 'package:PitWallet/src/Util/Util.dart';
import 'package:PitWallet/src/pages/money_payment_page.dart';
import 'package:PitWallet/src/pages/pageReciveMoney.dart';
import 'package:PitWallet/src/pages/qrpaymentPage.dart';
import 'package:PitWallet/src/theme/light_color.dart';
import 'package:PitWallet/src/widgets/balance_card.dart';
import 'package:PitWallet/src/widgets/title_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:snaplist/snaplist_view.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    aspectRatio: 2.5,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                  ),
                  items: [
                    BalanceCard(
                      balance: pitBalance.toString(),
                      name: 'PIT WALLET',
                      unit: 'PIT',
                    ),
                    BalanceCard(
                      balance: stakeBalance.toString(),
                      name: 'STAKE',
                      unit: 'S.PIT',
                    ),
                    BalanceCard(
                      balance: businessBalance.toString(),
                      name: 'Business',
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
    return Container(
        height: 250,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 6,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext _, int index) {
            switch (index) {
              case 0:
                return InkWell(
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => MoneyTransferPage()));
                    },
                    child: _icon(ResourceUtil.icon('ic_send.svg'), 'Send', context));
              case 1:
                return InkWell(
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => ReceiveMoneyPage()));
                    },
                    child: _icon(ResourceUtil.icon('ic_receive.svg'), 'Receive', context));
              case 2:
                return InkWell(
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
                    child: _icon(ResourceUtil.icon('ic_payment.svg'), 'Payment', context));
              case 3:
                return InkWell(
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => QRPaymentPage()));
                    },
                    child: _icon(ResourceUtil.icon('ic_qrcode_home.svg'), 'QR Payment', context));
              case 4:
                return InkWell(
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => UpgradePacket()));
                    },
                    child: _icon(ResourceUtil.icon('ic_packet.svg'), 'Packet', context));
              case 5:
                return InkWell(
                    onTap: () {
                      _launchURL();
                    },
                    child: _icon(ResourceUtil.icon('ic_fibo.svg'), 'FiboGroup', context));
            }
            return _icon(ResourceUtil.icon('name'), 'Send', context);
          },
        ));
  }

  _launchURL() async {
    const url = 'https://www.fibo-group.vn/?ref=IB_PitnexCapital';
    await launch(url);
  }

  Widget _icon(String icon, String text, BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 80,
          width: 80,
          child: Material(
            elevation: 3,
            type: MaterialType.canvas,
            color: Colors.white,
            shadowColor: Color(0xfff3f3f3),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Container(
              padding: EdgeInsets.all(15),
              child: SvgPicture.asset(
                icon,
                fit: BoxFit.fill,
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
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
    bool status = amount.contains('+');
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: SvgPicture.asset(
          status ? ResourceUtil.icon('ic_receive.svg') : ResourceUtil.icon('ic_send.svg'),
          fit: BoxFit.fill,
          width: 24,
          height: 24,
        ),
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
    print(params);
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
