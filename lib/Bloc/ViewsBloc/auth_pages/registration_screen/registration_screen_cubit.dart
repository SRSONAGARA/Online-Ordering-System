import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/registration_screen/registration_screen_state.dart';
import 'package:http/http.dart' as http;
import '../../../../common/ApiConstant.dart';
import '../../../ModelsBloc/AuthModelsBloc/registration_model.dart';

class RegistrationScreenCubit extends Cubit<RegistrationScreenState>{
  RegistrationScreenCubit(): super(RegistrationScreenInitialState());
  bool isObscure = false;

  void togglePasswordVisibility(){
    isObscure= !isObscure;
    emit(PasswordVisibilityChangedState(isObscure));
  }

  SignupModelClassBloc signupModelClassBloc = SignupModelClassBloc(
      status: 0,
      msg: '',
      data: SignUpDataBloc(
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

  Future<void> userRegisterBloc({
    required String username,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      emit(RegistrationScreenLoadingState());
      // isLoading(true);
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
        final responseBody = jsonDecode(response.body);
        var result= responseBody;
        String userId = result['data']['_id'];
        signupModelClassBloc = SignupModelClassBloc.fromJson(responseBody);
        print(responseBody);
        emit(RegistrationScreenSuccessState(userId));

      }else if(response.statusCode == 400){
        emit(RegistrationScreenErrorState());
        final responseBody = jsonDecode(response.body);

        signupModelClassBloc = SignupModelClassBloc.fromJson(responseBody);
        print(responseBody);
      }
    } catch (error) {
      print('AuthRepo.userRegisterBloc.error: $error');
    }
  }
}