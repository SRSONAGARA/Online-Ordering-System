import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ModelsBloc/PageModelsBloc/cartlist_model.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/cart_screen/cart_screen_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../common/ApiConstant.dart';

class CartScreenCubit extends Cubit<CartScreenState>{
  CartScreenCubit(): super(CartScreenInitialState());

  GetMyCart getMyCart = GetMyCart(status: 0, msg: '', data: [], cartTotal: 0.0);


  Future<void> getMyCartBloc() async {
    print('getMyCartBloc');
    emit(CartScreenLoadingState());
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      const url = ApiConstant.getMyCartApi;
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response = await http.get(Uri.parse(url), headers: header);

      if (response.statusCode == 200) {
        print('hello cart');
        emit(CartScreenSuccessState());
        getMyCart = GetMyCart.fromJson(jsonDecode(response.body));
        print(getMyCart);
        if(getMyCart.data!.isEmpty){
          emit(CartEmptyState());
        }
      } else if (response.statusCode == 500) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        emit(CartScreenErrorState());
        // await Get.offNamedUntil('/loginScreenGetx', (route) => false);
      }
    } catch (e) {
      print(e);
    }
  }
}