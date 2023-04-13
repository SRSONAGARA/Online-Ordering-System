import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oline_ordering_system/common/ApiConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  static Future<Map<String, dynamic>> userRegister({
    required String username,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      String url = ApiConstant.userRegisterApi;
      var requestBody = {
        'name': username,
        'mobileNo': phone,
        'emailId': email,
        'password': password,
      };

      print(url);
      print(requestBody);

      var response = await http.post(Uri.parse(url), body: requestBody);
      String responseBody = response.body;

      print(responseBody);
      return jsonDecode(responseBody) as Map<String, dynamic>;
    } catch (error) {
      print('AuthRepo.userRegister.error: $error');
      return {};
    }
  }

  static Future<Map<String, dynamic>> verifyOtpOnRegister({
    required String userId,
    required String otp,
  }) async {
    try {
      String url = ApiConstant.verifyOtpOnRegisterApi;
      var requestBody = {
        'userId': userId,
        'otp': otp,
      };

      print(otp);
      print(url);
      print(requestBody);

      var response = await http.post(Uri.parse(url), body: requestBody);
      String responseBody = response.body;

      print(responseBody);
      return jsonDecode(responseBody) as Map<String, dynamic>;
    } catch (error) {
      print('AuthRepo.verifyOtpOnRegister.error: $error');
      return {};
    }
  }

  static Future<Map<String, dynamic>> resendOtp({
    required String userId,
  }) async {
    try {
      var requestBody = {'userId': userId};
      var response = await http.post(Uri.parse(ApiConstant.resendOtpApi),
          body: requestBody);
      String responseBody = response.body;

      print(responseBody);
      return jsonDecode(responseBody) as Map<String, dynamic>;
    } catch (error) {
      print('AuthRepo.resendOtp.erroe:$error');
      return {};
    }
  }

  static Future<Map<String, dynamic>> userLogin({
    required String emailId,
    required String password,
  }) async {
    try {
      String url = ApiConstant.userLoginApi;
      var requestBody = {
        'emailId': emailId,
        'password': password,
      };
      print(url);
      print(requestBody);

      var response = await http.post(Uri.parse(url), body: requestBody);

      if (response.statusCode == 200) {
        // String responseBody=response.body;
        // print(responseBody);
        var responseBody = jsonDecode(response.body);
        var status = responseBody['status'];
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('loginBool', status == 1);

        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        return {};
      }
    } catch (error) {
      print('AuthRepo.userLogin.error: $error');
      return {};
    }
  }

  static Future<Map<String, dynamic>> forgotPassword(
      {required String emailId}) async {
    try {
      String url = ApiConstant.forgotPasswordApi;
      var requestBody = {'emailId': emailId};
      print(url);
      print(requestBody);

      var response = await http.post(Uri.parse(url), body: requestBody);
      String responseBody = response.body;
      print(responseBody);
      return jsonDecode(responseBody) as Map<String, dynamic>;
    } catch (error) {
      print('AuthRepo.forgotPassword.error: $error');
      return {};
    }
  }

  static Future<Map<String, dynamic>> verifyOtpOnForgotPassword(
      {required String userId, required String otp}) async {
    print(userId);
    print(otp);
    try {
      String url = ApiConstant.verifyOtpOnForgotPasswordApi;
      var requestBody = {'userId': userId.toString(), 'otp': otp.toString()};
      print(url);
      print(requestBody);

      var response = await http.post(Uri.parse(url), body: requestBody);
      String responseBody = response.body;
      print(responseBody);

      return jsonDecode(responseBody) as Map<String, dynamic>;
    } catch (error) {
      print('AuthRepo.verifyOtpOnForgotPassword.error: $error');
      return {};
    }
  }

  static Future<Map<String, dynamic>> changePassword(
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

  /* static Future<Map<String,dynamic>> getAllProduct({
    required String jwtToken
})async{
    try{
      String url=ApiConstant.getAllProductApi;
      var requestBody={
        'jwtToken':jwtToken
      };
      print(url);
      print(requestBody);
      
      var response=await http.get(Uri.parse(url),headers: requestBody);
      String responseBody= response.body;

      print(responseBody);
      return jsonDecode(responseBody) as Map<String,dynamic>;
    }catch(error){
      print('AuthRepo.getAllProduct.error: $error');
      return {};
    }
  }*/
}
