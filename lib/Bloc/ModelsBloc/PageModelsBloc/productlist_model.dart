
import 'dart:convert';

ProductListBloc productListFromJson(String str) => ProductListBloc.fromJson(json.decode(str));

String productListToJson(ProductListBloc data) => json.encode(data.toJson());

class ProductListBloc {
  ProductListBloc({
    required this.status,
    required this.msg,
    required this.totalProduct,
    required this.data,
  });

  int status;
  String msg;
  int totalProduct;
  List<DataBloc> data;

  factory ProductListBloc.fromJson(Map<String, dynamic> json) => ProductListBloc(
    status: json["status"] ?? 0,
    msg: json["msg"] ?? '',
    totalProduct: json["totalProduct"] ?? 0,
    data: List<DataBloc>.from(json["data"].map((x) => DataBloc.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "totalProduct": totalProduct,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataBloc {
  DataBloc({
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

  factory DataBloc.fromJson(Map<String, dynamic> json) => DataBloc(
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

