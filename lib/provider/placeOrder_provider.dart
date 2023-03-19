import 'package:flutter/foundation.dart';

import '../models/PlaceOrderData.dart';

class PlaceOrderProvider with ChangeNotifier {
  List<PlaceOrderData> _PlaceOrderItmes = [];
  List<dynamic> get PlaceOrderItmes => _PlaceOrderItmes;
  void placeItem(PlaceOrderData placeOrderData) {
    _PlaceOrderItmes.add(placeOrderData);
    notifyListeners();
  }
}
