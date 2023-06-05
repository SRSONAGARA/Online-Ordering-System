import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:oline_ordering_system/common/ApiConstant.dart';
import 'package:oline_ordering_system/models/CartListModelClass.dart';
import 'package:oline_ordering_system/models/ProductListModelClass.dart';
import 'package:oline_ordering_system/models/WatchListModelClass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../models/ConfirmOrderModelClass.dart';

class ApiConnectionProvider extends ChangeNotifier {
  List<ProductList> productDataList = [];
  List<GetMyCart> cart = [];
  List<GetWatchList> watchList = [];
  List<ConfirmOrderList> confirmOrderList=[];
  bool isLoading = false;


  bool showItemBool=false;

  void showItem(){
    showItemBool=true;
  }

  Future<void> getData(BuildContext context) async {
    print('getData Method');
    try{
      isLoading = true;
      // notifyListeners();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      const url = ApiConstant.getAllProductApi;
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response = await http.get(Uri.parse(url), headers: header);

      if (response.statusCode == 200) {

        var item = jsonDecode(response.body);
        var product = item['data'];
        print(product);
        productDataList = [ProductList.fromJson(jsonDecode(response.body))];
        print(productDataList);
      }else if (response.statusCode == 500){
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        await Navigator.of(context).pushNamedAndRemoveUntil('/login-screen', (route) => false);
      }
      isLoading=false;
      notifyListeners();
    }
    catch(e){
      print(e);
    }
  }

   addToWatchList(String productId) async {
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

  removeFromWatchList(String wathListItemId) async {
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


  Future<void> getWatchList(BuildContext context) async {
    print('MyWatchlist');
    try{
      isLoading = true;
      // notifyListeners();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      const url = ApiConstant.getWatchListApi;
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response = await http.get(Uri.parse(url), headers: header);


      if (response.statusCode == 200) {
        var item = jsonDecode(response.body);
        var product = item['data'];
        print(product);
        watchList = [GetWatchList.fromJson(jsonDecode(response.body))];
        print(watchList);
      }else if (response.statusCode == 500){
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        await Navigator.of(context).pushNamedAndRemoveUntil('/login-screen', (route) => false);
      }
      isLoading=false;
      notifyListeners();
    }catch(e){
      print(e);
    }
  }


   addToCart(String productId) async {
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

  Future<void> decreaseProductQuantity(String cartItemId) async {
    print(cartItemId);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    print(jwtToken);
    try {
      String url = ApiConstant.decreaseProductQuantityApi;
      var requestBody = {"cartItemId": cartItemId};
      print(url);
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response =
      await http.post(Uri.parse(url), headers: header, body: requestBody);
      print(response.body);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        print('product Quantity decreased');
      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
      }
    } catch (error) {
      print('ApiConnection_Provider.decreaseProductQuantity: $error');
    }
    notifyListeners();
  }

  Future<void> increaseProductQuantity(String cartItemId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    try {
      String url = ApiConstant.increaseProductQuantityApi;
      var requestBody = {"cartItemId": cartItemId};
      print(url);
      print(requestBody);
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response =
      await http.post(Uri.parse(url), headers: header, body: requestBody);
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        print('product Quantity increased');
      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
      }
    } catch (error) {
      print('ApiConnection_Provider.increaseProductQuantity: $error');
    }
    notifyListeners();
  }

   removeProductFromCart(String cartItemId)async{
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

  Future<void> getMyCart(BuildContext context) async {
    print('getMyCart');
   try{
     isLoading = true;
     // notifyListeners();
     SharedPreferences preferences = await SharedPreferences.getInstance();
     String jwtToken = preferences.getString('jwtToken') ?? '';
     const url = ApiConstant.getMyCartApi;
     final header = {"Authorization": 'Bearer $jwtToken'};
     final response = await http.get(Uri.parse(url), headers: header);


     if (response.statusCode == 200) {
       var item = jsonDecode(response.body);
       var product = item['data'];
       print(product);
       cart = [GetMyCart.fromJson(jsonDecode(response.body))];
       print(cart);
     }else if (response.statusCode == 500){
       SharedPreferences preferences = await SharedPreferences.getInstance();
       preferences.clear();
       await Navigator.of(context).pushNamedAndRemoveUntil('/login-screen', (route) => false);
     }
     isLoading=false;
     notifyListeners();
   }catch(e){
     print(e);
   }
  }

  placeOrder(String cartId, String cartTotal)async{
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


  Future<void> getOrderHistory(BuildContext context)async{
    print('getOrderHistory');
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      const url = ApiConstant.getOrderHistoryApi;
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response = await http.get(Uri.parse(url), headers: header);

      if (response.statusCode == 200) {
        confirmOrderList = [ConfirmOrderList.fromJson(jsonDecode(response.body))];
        print(confirmOrderList);
      }else if (response.statusCode == 500){
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        await Navigator.of(context).pushNamedAndRemoveUntil('/login-screen', (route) => false);
      }
      notifyListeners();
    }catch(e){
      print(e);
    }
  }
}
