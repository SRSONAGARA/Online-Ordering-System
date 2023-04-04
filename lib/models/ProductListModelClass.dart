
/*import 'dart:convert';

ProductList productListFromJson(String str) => ProductList.fromJson(json.decode(str));

String productListToJson(ProductList data) => json.encode(data.toJson());

class ProductList {
  ProductList({
    required this.staus,
    required this.msg,
    required this.totalProduct,
    required this.data,
  });

  int staus;
  String msg;
  int totalProduct;
  List<Data> data;

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
    staus: json["staus"],
    msg: json["msg"],
    totalProduct: json["totalProduct"],
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "staus": staus,
    "msg": msg,
    "totalProduct": totalProduct,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Data {
  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    imageUrl: json["imageUrl"],
    v: json["__v"],
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
}*/




import 'dart:convert';

ProductList productListFromJson(String str) => ProductList.fromJson(json.decode(str));

String productListToJson(ProductList data) => json.encode(data.toJson());

class ProductList {
  ProductList({
    required this.status,
    required this.msg,
    required this.totalProduct,
    required this.data,
  });

  int status;
  String msg;
  int totalProduct;
  List<Data> data;

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
    status: json["status"] ?? 0,
    msg: json["msg"] ?? '',
    totalProduct: json["totalProduct"] ?? 0,
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "totalProduct": totalProduct,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Data {
  Data({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.cartItemId,
    this.quantity,
    this.watchListItemId
  });

  String id;
  String title;
  String description;
  String price;
  String imageUrl;
  String? cartItemId;
  int? quantity;
  String? watchListItemId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"] ?? '',
    title: json["title"] ?? '',
    description: json["description"] ?? '',
    price: json["price"] ?? '',
    imageUrl: json["imageUrl"] ?? '',
    cartItemId: json["cartItemId"] ?? '',
    quantity: json["quantity"] ?? 0,
      watchListItemId: json["watchListItemId"] ?? ''
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "price": price,
    "imageUrl": imageUrl,
    "cartItemId": cartItemId,
    "quantity": quantity,
    "watchListItemId": watchListItemId
  };
}

