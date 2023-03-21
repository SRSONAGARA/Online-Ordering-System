import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
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

  void cleanCartItem() {
    _CartItems.clear();
    notifyListeners();
  }


  int allItemPrice() {
    Iterable<int> totalPrice = _CartItems.map((e) => e.price*e.quantity);
    totalPrice.toString();
    final sum = totalPrice.sum;
    return sum;
  }

  int allItemCount(){
    Iterable<int> totalCount = _CartItems.map((e) => e.quantity);
    totalCount.toString();
    final count = totalCount.sum;
    return count;
  }
}