class ProductModel{
  // late final int? id;
  final String productId;
  final String productName;
  final String shortDescription;
  final String price;
  final String imgLink;
  // bool isFavorite;

  ProductModel({
    // required this.id,
    required this.productId,
    required this.productName,
    required this.shortDescription,
    required this.price,
    required this.imgLink,
    // this.isFavorite=false
  });

}