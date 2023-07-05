import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/registration_otp_screen/registration_otp_screen_state.dart';
import 'package:http/http.dart' as http;
import '../../../../common/ApiConstant.dart';

class RegistrationOtpScreenCubit extends Cubit<RegistrationOtpScreenState>{
  RegistrationOtpScreenCubit(): super(RegistrationOtpScreenInitialState());

  Future<Map<String, dynamic>> verifyOtpOnRegisterBloc({
    required String userId,
    required String otp,
  }) async {
    try {
      emit(RegistrationOtpScreenLoadingState());
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
      if(response.statusCode == 200){
        emit(RegistrationOtpScreenSuccessState(userId, otp));
        return jsonDecode(responseBody) as Map<String, dynamic>;
      }else if(response.statusCode == 400){
        emit(RegistrationOtpScreenErrorState());
        return jsonDecode(responseBody) as Map<String, dynamic>;
      }
      return jsonDecode(responseBody) as Map<String, dynamic>;

    } catch (error) {
      print('AuthRepo.verifyOtpOnRegisterBloc.error: $error');
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
      print('AuthRepo.resendOtpBloc.error:$error');
      return {};
    }
  }
}