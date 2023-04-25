import 'dart:convert';

GetMyCart getMyCartFromJson(String str) => GetMyCart.fromJson(json.decode(str));

String getMyCartToJson(GetMyCart data) => json.encode(data.toJson());

class GetMyCart {
  GetMyCart({
    required this.status,
    required this.msg,
    required this.cartTotal,
    required this.data,
  });

  int? status;
  String? msg;
  double? cartTotal;
  List<CartData>? data;

  factory GetMyCart.fromJson(Map<String, dynamic> json) => GetMyCart(
        status: json["status"] ?? 0,
        msg: json["msg"] ?? '',
        cartTotal: json["cartTotal"] == null ? 0.00 : json["cartTotal"].toDouble(),
        data:json["data"] != null ? List<CartData>.from(json["data"].map((x) => CartData.fromJson(x))): <CartData>[],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "cartTotal": cartTotal,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CartData {
  CartData({
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

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
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
