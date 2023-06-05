import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../common/ApiConstant.dart';
import '../../ModelsGetx/CartListModelClassGetx.dart';

class CartScreenGetxController extends GetxController {
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getMyCartGetx();
  }

  GetMyCartGetx cartGetx = GetMyCartGetx(status: 0, msg: '', data: [], cartTotal: 0.0);


  Future<void> getMyCartGetx() async {
    print('getMyCartGetx');
    try {
      isLoading(true);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      const url = ApiConstant.getMyCartApi;
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response = await http.get(Uri.parse(url), headers: header);

      if (response.statusCode == 200) {
        print('hello cart');
        cartGetx = GetMyCartGetx.fromJson(jsonDecode(response.body));
        print(cartGetx);
        update();
      } else if (response.statusCode == 500) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        await Get.offNamedUntil('/loginScreenGetx', (route) => false);
        update();
      }
    } catch (e) {
      print(e);
    }
    finally{
      isLoading(false);
    }
  }

  addToCartGetx(String productId) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      String url = ApiConstant.addToCartApi;
      var requestBody = {"productId": productId};
      print(url);
      print(requestBody);

      final header = {"Authorization": 'Bearer $jwtToken'};
      final response =
          await http.post(Uri.parse(url), headers: header, body: requestBody);

      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        print(responseBody);

        print('added to cart');
        update();
      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        update();
      }
    } catch (error) {
      print('CartScreenGetxController.addToCartGetx.error: $error');
    }
  }

  Future<void> decreaseProductQuantityGetx(String cartItemId) async {
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
        update();
      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        update();
      }
    } catch (error) {
      print('ApiConnection_Provider.decreaseProductQuantityGetx: $error');
    }
  }


  Future<void> increaseProductQuantityGetx(String cartItemId) async {
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
        update();

      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        update();
      }
    } catch (error) {
      print('ApiConnection_Provider.increaseProductQuantityGetx: $error');
    }
  }

  removeProductFromCartGetx(String cartItemId)async{
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
        update();
      }else{
        final responseBody=jsonDecode(response.body);
        print(responseBody);
        update();
      }
    }catch(error){
      print('ApiConnection_Provider.removeProductFromCartGetx.error: $error');
    }
  }


}
