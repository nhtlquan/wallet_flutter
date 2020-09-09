import 'dart:convert';
import 'dart:typed_data';

import 'package:cipher2/cipher2.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password/password.dart';
import 'package:password_hash/salt.dart';

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

  static Uint8List createUint8ListFromString(String s) {
    var ret = new Uint8List(s.length);
    for (var i = 0; i < s.length; i++) {
      ret[i] = s.codeUnitAt(i);
    }
    return ret;
  }

  static stringEncryption(Map data) async {
    var encrypt = json.encode(data);
    var salt = Salt.generateAsBase64String(16);
    var iv = Salt.generateAsBase64String(16).substring(0, 16);
    String key = hash256(generateMd5(keyPri) + '|' + salt);
    key = key.substring(0, 16);
    String encryptedString = await Cipher2.encryptAesCbc128Padding7(encrypt, key, iv);
    Map output = new Map<String, String>();
    output ['ciphertext'] = encodeBase64(encryptedString);
    output ['iv'] = iv;
    output ['salt'] = salt;
    return encodeBase64(json.encode(output));
  }

  static String keyPri = '6b73412dd2037b6d2ae3b2881b5073bc'; //c
  static decryptedString(String decrypt) async {
    decrypt = decodeBase64(decrypt);
    var dataDecode = json.decode(decrypt);
    var salt = dataDecode['salt'];
    var iv = dataDecode['iv'];
    var cipher = dataDecode['ciphertext'];
    var cipherText = decodeBase64(cipher);
    String key = hash256(generateMd5(keyPri) + '|' + salt);
    String decryptedString =
        await Cipher2.decryptAesCbc128Padding7(cipherText, key.substring(0, 16), iv.substring(0, 16));
    return json.decode(decryptedString);
  }

  static decodeBase64(String input) {
    return utf8.decode(base64.decode(input), allowMalformed: true);
  }
  static encodeBase64(String input) {
    return base64.encode(utf8.encode(input));
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
