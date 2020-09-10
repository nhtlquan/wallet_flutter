export 'dart:io';
export 'package:dio/dio.dart';

import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_wallet_app/src/Model/UserProfile.dart';

import 'HttpHelper.dart';

class ApiService {
  static String ACCESS_TOKEN = '';
  static String USER_ID = '';
  static UserProfile userProfile;
  static String USER_NAME = '';
  static String PIT_WALLET = '';

  static String BASE_URL = "https://pitnex.com/";
  static final String API_VERSION = "api/";

  //đăng ký
  static Future<Response> register(String encryptString) {
    final action = "member/regis";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params["regis_data"] = encryptString;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }

  //đăng nhập
  static Future<Response> login(String encryptString) {
    final action = "member/login";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params["login_data"] = encryptString;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }

  //đăng nhập
  static Future<Response> verifyEmail(String userName) {
    final action = "mem/sendmail_verifyAccount.php?username=" + userName;
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    return HttpHelper.requestApi(url, params, HttpMethod.get, false, true);
  }

  //SEND payment
  static Future<Response> sendPayment(String paymentData) {
    final action = "paymentQR";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params["payment_data"] = paymentData;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }

  //SEND payment
  static Future<Response> getWallet(String paymentData) {
    final action = "GetWallet";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params["data"] = paymentData;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }

  //lấy balance của pit account
  static Future<Response> getPitBalance(String data) {
    final action = "PitBalance";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params['data'] = data;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }

  //lấy balance của ví stask hoặc ví bussiness
  static Future<Response> getWalletBalance(String data) {
    final action = "WalletBalance";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params['data'] = data;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }

  //GetPitHistories
  static Future<Response> getPitHistories(String data) {
    final action = "PitHistories";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params['data'] = data;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }

  //lấy balance của ví stask hoặc ví bussiness
  static Future<Response> getWalletHistories(String data) {
    final action = "WalletHistories";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params['data'] = data;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }

  //Url2FA
  static Future<Response> googleAuthenUrl(String data) {
    final action = "GoogleAuthenUrl";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params['data'] = data;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }

  //upload KYC images
  static Future<Response> uploadKYC(String username, String kycname, String apikey, dynamic txt_file) {
    final action = "KYC";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params['username'] = username;
    params['kycname'] = kycname;
    params['apikey'] = apikey;
    params['txt_file'] = txt_file;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }

  //CreateWallet
  static Future<Response> createWallet(String data) {
    final action = "ActiveWallet";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params['data'] = data;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }

  //SendPit
  static Future<Response> sendPit(String data) {
    final action = "Send";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params['data'] = data;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }

  //SendPit
  static Future<Response> confirm2FA(String data) {
    final action = "confirm2fa";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params['data'] = data;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }

  //updateFile
  static Future<Response> uploadFile(File file, String kycname) {
    final action = "KYC";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    return HttpHelper.uploadImage(url, file, kycname);
  }
}
