import 'dart:convert';

import 'package:get/get.dart';
import 'package:oline_ordering_system/GetX/ModelsGetx/AuthModelClassGetx/LoginModelClassGetx.dart';
import 'package:http/http.dart' as http;
import 'package:oline_ordering_system/GetX/ModelsGetx/AuthModelClassGetx/RegistrationModelClassGetx.dart';
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
        loginModelClassGetx = LoginModelClassGetx.fromJson(responseBody);
        var status = responseBody['status'];
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('loginBool', status == 1);
        update();
      } else if (response.statusCode == 400) {
        // print('hello');
        final responseBody = jsonDecode(response.body);
        loginModelClassGetx = LoginModelClassGetx.fromJson(responseBody);
        print(responseBody);
        update();
      }
      isLoading(false);
    } catch (error) {
      print('AuthRepo.userLoginGetx.error: $error');
    }
    finally{
      isLoading(false);
    }
  }

  SignupModelClassGetx signupModelClassGetx = SignupModelClassGetx(
      status: 0,
      msg: '',
      data: SignUpDataGetx(
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

  Future<void> userRegisterGetx({
    required String username,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      isLoading(true);
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
        // print('Hello my friend');
        final responseBody = json.decode(response.body);
        /*var signUpList = <SignupModelClass>[];
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
        _registerData = signUpList;*/
        signupModelClassGetx = SignupModelClassGetx.fromJson(responseBody);
        // registerData = [SignupModelClass.fromJson(jsonDecode(response.body))];
        print(responseBody);
        update();

      }else if(response.statusCode == 400){
        print('object');
        final responseBody = jsonDecode(response.body);
       /* var signUpList1 = <SignupModelClass>[];
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
        _registerData = signUpList1;*/

        signupModelClassGetx = SignupModelClassGetx.fromJson(responseBody);
        print(responseBody);
        update();

      }
      isLoading(false);
    } catch (error) {
      print('AuthRepo.userRegisterGetx.error: $error');
    }finally{
      isLoading(false);
    }
  }

  Future<Map<String, dynamic>> verifyOtpOnRegisterGetx({
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
      print('AuthRepo.verifyOtpOnRegisterGetx.error: $error');
      return {};
    }
  }

  Future<Map<String, dynamic>> resendOtpGetx({
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
      print('AuthRepo.resendOtpGetx.error:$error');
      return {};
    }
  }

  Future<Map<String, dynamic>> forgotPasswordGetx(
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
      print('AuthRepo.forgotPasswordGetx.error: $error');
      return {};
    }
  }

  Future<Map<String, dynamic>> verifyOtpOnForgotPasswordGetx(
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
      print('AuthRepo.verifyOtpOnForgotPasswordGetx.error: $error');
      return {};
    }
  }
}
