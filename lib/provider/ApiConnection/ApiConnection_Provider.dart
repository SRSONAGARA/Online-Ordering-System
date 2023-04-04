import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:oline_ordering_system/common/ApiConstant.dart';
import 'package:oline_ordering_system/models/FavoriteListModelClass.dart';
import 'package:oline_ordering_system/models/CartListModelClass.dart';
import 'package:oline_ordering_system/models/ProductListModelClass.dart';
import 'package:oline_ordering_system/models/WatchListModelClass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiConnectionProvider extends ChangeNotifier {
 /* List<Data> data = [];
  List<FavData> watchList = [];
  List<CartData> cart=[];*/



  void addToWatchList(String productId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    print('addToWatchList Method');

    try {
      String url = ApiConstant.addToWatchListApi;
      var requestBody = {"productId": productId};

      print(url);
      print(requestBody);

      final header = {"Authorization": 'Bearer $jwtToken'};
      final response =
          await http.post(Uri.parse(url), headers: header, body: requestBody);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print(responseBody);

        print('added to watchlist');
      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
      }
    } catch (error) {
      print('ApiConnection_Provider.addToWatchList.error: $error');
    }
    notifyListeners();
  }

  void removeFromWatchList(String wathListItemId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    print('removeFromWatchList Method');

    try {
      String url = ApiConstant.removeFromWatchListApi;
      var requestBody = {"wathListItemId": wathListItemId};

      print(url);
      print(requestBody);

      final header = {"Authorization": 'Bearer $jwtToken'};
      final response =
      await http.post(Uri.parse(url), headers: header, body: requestBody);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print(responseBody);

        print('remove from watchlist');
      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
      }
    } catch (error) {
      print('ApiConnection_Provider.removeFromWatchList.error: $error');
    }
    notifyListeners();
  }



  void addToCart(String productId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';

    try {
      String url = ApiConstant.addToCartApi;
      var requestBody = {"productId": productId};
      print(url);
      print(requestBody);

      final header = {"Authorization": 'Bearer $jwtToken'};
      final response =
          await http.post(Uri.parse(url), headers: header, body: requestBody);
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print(responseBody);

        print('added to cart');
      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
      }
    } catch (error) {
      print('ApiConnection_Provider.addToCart.error: $error');
    }
    notifyListeners();
  }
  void removeProductFromCart(String cartItemId)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String jwtToken=preferences.getString('jwtToken')??'';
    try{
      String url=ApiConstant.removeProductFromCartApi;
      var requestBody={'cartItemId':cartItemId};
      print(url);
      print(requestBody);
      final header={"Authorization": 'Bearer $jwtToken'};
      final response=await http.post(Uri.parse(url),headers: header, body: requestBody);
      if(response.statusCode==200){
        final responseBody=jsonDecode(response.body);
        print(responseBody);
        print('remove Product From Cart.');
      }else{
        final responseBody=jsonDecode(response.body);
        print(responseBody);
      }
    }catch(error){
      print('ApiConnection_Provider.removeProductFromCart.error: $error');
    }
    notifyListeners();
  }
  void placeOrder(String cartId, String cartTotal)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String jwtToken=preferences.getString('jwtToken') ??'';
    try{
      String url= ApiConstant.placeOrderApi;
      var requestBody={
        "cartId": cartId,
        "cartTotal": cartTotal
      };
      print(url);
      print(requestBody);
      final header={"Authorization": 'Bearer $jwtToken'};
      final response= await http.post(Uri.parse(url), headers: header, body: requestBody);
      print(response);
      if(response.statusCode==200){
        final responseBody=jsonDecode(response.body);
        print(responseBody);
      }
    }catch(error){
      print('ApiConnection_Provider.placeOrder.error: $error');
    }
    notifyListeners();
  }
}
