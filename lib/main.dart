import 'package:flutter/material.dart';
import 'package:flutter_wallet_app/src/login/2faPage.dart';
import 'package:flutter_wallet_app/src/login/forgot2FA.dart';
import 'package:flutter_wallet_app/src/login/forgotPass.dart';
import 'package:flutter_wallet_app/src/login/kycPage.dart';
import 'package:flutter_wallet_app/src/login/ui/login_page.dart';
import 'package:flutter_wallet_app/src/pages/updateProfile.dart';
import 'package:flutter_wallet_app/src/theme/theme.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/login/changePassword.dart';
import 'src/pages/homePage.dart';
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

