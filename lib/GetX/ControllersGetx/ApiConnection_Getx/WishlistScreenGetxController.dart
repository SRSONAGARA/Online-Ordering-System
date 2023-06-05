import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../common/ApiConstant.dart';
import '../../ModelsGetx/WishlistModelClassGetx.dart';

class WishlistScreenGetxController extends GetxController {
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getWatchListGetx();
  }

  GetWatchListGetx watchListGetx = GetWatchListGetx(status: 0, msg: '', data: [],);

  Future<void> getWatchListGetx() async {
    print('MyWatchlistGetx');
    try {
      isLoading(true);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      const url = ApiConstant.getWatchListApi;
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response = await http.get(Uri.parse(url), headers: header);

      if (response.statusCode == 200) {
        print('hello favorite');
        watchListGetx = GetWatchListGetx.fromJson(jsonDecode(response.body));
        print(watchListGetx);
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

  addToWatchListGetx(String productId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    print('addToWatchListGetx Method');

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
        update();

      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        update();

      }
    } catch (error) {
      print('ApiConnection_Provider.addToWatchListGetx.error: $error');
    }
  }

  removeFromWatchListGetx(String wathListItemId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    print('removeFromWatchListGetx Method');

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
        update();

      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        update();

      }
    } catch (error) {
      print('ApiConnection_Provider.removeFromWatchListGetx.error: $error');
    }
  }
}