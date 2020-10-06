import 'dart:math';

import 'package:fluttertoast/fluttertoast.dart';

import '../ResourceUtil.dart';

enum WalletType { p, s, b }

class Util {
  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorExtends("2B2B2B").withOpacity(0.7),
        timeInSecForIosWeb: 3);
  }

  static String doubleToString(double value) {
    if (value == null) {
      return "";
    }
    return value.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
  }

  static double round(double val, int places) {
    if (val == null) {
      return null;
    }
    double mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }
}
