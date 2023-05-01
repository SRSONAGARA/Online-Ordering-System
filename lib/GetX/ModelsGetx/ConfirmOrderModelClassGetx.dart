import 'dart:convert';

ConfirmOrderListGetx confirmOrderListFromJson(String str) => ConfirmOrderListGetx.fromJson(json.decode(str));

String confirmOrderListToJson(ConfirmOrderListGetx data) => json.encode(data.toJson());

class ConfirmOrderListGetx {
  ConfirmOrderListGetx({
    required this.status,
    required this.msg,
    required this.data,
  });

  int status;
  String msg;
  List<ConfirmData> data;

  factory ConfirmOrderListGetx.fromJson(Map<String, dynamic> json) => ConfirmOrderListGetx(
    status: json["status"] ?? 0,
    msg: json["msg"] ?? '',
    data: List<ConfirmData>.from((json["data"] ?? []).map((x) => ConfirmData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ConfirmData {
  ConfirmData({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.productId,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.productTotalAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String userId;
  String orderId;
  String productId;
  String title;
  String description;
  String price;
  String imageUrl;
  int quantity;
  String productTotalAmount;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory ConfirmData.fromJson(Map<String, dynamic> json) => ConfirmData(
    id: json["_id"] ?? '',
    userId: json["userId"] ?? '',
    orderId: json["orderId"] ?? '',
    productId: json["productId"] ?? '',
    title: json["title"] ?? '',
    description: json["description"] ?? '',
    price: json["price"] ?? '',
    imageUrl: json["imageUrl"] ?? '',
    quantity: json["quantity"] ?? 0,
    productTotalAmount: json["productTotalAmount"] ?? '',
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "orderId": orderId,
    "productId": productId,
    "title": title,
    "description": description,
    "price": price,
    "imageUrl": imageUrl,
    "quantity": quantity,
    "productTotalAmount": productTotalAmount,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}