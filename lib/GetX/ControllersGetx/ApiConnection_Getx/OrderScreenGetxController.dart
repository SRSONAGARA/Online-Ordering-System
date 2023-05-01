import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../common/ApiConstant.dart';
import '../../ModelsGetx/ConfirmOrderModelClassGetx.dart';

class OrderScreenGetxController extends GetxController {
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getOrderHistoryGetx();
  }

  ConfirmOrderListGetx confirmOrderListGetx = ConfirmOrderListGetx(status: 0, msg: '', data: []);

  Future<void> getOrderHistoryGetx() async {
    print('getOrderHistoryGetx');
    try {
      isLoading(true);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      const url = ApiConstant.getOrderHistoryApi;
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response = await http.get(Uri.parse(url), headers: header);

      if (response.statusCode == 200) {
        print('hello order');
        confirmOrderListGetx = ConfirmOrderListGetx.fromJson(jsonDecode(response.body));
        print(confirmOrderListGetx);
        update();
      } else if (response.statusCode == 500) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
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
