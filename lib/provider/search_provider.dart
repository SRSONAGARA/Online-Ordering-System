import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class SearchProvider with ChangeNotifier{
  TextEditingController search = TextEditingController();
  bool SearchButton = false;
  Icon CustomSearch = Icon(Icons.search);
  Widget CustomText = Text("Online Ordering System");
  List<dynamic> SearchItems = [];
  Icon CusIcon=Icon(Icons.menu);
  bool ListEmptyBool = false;


   searchButtonPress(){
    SearchButton = false;
    CustomSearch = const Icon(Icons.search);
    CustomText = const Text("Online Ordering System");
    notifyListeners();

  }
  void searchButtonUnPress(){
    SearchButton = true;
    notifyListeners();
  }

  void searchListIsEmpty(){
    ListEmptyBool = true;
    notifyListeners();
  }
  void searchListIsNotEmpty(){
    ListEmptyBool = false;
    notifyListeners();
  }
}