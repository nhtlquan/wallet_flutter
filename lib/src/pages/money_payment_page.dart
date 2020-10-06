import 'dart:convert';

import 'package:auro_avatar/auro_avatar.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:PitWallet/src/Helper/ApiService.dart';
import 'package:PitWallet/src/ResourceUtil.dart';
import 'package:PitWallet/src/Util/Util.dart';
import 'package:PitWallet/src/theme/light_color.dart';
import 'package:PitWallet/src/widgets/BackgroundWidget.dart';
import 'package:PitWallet/src/widgets/PageWidget.dart';
import 'package:PitWallet/src/widgets/title_text.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class MoneyPaymentPage extends StatefulWidget {
  var singCode = '';
  var toWallet = '';

  MoneyPaymentPage({Key key,@required this.toWallet, @required this.singCode}) : super(key: key);

  @override
  _MoneyPaymentPageState createState() => _MoneyPaymentPageState();
}

class _MoneyPaymentPageState extends State<MoneyPaymentPage> {
  var pitBalance = 0.0;
  var amount = 0.0;
  final _rate = 23500;
  final _euroController = TextEditingController();
  final _noteController = TextEditingController();
  final recipientController = TextEditingController();
  final _usdController = TextEditingController();
  final _euroFocusNode = FocusNode();
  final _usdFocusNode = FocusNode();
  var _isLoadingSubject = BehaviorSubject<bool>.seeded(false);

  Stream get isLoadingStream => _isLoadingSubject.stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPitBalance();
    recipientController.value = TextEditingValue(text: widget.toWallet);
    _euroController.addListener(this.onEuroChange);
    _usdController.addListener(this.onUSDChange);
  }

  @override
  void dispose() {
    recipientController.dispose();
    _usdFocusNode.dispose();
    _euroFocusNode.dispose();
    _usdController.dispose();
    _euroController.dispose();
    super.dispose();
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
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
        streamLoading: isLoadingStream,
        onBackPress: () {
          Navigator.pop(context);
        },
//        backgroundColor: Theme.of(context).primaryColor,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              BackgroundWidget(),
              SafeArea(
                child: Column(
                  children: [
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
                          text: "Payment",
                          color: Colors.white,
                        )
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 65,
                                    height: 65,
                                    child: InitialNameAvatar(
                                      ApiService.userProfile.data.fullname,
                                      circleAvatar: true,
                                      borderColor: Colors.white,
                                      borderSize: 2.0,
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      padding: 10.0,
                                      textSize: 24.0,
                                    ),
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
                                        style:
                                            TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                                      ),
                                      TitleText(
                                        text: "$pitBalance PIT",
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
                                          color: LightColor.navyBlue2,
                                          borderRadius: BorderRadius.all(Radius.circular(8))),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            prefixIcon: Icon(
                                              Icons.person_outline,
                                              size: 26,
                                              color: Colors.white,
                                            ),
                                            suffixIcon: Icon(
                                              Icons.lock_outline,
                                              size: 24,
                                              color: Colors.white,
                                            ),
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(10)),
                                        textAlign: TextAlign.left,
                                        controller: recipientController,
                                        enabled: false,
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
                                          color: LightColor.navyBlue2,
                                          borderRadius: BorderRadius.all(Radius.circular(8))),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
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
                                        controller: _euroController,
                                        focusNode: _euroFocusNode,
                                        onChanged: (String text) {
                                          amount = double.parse(text);
                                        },
                                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                                        textInputAction: TextInputAction.newline,
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
                                          color: LightColor.navyBlue2,
                                          borderRadius: BorderRadius.all(Radius.circular(8))),
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
                                        controller: _usdController,
                                        focusNode: _usdFocusNode,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                                        textInputAction: TextInputAction.newline,
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
                                  maxLines: 5,
                                  controller: _noteController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.search,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    height: 1.53,
                                  ),
                                ),
                              ),
//                        Expanded(
//                          flex: 2,
//                          child: SizedBox(),
//                        ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    _transferButton()
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _transferButton() {
    var amount = _euroController.text;
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
//        Row(
//          children: [
//            TitleText(
//              text: "Fee:",
//              color: Colors.white,
//            ),
//            Spacer(),
//            TitleText(
//              text: "1.00 PIT",
//              color: Colors.white,
//            ),
//          ],
//        ),
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
                text: "$amount PIT",
                color: Colors.white,
              ),
            ],
          ),
          InkWell(
            onTap: () {
              sendPit();
            },
            child: Container(
                margin: EdgeInsets.only(bottom: 10, top: 20),
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration:
                    BoxDecoration(color: LightColor.navyBlue2, borderRadius: BorderRadius.all(Radius.circular(15))),
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
          ),
        ],
      ),
    );
  }

  onEuroChange() {
    if (_euroFocusNode.hasFocus) {
      final euro = double.tryParse(_euroController.text);

      if (euro != null) {
        final usd = euro * _rate;
        _usdController.value = TextEditingValue(text: usd.toStringAsFixed(2));
      }
    }
  }

  onUSDChange() {
    if (_usdFocusNode.hasFocus) {
      final usd = double.tryParse(_usdController.text);

      if (usd != null) {
        final euro = usd / _rate;
        _euroController.value = TextEditingValue(text: euro.toStringAsFixed(2));
      }
    }
  }

  void sendPit() async {
    var recipient = recipientController.text;
    var amount = _euroController.text;
    var note = _noteController.text;
    if (recipient.isEmpty) {
      Util.showToast('Recipient wrong');
      return;
    }
    if (amount.isEmpty || double.parse(amount) <= 0) {
      Util.showToast('Amount wrong');
      return;
    }
    Map params = new Map<String, String>();
    params['sign'] = widget.singCode;
    params['username'] = ApiService.userProfile.data.username;
    params['fwallet'] = ApiService.PIT_WALLET;
    params['twallet'] = recipient;
    params['amount'] = amount;
    params['note'] = note;
    onLoading(true);
    print(params);
    var encryptString = await ResourceUtil.stringEncryption(params);
    final response = await ApiService.sendPaymentQR(encryptString);
    onLoading(false);
    if (response.statusCode == 200) {
      Util.showToast('Transaction success to $recipient');
    } else {
      Util.showToast('Transaction fail');
    }
  }

  onLoading(bool isLoading) {
    _isLoadingSubject.sink.add(isLoading);
  }
}
