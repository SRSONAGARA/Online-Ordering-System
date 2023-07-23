import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/change_psw_screen/change_psw_screen_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../common/ApiConstant.dart';

class ChangePswScreenCubit extends Cubit<ChangePswScreenState> {
  ChangePswScreenCubit() : super(ChangePswScreenInitialState());

  Future<Map<String, dynamic>> changePasswordBloc(
      {required String newPass, required String confirmPass}) async {
    print('newPass: $newPass');
    emit(ChangePswScreenLoadingState());
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
      if (response.statusCode == 200) {
        emit(ChangePswScreenSuccessState());
        return jsonDecode(responseBody) as Map<String, dynamic>;
      } else if (response.statusCode == 400) {
        emit(ChangePswScreenErrorState());
        return {};
      }
      return {};
    } catch (error) {
      print('changePassword.error: $error');
      return {};
    }
  }
}
