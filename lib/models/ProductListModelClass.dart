
import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.staus,
    required this.msg,
    required this.totalProduct,
    required this.data,
  });

  int staus;
  String msg;
  int totalProduct;
  List<Data> data;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
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
}
















class ProductAllApi {
  int status;
  String msg;
  int totalProduct;
  List<ProductAllApiData> data;

  ProductAllApi(
      {required this.status,
      required this.msg,
      required this.totalProduct,
      required this.data});
  factory ProductAllApi.fromjson(Map<String, dynamic> json) {
    final List<ProductAllApiData> dataList = [];
    for(var data in json['data']){
      dataList.add(ProductAllApiData.fromJson(data));
    }
    return ProductAllApi(
        status: json['status'],
        msg: json['msg'],
        totalProduct: json['totalProduct'],
        data: dataList);
  }
}

class ProductAllApiData {
  String id;
  String title;
  String description;
  String price;
  String imageUrl;
  int v;
  String createdAt;
  String updatedAt;

  ProductAllApiData({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
  });
  factory ProductAllApiData.fromJson(Map<String, dynamic> json) {
    return ProductAllApiData(
        id: json['_id'],
        title: json['title'],
        description: json['description'],
        price: json['price'],
        imageUrl: json['imageUrl'],
        v: json['__v'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }
}
