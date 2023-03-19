class MainData {
  // late final int? id;
  final String productId;
  final String productName;
  final String shortDescription;
  final int price;
  final String imgLink;
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