export 'dart:io';
export 'package:dio/dio.dart';

import 'dart:io';

import 'package:dio/dio.dart';

import 'HttpHelper.dart';

class ApiService {
  static String ACCESS_TOKEN = '';
  static String USER_ID = '';
  static String USER_NAME = '';
  static String PIT_WALLET = '';

  static String BASE_URL = "https://pitnex.com/";
  static final String API_VERSION = "api/";




  //đăng ký
  static register(String encryptString) {
    final action = "member/regis";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params["regis_data"] = encryptString;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }

  //đăng nhập
  static login(String encryptString) {
    final action = "member/login";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params["login_data"] = encryptString;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }

  //đăng nhập
  static verifyEmail(String userName){
    final action = "mem/sendmail_verifyAccount.php?username="+userName;
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    return HttpHelper.requestApi(url, params, HttpMethod.get, false, true);
  }

  //SEND payment
  static sendPayment(String paymentData){
    final action = "paymentQR";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params["{'payment_data'}"] = paymentData;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }

  //lấy balance của pit account
  static getPitBalance (String data){
    final action = "PitBalance";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params['data'] = data;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }

  //lấy balance của ví stask hoặc ví bussiness
  static getWalletBalance (String data) {
    final action = "WalletBalance";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params['data'] = data;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }

  //GetPitHistories
  static getPitHistories (String data) {
    final action = "PitHistories";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params['data'] = data;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }

  //lấy balance của ví stask hoặc ví bussiness
  static getWalletHistories (String data) {
    final action = "WalletHistories";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params['data'] = data;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }
  //Url2FA
  static googleAuthenUrl (String data) {
    final action = "GoogleAuthenUrl";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params['data'] = data;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }
  
  //upload KYC images
  static uploadKYC(String username, String kycname, String apikey, dynamic txt_file) {
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
  static createWallet (String data) {
    final action = "ActiveWallet";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params['data'] = data;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }
  //SendPit
  static sendPit (String data) {
    final action = "Send";
    final url = ApiService.BASE_URL + ApiService.API_VERSION + action;
    var params = Map<String, String>();
    params['data'] = data;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, true);
  }
}
