import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Util.dart';

class ProjectUtil {
  static Future setString(String key, String stringValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, stringValue);
  }

  static Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key) ?? "";
    return value;
  }

}
