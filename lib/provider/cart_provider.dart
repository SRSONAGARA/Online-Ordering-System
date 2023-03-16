import 'package:flutter/foundation.dart';
import 'package:oline_ordering_system/models/MainData.dart';

class CartProvider with ChangeNotifier{
  List<MainData> _CartItems=[];
  List<dynamic> get CartItems =>_CartItems;

  void addItem(MainData product){
    _CartItems.add(product);
    notifyListeners();
  }
  void removeItem(MainData product){
    _CartItems.remove(product);
    notifyListeners();
  }

}