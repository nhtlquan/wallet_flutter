import 'dart:convert';
import 'dart:typed_data';

import 'package:cipher2/cipher2.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password/password.dart';

class ResourceUtil {
  static final _pathResource = "assets/";

  static image(String name) {
    if (name.contains(".")) {
      return _pathResource + "images/" + name;
    }
    return _pathResource + "images/" + name + ".png";
  }

  static imageHome(String name) {
    if (name.contains(".")) {
      return _pathResource + "images/Home/" + name;
    }
    return _pathResource + "images/Home/" + name + ".png";
  }

  static imageComingSoon(String name) {
    if (name.contains(".")) {
      return _pathResource + "images/ComingSoon/" + name;
    }
    return _pathResource + "images/ComingSoon/" + name + ".png";
  }

  static Color hexToColor(String code) {
    //return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    return ColorExtends(code);
  }

  static imageWeather(String name) {
    if (name.contains(".")) {
      return _pathResource + "images/Weather/" + name;
    }
    return _pathResource + "images/Weather/" + name + ".png";
  }

  static icon(String name) {
    if (name.contains(".")) {
      return _pathResource + "icons/" + name;
    }
    return _pathResource + "icons/" + name + ".png";
  }

  static gif(String name) {
    if (name.contains(".")) {
      return _pathResource + "gif/" + name;
    }
    return _pathResource + "gif/" + name + ".png";
  }

  static iconHome(String name) {
    if (name.contains(".")) {
      return _pathResource + "icons/Home/" + name;
    }
    return _pathResource + "icons/Home/" + name + ".png";
  }

  static iconLogin(String name) {
    if (name.contains(".")) {
      return _pathResource + "icons/Login/" + name;
    }
    return _pathResource + "icons/Login/" + name + ".png";
  }

  static stringEncryption(Map data) async {
      var salt = '31323331323331323331333132333233313331333133';
    var key = '380dead2c94c688dafb90e2aa44844c5';
    var hash = Password.hash(
        'password',
        new PBKDF2(
          salt: salt,
          iterationCount: 999,
          desiredKeyLength: 32
        ));

//    final pbkdf2 = new PBKDF2KeyDerivator(new HMac(new SHA256Digest(), 64));
//    var salt =createUint8ListFromString('a21256f98091b96af394d5a2e4ceb52f7a2270daa5eed87600b8cdbea83b1e1a');
//    pbkdf2.init(new Pbkdf2Parameters(salt, 999, 32));
//    pbkdf2.deriveKey(createUint8ListFromString(key), 0, B, 0);
//    var generator = new PBKDF2();
//    var hash = generator.generateBase64Key(key, salt, 999, 32);
//
    print('hash: '+hash.toString());
    print('hash: '+'f6c6be262c4c31647b13ebdb24925be9');
    return;
    String encrypt = json.encode(data);
    String iv = '12345678910@!111';
    String encryptedString = await Cipher2.encryptAesCbc128Padding7(encrypt, key.substring(0, 16), iv);
    return encryptedString;
  }

  static Uint8List createUint8ListFromString(String s) {
    var ret = new Uint8List(s.length);
    for (var i = 0; i < s.length; i++) {
      ret[i] = s.codeUnitAt(i);
    }
    return ret;
  }

  static decryptedString(String decrypt) async {
    String key = '380dead2c94c688dafb90e2aa44844c5'; //combination of 16 character
    String iv = '12345678910@!111'; ////combination of 16 character
    String decryptedString = await Cipher2.decryptAesCbc128Padding7(decrypt, key.substring(0, 16), iv);
    return json.decode(decryptedString);
  }

  static String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static String hash256(String input) {
    var bytes1 = utf8.encode(input); // data being hashed
    var digest1 = sha256.convert(bytes1);
    return digest1.toString();
  }
}

class ColorExtends extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  ColorExtends(final String hexColor) : super(_getColorFromHex(hexColor));
}
