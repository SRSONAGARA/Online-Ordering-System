class MainData {
  // late final int? id;
  String productId;
  String productName;
  String shortDescription;
  int price;
  String imgLink;
  int quantity;
  // bool isFavorite;

  MainData({
    // required this.id,
    required this.productId,
    required this.productName,
    required this.shortDescription,
    required this.price,
    required this.imgLink,
    this.quantity = 1,
    // this.isFavorite=false
  });
}