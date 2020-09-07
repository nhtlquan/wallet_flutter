import 'package:flutter/cupertino.dart';

import '../ResourceUtil.dart';

class Constant {
  static final Color TEXTCOLOR_BLUE = ColorExtends("1A4BB7");
  static final Color TEXTCOLOR_BLUE_BOLD = ColorExtends("16397b");
  static final Color TEXTCOLOR_BLACK = ColorExtends("404040");
  static final Color TEXTCOLOR_BLACK_BLUE = ColorExtends("97A1A4");
  static final Color TEXTCOLOR_RED = ColorExtends("f14336");
  static final Color TEXTCOLOR_ORANGE = ColorExtends("f7931d");
  static final Color COLOR_DISABLE = ColorExtends("f3f3f3");
  static final Color COLOR_LINE = ColorExtends("e1e1e1");
  static final Color COLOR_WHITE = ColorExtends("FFFFFF");
  static final Color COLOR_BLUE = ColorExtends("4ab0fe");
  static final Color COLOR_BLACK78 = ColorExtends("787878");

  static final Color TEXTCOLOR_BLUE_27 = ColorExtends("273879");
  static final Color TEXTCOLOR_BLUE_1A = ColorExtends("1A4BB7");
  static final Color TEXTCOLOR_BLUE_49 = ColorExtends("4984E4");
  static final Color TEXTCOLOR_GREEN_92 = ColorExtends("926828");
  static final Color TEXTCOLOR_GREEN_AB = ColorExtends("AB8843");
  static final Color TEXTCOLOR_GREEN_DA = ColorExtends("DAB868");
  static final Color TEXTCOLOR_GREEN_E7 = ColorExtends("E7843F");
  static final Color TEXTCOLOR_GREEN_FF = ColorExtends("ffb800");
  static final Color TEXTCOLOR_GREEN_63 = ColorExtends("63d417");
  static final Color TEXTCOLOR_TITLE_4C = ColorExtends("4C4B5D");
  static final Color TEXTCOLOR_LINE_B3 = ColorExtends("B3B3B3");
  static final Color TEXTCOLOR_BORDER = ColorExtends("EAEAEA");
  static final Color TEXTCOLOR_BLUE_F0 = ColorExtends("F0F9FB");
  static final Color TEXTCOLOR_BLUE_2D = ColorExtends("2D48B9");
  static final Color TEXTCOLOR_CAPTION_78 = ColorExtends("787878");
  static final Color TEXTCOLOR_ORANGE_F4 = ColorExtends("F47F66");
  static final Color TEXTCOLOR_BLACK_2B = ColorExtends("2B2B2B");
  static final Color TEXTCOLOR_BLACK_4B = ColorExtends("4B4B4B");
  static final Color TEXTCOLOR_BG_F4 = ColorExtends("F4F4F4");
  static final Color TEXTCOLOR_BLACK_92 = ColorExtends("929292");
  static final Color TEXTCOLOR_BLACK_F7 = ColorExtends("F7F7F7");
  static final Color TEXTCOLOR_BLACK_9A = ColorExtends("9A9A9A");
  static final Color TEXTCOLOR_BLACK_D8 = ColorExtends("D8D8D8");
  static final Color TEXTCOLOR_BLACK_62 = ColorExtends("626262");
  static final Color TEXTCOLOR_BLACK_C4 = ColorExtends("c4c4c4");
  static final Color TEXTCOLOR_BLACK_EB = ColorExtends("ebebeb");
  static final Color TEXTCOLOR_BLACK_F5 = ColorExtends("F5F5F5");
  static final Color COLOR_VIP0 = ColorExtends("2b2b2b");
  static final Color COLOR_VIP1 = ColorExtends("993393");
  static final Color COLOR_VIP2 = ColorExtends("dd8c43");
  static final Color COLOR_VIP3 = ColorExtends("b18734");

  static final Color TEXTCOLOR_RED_D2 = ColorExtends("d22200");

  static final String idLoginChat = "1";
  static final String idListEmojiCustom = '2';
  static final String idRooms = '3';
  static final String idLoadHistory = '5';
  static final String idNotifyRoom = '4';

  static final GRADIENT_BG_TITLE_DETAIL = [
    ColorExtends("000000").withOpacity(0.79),
    ColorExtends("161616").withOpacity(0.44),
    ColorExtends("2B2B2B").withOpacity(0),
  ];

