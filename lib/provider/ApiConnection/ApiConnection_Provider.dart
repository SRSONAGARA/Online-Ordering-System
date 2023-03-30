import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:oline_ordering_system/common/ApiConstant.dart';
import 'package:oline_ordering_system/models/CartListModelClass.dart';
import 'package:oline_ordering_system/models/ProductListModelClass.dart';
import 'package:oline_ordering_system/models/WatchListModelClass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiConnectionProvider extends ChangeNotifier {

  List<Data> data = [];
  List<CartList> cart=[];
  List<WatchList> watchList=[];

  Future<List<Data>> getData() async {
    print('function');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    const url =ApiConstant.getAllProductApi;
    final header = {"Authorization": 'Bearer $jwtToken'};
    final response = await http.get(Uri.parse(url), headers: header);
    var item = jsonDecode(response.body);
    var product = item['data'];
    print(product);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in product) {
        data.add(Data.fromJson(index));
      }
      return data;
    } else {
      return data;
    }

  }


  Future<List<CartList>> getMyCart() async {
    print('MyCart');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    const url =ApiConstant.getMyCartApi;
    final header = {"Authorization": 'Bearer $jwtToken'};
    final response = await http.get(Uri.parse(url), headers: header);
    var item = jsonDecode(response.body);
    var product = item['data'];
    print(product);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in product) {
        cart.add(CartList.fromJson(index));
      }
      return cart;
    } else {
      return cart;
    }

  }

  Future<List<WatchList>> getWatchList() async {
    print('MyWatchlist');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    const url =ApiConstant.getWatchListApi;
    final header = {"Authorization": 'Bearer $jwtToken'};
    final response = await http.get(Uri.parse(url), headers: header);
    var item = jsonDecode(response.body);
    var product = item['data'];
    print(product);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in product) {
        watchList.add(WatchList.fromJson(index));
      }
      return watchList;
    } else {
      return watchList;
    }

  }
}
