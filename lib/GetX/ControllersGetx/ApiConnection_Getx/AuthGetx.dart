import 'dart:convert';

import 'package:get/get.dart';
import 'package:oline_ordering_system/GetX/ModelsGetx/LoginModelClassGetx.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/ApiConstant.dart';

class AuthGetxController extends GetxController {
  RxBool isLoading = false.obs;

  LoginModelClassGetx loginModelClassGetx = LoginModelClassGetx(
      status: 0,
      msg: '',
      data: LoginDataGetx(
          id: '',
          name: '',
          mobileNo: '',
          emailId: '',
          status: 0,
          jwtToken: '',
          fcmToken: '',
          createdAt: '',
          updatedAt: '',
          v: 0));

  // RxList<LoginModelClassGetx> loginDataGetx = <LoginModelClassGetx>[].obs;
  // RxBool isLoading = false.obs;

  Future<void> userLoginGetx({
    required String emailId,
    required String password,
  }) async {
    // isLoading.value = true;
    try {
      isLoading(true);

      String url = ApiConstant.userLoginApi;
      var requestBody = {
        'emailId': emailId,
        'password': password,
      };
      print(url);
      print(requestBody);

      var response = await http.post(Uri.parse(url), body: requestBody);

      var responseBody = jsonDecode(response.body);
      print(responseBody);
      if (response.statusCode == 200) {

        final responseBody = json.decode(response.body);
        loginModelClassGetx=LoginModelClassGetx.fromJson(responseBody);
        var status = responseBody['status'];
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('loginBool', status == 1);
        update();
      } else if (response.statusCode == 400) {
        print('hello');
        final responseBody = jsonDecode(response.body);
        loginModelClassGetx=LoginModelClassGetx.fromJson(responseBody);
        print(responseBody);
      }
      isLoading(false);

    } catch (error) {
      print('AuthRepo.userLogin.error: $error');
    }
    // isLoading =false;
  }
}
