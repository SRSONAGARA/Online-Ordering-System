import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../common/ApiConstant.dart';

class AccountScreenGetxController extends GetxController{

  void meth(){

  }
   Future<Map<String, dynamic>> changePasswordGetx(
      {required String newPass, required String confirmPass}) async {
    print('newPass: $newPass');
    try {
      String url = ApiConstant.changePasswordApi;
      var requestBody = {"newPass": newPass, "confirmPass": confirmPass};
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      final header = {"Authorization": 'Bearer $jwtToken'};
      print(url);
      print(requestBody);
      var response =
      await http.post(Uri.parse(url), body: requestBody, headers: header);
      String responseBody = response.body;
      print(responseBody);
      return jsonDecode(responseBody) as Map<String, dynamic>;
    } catch (error) {
      print('AuthRepo.changePassword.error: $error');
      return {};
    }
  }
}