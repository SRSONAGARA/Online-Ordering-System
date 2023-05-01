import 'dart:convert';

GetWatchListGetx getWatchListFromJson(String str) => GetWatchListGetx.fromJson(json.decode(str));

String getWatchListToJson(GetWatchListGetx data) => json.encode(data.toJson());

class GetWatchListGetx {
  GetWatchListGetx({
    required this.status,
    required this.msg,
    required this.data,
  });

  int status;
  String msg;
  List<FavDataGetx> data;

  factory GetWatchListGetx.fromJson(Map<String, dynamic> json) => GetWatchListGetx(
    status: json["status"] ?? 0,
    msg: json["msg"] ?? '',
    data: List<FavDataGetx>.from(json["data"].map((x) => FavDataGetx.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class FavDataGetx {
  FavDataGetx({
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

  factory FavDataGetx.fromJson(Map<String, dynamic> json) => FavDataGetx(
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