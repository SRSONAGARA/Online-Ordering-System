import 'dart:convert';

CartList cartListFromJson(String str) => CartList.fromJson(json.decode(str));

String cartListToJson(CartList data) => json.encode(data.toJson());

class CartList {
  CartList({
    required this.status,
    required this.msg,
  });

  int status;
  String msg;

  factory CartList.fromJson(Map<String, dynamic> json) => CartList(
    status: json["status"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
  };
}
