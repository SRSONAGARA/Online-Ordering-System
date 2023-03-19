class PlaceOrderData {
  int price;
  String productName;
  String shortDescription;
  String imgLink;
  int quantity;
  DateTime dateTime;

  PlaceOrderData(
      {required this.price,
        required this.productName,
        required this.shortDescription,
        required this.imgLink,
        required this.quantity,
        required this.dateTime});
}
