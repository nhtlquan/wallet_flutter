import 'package:flutter/material.dart';
import 'package:PitWallet/src/login/2faPage.dart';
import 'package:PitWallet/src/login/forgot2FA.dart';
import 'package:PitWallet/src/login/forgotPass.dart';
import 'package:PitWallet/src/login/kycPage.dart';
import 'package:PitWallet/src/login/ui/login_page.dart';
import 'package:PitWallet/src/pages/HomePage.dart';
import 'package:PitWallet/src/pages/updateProfile.dart';
import 'package:PitWallet/src/theme/theme.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/login/changePassword.dart';
import 'src/pages/MainPage.dart';
import 'src/pages/money_transfer_page.dart';
import 'src/widgets/customRoute.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Wallet App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.muliTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routes: <String, WidgetBuilder>{
          '/': (_) => LoginPage(),
          'HomePage': (_) => HomePage(),
          '/transfer': (_) => MoneyTransferPage()
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] == '') {
            return null;
          }
          if (pathElements[0] == 'transfer') {
            return CustomRoute<bool>(
                builder: (BuildContext context) => MoneyTransferPage());
          }
        }
    );
  }
}

