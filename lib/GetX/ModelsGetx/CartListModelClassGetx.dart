import 'dart:convert';

GetMyCartGetx getMyCartFromJson(String str) => GetMyCartGetx.fromJson(json.decode(str));

String getMyCartToJson(GetMyCartGetx data) => json.encode(data.toJson());

class GetMyCartGetx {
  GetMyCartGetx({
    required this.status,
    required this.msg,
    required this.cartTotal,
    required this.data,
  });

  int? status;
  String? msg;
  double? cartTotal;
  List<CartDataGetx>? data;

  factory GetMyCartGetx.fromJson(Map<String, dynamic> json) => GetMyCartGetx(
    status: json["status"] ?? 0,
    msg: json["msg"] ?? '',
    cartTotal: json["cartTotal"] == null ? 0.00 : json["cartTotal"].toDouble(),
    data:json["data"] != null ? List<CartDataGetx>.from(json["data"].map((x) => CartDataGetx.fromJson(x))): <CartDataGetx>[],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "cartTotal": cartTotal,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CartDataGetx {
  CartDataGetx({
    required this.id,
    required this.userId,
    required this.cartId,
    required this.quantity,
    required this.itemTotal,
    required this.productDetails,
  });

  String id;
  String userId;
  String cartId;
  int quantity;
  double itemTotal;
  ProductDetails productDetails;

  factory CartDataGetx.fromJson(Map<String, dynamic> json) => CartDataGetx(
    id: json["_id"] ?? '',
    userId: json["userId"] ?? '',
    cartId: json["cartId"] ?? '',
    quantity: json["quantity"] ?? 0,
    itemTotal: json["itemTotal"] == null ? 0.00 : json["itemTotal"].toDouble(),
    productDetails: ProductDetails.fromJson(json["productDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "cartId": cartId,
    "quantity": quantity,
    "itemTotal": itemTotal,
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
  });

  String id;
  String title;
  String description;
  String price;
  String imageUrl;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
    id: json["_id"] ?? '',
    title: json["title"] ?? '',
    description: json["description"] ?? '',
    price: json["price"] ?? '',
    imageUrl: json["imageUrl"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "price": price,
    "imageUrl": imageUrl,
  };
}
