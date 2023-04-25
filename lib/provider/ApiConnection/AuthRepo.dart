import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oline_ordering_system/common/ApiConstant.dart';
import 'package:oline_ordering_system/models/LoginModelClass.dart';
import 'package:oline_ordering_system/models/SignUpModelClass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo extends ChangeNotifier{
  List<SignupModelClass> _registerData = [];
  List<SignupModelClass> get registerData => _registerData;
  List<LoginModelClass> loginData = [];

  bool isLoading = false;

   Future<void> userRegister({
    required String username,
    required String email,
    required String phone,
    required String password,
  }) async {
    isLoading = true;
    notifyListeners();
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

      if(response.statusCode == 201){
        print('Hello my friend');
        final responseBody = json.decode(response.body);
        var signUpList = <SignupModelClass>[];
        signUpList = [
          SignupModelClass(
              status: responseBody['status'],
              msg: responseBody['msg'],
              data: SignUpData(
                id: responseBody['data']['_id'].toString(),
                name: responseBody['data']['name'].toString(),
                mobileNo: responseBody['data']['mobileNo'].toString(),
                emailId: responseBody['data']['emailId'],
                status: responseBody['data']['status'],
                createdAt: responseBody['data']['createdAt'].toString(),
                updatedAt: responseBody['data']['updatedAt'].toString(),
                v: responseBody['data']['__v'],
                jwtToken: responseBody['data']['jwtToken'].toString(),
                fcmToken: responseBody['data']['fcmToken'].toString(),
              ))
        ];
        _registerData = signUpList;

        // registerData = [SignupModelClass.fromJson(jsonDecode(response.body))];
        print(responseBody);
      }else if(response.statusCode == 400){
        print('object');
        final responseBody = jsonDecode(response.body);
        var signUpList1 = <SignupModelClass>[];
        signUpList1 = [
          SignupModelClass(
              status: responseBody['status'],
              msg: responseBody['msg'],
              data: SignUpData(
                id: '',
                name: '',
                mobileNo: '',
                emailId: '',
                status: 0,
                createdAt: '',
                updatedAt: '',
                v: 0,
                jwtToken: '',
                fcmToken: '',
              ))
        ];
        _registerData = signUpList1;

        /* var item = jsonDecode(response.body);
        List<SignupModelClass> product = item['status'];
        print('product: $product');*/
        // registerData = [SignupModelClass.fromJson(jsonDecode(response.body))];
        print(responseBody);
      }

    } catch (error) {
      print('AuthRepo.userRegister.error: $error');
    }
    // isLoading =false;
    notifyListeners();
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

  Future<void> userLogin({
    required String emailId,
    required String password,
  }) async {
    isLoading = true;
    notifyListeners();
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
       /* isLoading = true;
        notifyListeners();*/

        final responseBody = json.decode(response.body);
        loginData = [LoginModelClass.fromJson(jsonDecode(response.body))];
        // var responseBody = jsonDecode(response.body);
        var status = responseBody['status'];
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('loginBool', status == 1);

      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
      }
    } catch (error) {
      print('AuthRepo.userLogin.error: $error');
    }
    // isLoading =false;
    notifyListeners();
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
