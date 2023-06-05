import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchGetxController extends GetxController{
  TextEditingController searchController = TextEditingController();
  bool SearchButton = false;
  Icon CustomSearch = const Icon(Icons.search, color: Colors.white,);
  Widget CustomText = const Text("Ordefy",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),);
  Icon CusIcon=const Icon(Icons.menu, color: Colors.blue,);
  bool ListEmptyBool = false;

  searchButtonPress(){
    SearchButton = false;
    CustomSearch = const Icon(Icons.search, color: Colors.white,);
    CustomText = const Text("Ordefy",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),);
    update();
  }
   searchButtonUnPress(){
    SearchButton = true;
    update();
  }
  void searchListIsEmpty(){
    ListEmptyBool = true;
    update();
  }
  void searchListIsNotEmpty(){
    ListEmptyBool = false;
    update();
  }
}