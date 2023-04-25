import 'dart:convert';

GetWatchList getWatchListFromJson(String str) => GetWatchList.fromJson(json.decode(str));

String getWatchListToJson(GetWatchList data) => json.encode(data.toJson());

class GetWatchList {
  GetWatchList({
    required this.status,
    required this.msg,
    required this.data,
  });

  int status;
  String msg;
  List<FavData> data;

  factory GetWatchList.fromJson(Map<String, dynamic> json) => GetWatchList(
    status: json["status"] ?? 0,
    msg: json["msg"] ?? '',
    data: List<FavData>.from(json["data"].map((x) => FavData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class FavData {
  FavData({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.productDetails,
  });

  String id;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  ProductDetails productDetails;

  factory FavData.fromJson(Map<String, dynamic> json) => FavData(
    id: json["_id"] ?? '',
    userId: json["userId"] ?? '',
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"] ?? 0,
    productDetails: ProductDetails.fromJson(json["productDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "productDetails": productDetails.toJson(),
  };
}

class ProductDetails {
  ProductDetails({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String title;
  String description;
  String price;
  String imageUrl;
  int v;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
    id: json["_id"] ?? '',
    title: json["title"] ?? '',
    description: json["description"] ?? '',
    price: json["price"] ?? '',
    imageUrl: json["imageUrl"],
    v: json["__v"] ?? 0,
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "price": price,
    "imageUrl": imageUrl,
    "__v": v,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}