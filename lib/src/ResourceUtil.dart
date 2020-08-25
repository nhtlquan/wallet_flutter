import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
}
