import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/order_history_screen/order_history_screen_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../common/ApiConstant.dart';
import '../../../ModelsBloc/PageModelsBloc/order_history_model.dart';

class OrderHistoryScreenCubit extends Cubit<OrderScreenState>{
  OrderHistoryScreenCubit(): super(OrderScreenInitialState());
  GetOrderHistory getOrderHistory = GetOrderHistory(status: 0, msg: '', data: []);

  Future<void> getOrderHistoryBloc() async {
    print('getOrderHistoryBloc');
    emit(OrderScreenLoadingState());
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      const url = ApiConstant.getOrderHistoryApi;
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response = await http.get(Uri.parse(url), headers: header);

      if (response.statusCode == 200) {
        print('hello order');
        emit(OrderScreenSuccessState());
        getOrderHistory = GetOrderHistory.fromJson(jsonDecode(response.body));
        print(getOrderHistory);
      } else if (response.statusCode == 500) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        emit(OrderScreenErrorState());
        // await Get.offNamedUntil('/loginScreenGetx', (route) => false);
      }
    } catch (e) {
      print(e);
    }
  }

}