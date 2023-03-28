import 'package:flutter/foundation.dart';
import '../models/MainData.dart';

class FavouriteProvider with ChangeNotifier{

  List<MainData> _FavItems = [];
  List<dynamic> get FavItems =>_FavItems;

  void addItem(MainData product){
    _FavItems.add(product);
    notifyListeners();
  }
  void removeItem(MainData product){
    _FavItems.remove(product);
    notifyListeners();
  }
  bool isExist(List FavItems){
    final isExist=_FavItems.contains(FavItems);
    return isExist;
  }

  void ClearFavorite(){
    _FavItems=[];
    notifyListeners();
  }

}