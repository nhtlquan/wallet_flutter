import 'package:fluttertoast/fluttertoast.dart';

import '../ResourceUtil.dart';

enum WalletType { p, s, b }

class Util {
  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorExtends("2B2B2B").withOpacity(0.7),
        timeInSecForIosWeb: 3);
  }
}
