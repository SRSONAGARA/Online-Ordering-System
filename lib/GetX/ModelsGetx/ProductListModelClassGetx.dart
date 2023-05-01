
import 'dart:convert';

ProductListGetx productListFromJson(String str) => ProductListGetx.fromJson(json.decode(str));

String productListToJson(ProductListGetx data) => json.encode(data.toJson());

class ProductListGetx {
  ProductListGetx({
    required this.status,
    required this.msg,
    required this.totalProduct,
    required this.data,
  });

  int status;
  String msg;
  int totalProduct;
  List<DataGetx> data;

  factory ProductListGetx.fromJson(Map<String, dynamic> json) => ProductListGetx(
    status: json["status"] ?? 0,
    msg: json["msg"] ?? '',
    totalProduct: json["totalProduct"] ?? 0,
    data: List<DataGetx>.from(json["data"].map((x) => DataGetx.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "totalProduct": totalProduct,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataGetx {
  DataGetx({
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

  factory DataGetx.fromJson(Map<String, dynamic> json) => DataGetx(
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

