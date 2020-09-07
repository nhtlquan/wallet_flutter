import 'package:flutter/material.dart';
import 'package:flutter_wallet_app/src/Helper/Constant.dart';
import 'package:pbkdf2_dart/pbkdf2_dart.dart';
import 'package:crypto/crypto.dart';
class LineBaseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Create PBKDF2 instance using the SHA256 hash. The default is to use SHA1

// Generate a 32 byte key using the given password and salt, with 1000 iterations
    return Divider(
      color: Constant.TEXTCOLOR_BLACK_2B.withOpacity(0.15),
      height: 0,
      thickness: 1,
    );
  }
}
