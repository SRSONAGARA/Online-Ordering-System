import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/login_screen/login_screen_state.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/ApiConstant.dart';
import '../../../ModelsBloc/AuthModelsBloc/login_model.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {

  LoginScreenCubit() : super(LoginScreenInitialState());

  bool isObscure = false;

  LoginModelClassBloc loginModelClassBloc = LoginModelClassBloc(
      status: 0,
      msg: '',
      data: LoginDataBloc(
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

  void togglePasswordVisibility(){
    isObscure = !isObscure;
    emit(PasswordVisibilityChangedState(isObscure));
  }

  Future<void> userLoginBloc({
    required String emailId,
    required String password,
  }) async {
    try {
      emit(LoginScreenLoadingState());

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
        loginModelClassBloc = LoginModelClassBloc.fromJson(responseBody);
        var status = responseBody['status'];
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('loginBool', status == 1);
        emit(LoginScreenSuccessState());
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwtToken', responseBody['data']['jwtToken']);
        await prefs.setString('name', responseBody['data']['name']);
        await prefs.setString('emailId', responseBody['data']['emailId']);
        await prefs.setString('mobileNo', responseBody['data']['mobileNo']);
        print('jwttoken: ${prefs.get('jwtToken')}');
        print('name: ${prefs.get('name')}');
        print('emailId: ${prefs.get('emailId')}');
        print('mobileNo: ${prefs.get('mobileNo')}');
      } else if (response.statusCode == 400) {
        emit(LoginScreenErrorState());
        final responseBody = jsonDecode(response.body);
        loginModelClassBloc = LoginModelClassBloc.fromJson(responseBody);
        print(responseBody);
      }
    } catch (error) {
      print('AuthRepo.userLoginBloc.error: $error');
    }
  }
}
