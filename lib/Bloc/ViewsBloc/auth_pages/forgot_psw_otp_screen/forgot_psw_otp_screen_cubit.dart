import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/forgot_psw_otp_screen/forgot_psw_otp_screen_state.dart';
import 'package:http/http.dart' as http;
import '../../../../common/ApiConstant.dart';

class ForgotPswOtpScreenCubit extends Cubit<ForgotPswOtpScreenState>{
  ForgotPswOtpScreenCubit(): super(ForgotPswOtpScreenInitialState());

  Future<Map<String, dynamic>> verifyOtpOnForgotPasswordBloc(
      {required String userId, required String otp}) async {
    print(userId);
    print(otp);
    try {
      emit(ForgotPswOtpScreenLoadingState());
      String url = ApiConstant.verifyOtpOnForgotPasswordApi;
      var requestBody = {'userId': userId, 'otp': otp};
      print(url);
      print(requestBody);

      var response = await http.post(Uri.parse(url), body: requestBody);
      String responseBody = response.body;
      print(responseBody);
      print('response.statusCode: ${response.statusCode}');
      if(response.statusCode == 200){
        emit(ForgotPswOtpScreenSuccessState(userId, otp));
        final responseBody =response.body;

        print('responseBody:$responseBody');
        return jsonDecode(responseBody) as Map<String, dynamic>;

      }else if(response.statusCode == 400){
        emit(ForgotPswOtpScreenErrorState());
        return jsonDecode(responseBody) as Map<String, dynamic>;

      }
      return jsonDecode(responseBody) as Map<String, dynamic>;

    } catch (error) {
      print('AuthRepo.verifyOtpOnForgotPasswordBloc.error: $error');
      return {};
    }
  }

  Future<Map<String, dynamic>> resendOtpBloc({
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


}