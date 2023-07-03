import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/forgot_psw_screen/forgot_psw_screen_state.dart';
import 'package:http/http.dart' as http;
import '../../../../common/ApiConstant.dart';

class ForgotPswScreenCubit extends Cubit<ForgotPswScreenState>{
  ForgotPswScreenCubit(): super(ForgotPswScreenInitialState());

  Future<Map<String, dynamic>> forgotPasswordBloc(
      {required String emailId}) async {
    try {
      emit(ForgotPswScreenLoadingState());
      String url = ApiConstant.forgotPasswordApi;
      var requestBody = {'emailId': emailId};
      print(url);
      print(requestBody);

      var response = await http.post(Uri.parse(url), body: requestBody);
      var responseBody = response.body;

      if(response.statusCode==200){
        final responseBody = response.body;
        var result= jsonDecode(responseBody);
        String userId = result['data']['_id'];
        print('userId main: $userId');
        emit(ForgotPswScreenSuccessState(userId));
      }else if(response.statusCode == 400){
        emit(ForgotPswScreenErrorState());
      }
      return jsonDecode(responseBody) as Map<String, dynamic>;
    } catch (error) {
      print('AuthRepo.forgotPasswordBloc.error: $error');
      return {};
    }
  }

}