// To parse this JSON data, do
//
//     final pitHistory = pitHistoryFromJson(jsonString);

import 'dart:convert';

PitHistory pitHistoryFromJson(String str) => PitHistory.fromJson(json.decode(str));

String pitHistoryToJson(PitHistory data) => json.encode(data.toJson());

class PitHistory {
  PitHistory({
    this.status,
    this.data,
  });

  String status;
  List<History> data;

  factory PitHistory.fromJson(Map<String, dynamic> json) => PitHistory(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<History>.from(json["data"].map((x) => History.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class History {
  History({
    this.id,
    this.userId,
    this.username,
    this.fromWallet,
    this.toWallet,
    this.type,
    this.txhash,
    this.amount,
    this.memo,
    this.transTime,
    this.cdate,
  });

  String id;
  String userId;
  Username username;
  String fromWallet;
  String toWallet;
  Type type;
  String txhash;
  String amount;
  String memo;
  String transTime;
  String cdate;

  factory History.fromJson(Map<String, dynamic> json) => History(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    username: json["username"] == null ? null : usernameValues.map[json["username"]],
    fromWallet: json["from_wallet"] == null ? null : json["from_wallet"],
    toWallet: json["to_wallet"] == null ? null : json["to_wallet"],
    type: json["type"] == null ? null : typeValues.map[json["type"]],
    txhash: json["txhash"] == null ? null : json["txhash"],
    amount: json["amount"] == null ? null : json["amount"],
    memo: json["memo"] == null ? null : json["memo"],
    transTime: json["trans_time"] == null ? null : json["trans_time"],
    cdate: json["cdate"] == null ? null : json["cdate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "username": username == null ? null : usernameValues.reverse[username],
    "from_wallet": fromWallet == null ? null : fromWallet,
    "to_wallet": toWallet == null ? null : toWallet,
    "type": type == null ? null : typeValues.reverse[type],
    "txhash": txhash == null ? null : txhash,
    "amount": amount == null ? null : amount,
    "memo": memo == null ? null : memo,
    "trans_time": transTime == null ? null : transTime,
    "cdate": cdate == null ? null : cdate,
  };
}

enum Type { TRAN_RECEIVED, TRAN_SEND }

final typeValues = EnumValues({
  "TRAN_RECEIVED": Type.TRAN_RECEIVED,
  "TRAN_SEND": Type.TRAN_SEND
});

enum Username { DUNGBINANCE_GMAIL_COM }

final usernameValues = EnumValues({
  "dungbinance@gmail.com": Username.DUNGBINANCE_GMAIL_COM
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
