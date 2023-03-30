import 'dart:convert';

WatchList watchListFromJson(String str) => WatchList.fromJson(json.decode(str));

String watchListToJson(WatchList data) => json.encode(data.toJson());

class WatchList {
  WatchList({
    required this.status,
    required this.msg,
    required this.data,
  });

  int status;
  String msg;
  List<dynamic> data;

  factory WatchList.fromJson(Map<String, dynamic> json) => WatchList(
    status: json["status"],
    msg: json["msg"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