  static final GRADIENT_ORANGE = [
    ColorExtends("f7931d"),
    ColorExtends("fec10d"),
  ];
  static final GRADIENT_BLUE = [
    ColorExtends("4ab0fe"),
    ColorExtends("1ed7fe"),
  ];
  static final GRADIENT_KHOINGUON = [
    ColorExtends("1366b0"),
    ColorExtends("16397b"),
  ];
  static final GRADIENT_PHATTRIEN = [
    ColorExtends("f7931d"),
    ColorExtends("fec10d"),
  ];
  static final GRADIENT_THAYDOI = [
    ColorExtends("ee5157"),
    ColorExtends("fb5e5e"),
  ];
  static final GRADIENT_BLACK_OPACITY = [
    ColorExtends("000000").withOpacity(0.8),
    ColorExtends("000000").withOpacity(0),
  ];
  static final GRADIENT_BLUE_REVERT = [
    ColorExtends("1ed7fe"),
    ColorExtends("4ab0fe"),
  ];
  static final GRADIENT_TRAN = [
    ColorExtends("00"),
    ColorExtends("00"),
  ];
  static final GRADIENT_BLACK = [
    ColorExtends("00"),
    ColorExtends("000000"),
  ];

  static final GRADIENT_RED = [
    ColorExtends("ee5157"),
    ColorExtends("fb5e5e"),
  ];

  static final GRADIENT_CHART_1 = [
    ColorExtends("1dbaba"),
    ColorExtends("1dbaba"),
  ];

  static final GRADIENT_CHART_2 = [
    ColorExtends("4db1fd"),
    ColorExtends("25d5fd"),
  ];

  static final GRADIENT_CHART_3 = [
    ColorExtends("f35d76"),
    ColorExtends("f186d8"),
  ];

  static final GRADIENT_CHART_4 = [
    ColorExtends("47e97d"),
    ColorExtends("3df7d2"),
  ];

  static final GRADIENT_CHART_5 = [
    ColorExtends("784ea3"),
    ColorExtends("6a7de6"),
  ];

  static final GRADIENT_CHART_6 = [
    ColorExtends("ee545a"),
    ColorExtends("f96060"),
  ];

  static final String KEY_CAMPAIGN = "KEY_CAMPAIGN";
  static final String KEY_AcessToken = "KEY_USER_ACCESS_TOKEN";
  static final String KEY_USER_ID = "KEY_USER_ID";
  static final String KEY_USER_ID_GUEST = "KEY_USER_ID_CHAT_GUEST";
  static final String KEY_TOKEN_CHAT = "KEY_TOKEN_CHAT";
  static final String KEY_TOKEN_CHAT_GUEST = "KEY_TOKEN_CHAT_GUEST";
  static final String KEY_USER_NAME = "KEY_USER_NAME";
  static final String KEY_PASSWORD = "KEY_PASSWORD";
  static final String STREAM_NOTIFY_USER = 'stream-notify-user';

  static final String KEY_ReloadRankReward = "reload_rank_reward";
  static final String KEY_ReloadUserInfo = "reload_userinfo";

  static final String KEY_Language = "key_language";
  static final String KEY_Language_Vi = "key_language_vi";
  static final String KEY_Language_En = "key_language_en";
  static final String KEY_Longitude = "longitude";
  static final String KEY_Latitude = "latitude";
  static final String KEY_UserLogin = "key_user_login";
  static final String KEY_FavoriteArticle = "key_favorite";
  static final String KEY_CompareArticle = "key_compare";
  static final String KEY_MarkReadArticle = "key_markread";
  static final String KEY_CompareArticleBuySell = "key_compare_buysell";
  static final String KEY_CompareArticleRent = "key_compare_rent";
  static final String KEY_CompareArticleTransfer = "key_compare_transfer";
  static final String KEY_SearchHistory = "key_search_history";
  static final String KEY_FilterHistory_BuySell = "key_filter_history_buysell";
  static final String KEY_FilterHistory_Rent = "key_filter_history_rent";
  static final String KEY_FilterHistory_Transfer = "key_filter_history_transfer";
  static final String KEY_RefreshToken = "eqweqweweqegdfdfhbvngrt1231232";
  static final int statusCodeError = 696969;


}
