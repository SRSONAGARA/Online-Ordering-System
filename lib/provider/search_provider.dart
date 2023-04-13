import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class SearchProvider with ChangeNotifier{
  TextEditingController search = TextEditingController();
  bool SearchButton = false;
  Icon CustomSearch = const Icon(Icons.search, color: Colors.blue,);
  Widget CustomText = const Text("Ordefy",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),);
  // List<dynamic> SearchItems = [];
  Icon CusIcon=const Icon(Icons.menu, color: Colors.blue,);
  bool ListEmptyBool = false;


   searchButtonPress(){
    SearchButton = false;
    CustomSearch = const Icon(Icons.search, color: Colors.blue,);
    CustomText = const Text("Ordefy",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),);
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