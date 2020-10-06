import 'dart:convert';

import 'package:PitWallet/src/Helper/Constant.dart';
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
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:rxdart/rxdart.dart';

import '../ButtonWidget.dart';

class MoneyTransferPage extends StatefulWidget {
  MoneyTransferPage({Key key}) : super(key: key);

  @override
  _MoneyTransferPageState createState() => _MoneyTransferPageState();
}

class _MoneyTransferPageState extends State<MoneyTransferPage> {
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
  var _otpController = new TextEditingController();
  var otp = '';
  PinCodeTextField pinCodeTextField;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPitBalance();
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
    pinCodeTextField = new PinCodeTextField(
      autofocus: false,
      hideCharacter: false,
      highlight: true,
      highlightColor: Constant.TEXTCOLOR_ORANGE,
      defaultBorderColor: Colors.grey,
      pinBoxBorderWidth: 1,
      hasTextBorderColor: Constant.TEXTCOLOR_BLUE_2D,
      maxLength: 6,
      hasError: false,
      controller: _otpController,
//      controller: controller,
      onTextChanged: (text) {},
      onDone: (text) {
        otp = text;
      },
      pinBoxHeight: 45,
      pinBoxWidth: 40,
      pinBoxRadius: 8,
      wrapAlignment: WrapAlignment.start,
      pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
      pinTextStyle: TextStyle(fontWeight: FontWeight.bold, color: ResourceUtil.hexToColor("#273879"), fontSize: 21.0),
      pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
      pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
    );
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
                          text: "Send Money",
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
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(10)),
                                        textAlign: TextAlign.left,
                                        controller: recipientController,
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
                                  InkWell(
                                    onTap: () async {
                                      var result = await BarcodeScanner.scan();
                                      recipientController.value = TextEditingValue(text: result.rawContent);
                                      print(result.rawContent);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          ResourceUtil.icon('ic_qrcode.svg'),
                                          width: 32,
                                        ),
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
              showPopupOTP();
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

  void showPopupOTP() {
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
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (popContext) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Material(
            type: MaterialType.transparency,
            child: Stack(
              children: <Widget>[
                Container(
                  width: 330,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Verify 2FA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Constant.TEXTCOLOR_BLACK_2B,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Please input 2FA from app Authenticator',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Constant.TEXTCOLOR_BLACK_2B,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      pinCodeTextField,
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ButtonWidget(
                        title: 'Xác thực',
                        onTap: () {
                          Navigator.pop(context);
                          confirm2FA();
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void confirm2FA() async {

    if (otp.isEmpty || otp.length < 6) {
      Util.showToast('Please input Google authenticator code!');
      return;
    }
    onLoading(true);
    Map params = new Map<String, String>();
    params['gsecret'] = ApiService.userProfile.data.gsecret;
    params['code2fa'] = otp;
    var encryptString = await ResourceUtil.stringEncryption(params);
    final response = await ApiService.confirm2FA(encryptString);
    onLoading(false);
    if (response.statusCode == 200) {
      var data = json.decode(response.data);
      if (data['status'] == 'no') {
        Util.showToast('2FA wrong');
      } else {
        FocusScope.of(context).unfocus();
        sendPit();
      }
    }
  }

  void sendPit() async {
    var recipient = recipientController.text;
    var amount = _euroController.text;
    var note = _noteController.text;

    Map params = new Map<String, String>();
    params['username'] = ApiService.userProfile.data.username;
    params['fwallet'] = ApiService.PIT_WALLET;
    params['twallet'] = recipient;
    params['amount'] = amount;
    params['note'] = note;
    onLoading(true);
    print(params);
    var encryptString = await ResourceUtil.stringEncryption(params);
    final response = await ApiService.sendPayment(encryptString);
    onLoading(false);
    var data = json.decode(response.data);
    if (response.statusCode == 200 && !(data['status'] == 'no')) {
      Util.showToast('Transaction success to $recipient');
      Navigator.pop(context);
    } else {
      Util.showToast(data['mess']);
    }
  }

  onLoading(bool isLoading) {
    _isLoadingSubject.sink.add(isLoading);
  }
}
