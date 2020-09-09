// To parse this JSON data, do
//
//     final pitHistory = pitHistoryFromJson(jsonString);

import 'dart:convert';

HistoryWallet pitHistoryFromJson(String str) => HistoryWallet.fromJson(json.decode(str));

String pitHistoryToJson(HistoryWallet data) => json.encode(data.toJson());

class HistoryWallet {
  HistoryWallet({
    this.status,
    this.data,
  });

  String status;
  List<HistoryWa> data;

  factory HistoryWallet.fromJson(Map<String, dynamic> json) => HistoryWallet(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<HistoryWa>.from(json["data"].map((x) => HistoryWa.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class HistoryWa {
  HistoryWa({
    this.id,
    this.username,
    this.money,
    this.cdate,
    this.note,
    this.type,
    this.status,
  });

  String id;
  Username username;
  String money;
  String cdate;
  String note;
  String type;
  String status;

  factory HistoryWa.fromJson(Map<String, dynamic> json) => HistoryWa(
    id: json["id"] == null ? null : json["id"],
    username: json["username"] == null ? null : usernameValues.map[json["username"]],
    money: json["money"] == null ? null : json["money"],
    cdate: json["cdate"] == null ? null : json["cdate"],
    note: json["note"] == null ? null : json["note"],
    type: json["type"] == null ? null : json["type"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "username": username == null ? null : usernameValues.reverse[username],
    "money": money == null ? null : money,
    "cdate": cdate == null ? null : cdate,
    "note": note == null ? null : note,
    "type": type == null ? null : type,
    "status": status == null ? null : status,
  };
}

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
