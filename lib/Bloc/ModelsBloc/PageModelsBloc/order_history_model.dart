import 'dart:convert';

GetOrderHistory getOrderHistoryFromJson(String str) => GetOrderHistory.fromJson(json.decode(str));

String getOrderHistoryToJson(GetOrderHistory data) => json.encode(data.toJson());

class GetOrderHistory {
  GetOrderHistory({
    required this.status,
    required this.msg,
    required this.data,
  });

  int status;
  String msg;
  List<OrderHistoryData> data;

  factory GetOrderHistory.fromJson(Map<String, dynamic> json) => GetOrderHistory(
    status: json["status"] ?? 0,
    msg: json["msg"] ?? '',
    data: List<OrderHistoryData>.from((json["data"] ?? []).map((x) => OrderHistoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OrderHistoryData {
  OrderHistoryData({
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

  factory OrderHistoryData.fromJson(Map<String, dynamic> json) => OrderHistoryData(
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