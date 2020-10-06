// To parse this JSON data, do
//
//     final packetList = packetListFromJson(jsonString);

import 'dart:convert';

PacketList packetListFromJson(String str) => PacketList.fromJson(json.decode(str));

String packetListToJson(PacketList data) => json.encode(data.toJson());

class PacketList {
  PacketList({
    this.status,
    this.data,
  });

  String status;
  Map<String, Packet> data;

  factory PacketList.fromJson(Map<String, dynamic> json) => PacketList(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Map.from(json["data"]).map((k, v) => MapEntry<String, Packet>(k, Packet.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Packet {
  Packet({
    this.name,
    this.price,
  });

  String name;
  String price;

  factory Packet.fromJson(Map<String, dynamic> json) => Packet(
    name: json["name"] == null ? null : json["name"],
    price: json["price"] == null ? null : json["price"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "price": price == null ? null : price,
  };
}
