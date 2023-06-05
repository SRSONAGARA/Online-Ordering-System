import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../common/ApiConstant.dart';
import '../../ModelsGetx/ProductListModelClassGetx.dart';
import '../../ModelsGetx/WishlistModelClassGetx.dart';

class ProductScreenGetxController extends GetxController {
  RxBool isLoading = false.obs;
  // List<ProductListGetx> productDataListGetx = [];

  @override
  void onInit() {
    super.onInit();
    getDataGetx();
  }

  ProductListGetx productDataListGetx = ProductListGetx(status: 0, msg: '', totalProduct: 0, data: []); /* ProductListGetx(status: 0, msg: '', data: [], totalProduct: 0);*/


  Future<void> getDataGetx() async {
    print('getData MethodGetx');
    try {
      isLoading(true);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      const url = ApiConstant.getAllProductApi;
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response = await http.get(Uri.parse(url), headers: header);
      if (response.statusCode == 200) {
        print('hello product');
        productDataListGetx = ProductListGetx.fromJson(jsonDecode(response.body));
        print(productDataListGetx);
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

}
