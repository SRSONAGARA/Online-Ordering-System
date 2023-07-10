import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ModelsBloc/PageModelsBloc/wishlist_model.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/wishlist_screen/wishlist_screen_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../common/ApiConstant.dart';

class WishlistScreenCubit extends Cubit<WishlistScreenState>{
  WishlistScreenCubit(): super(WishlistScreenInitialState());

  GetWishList getWishList = GetWishList(status: 0, msg: '', data: []);

  Future<void> getWishListBloc()async{
    print('getWishListBloc');
    try{
      emit(WishlistScreenLoadingState());
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      const url = ApiConstant.getWatchListApi;
      final header = {"Authorization" : 'Bearer $jwtToken'};
      final response = await http.get(Uri.parse(url), headers: header);
      print(jsonDecode(response.body));
      if(response.statusCode == 200){
        print('hello favorite');
        emit(WishlistScreenSuccessState());
        getWishList = GetWishList.fromJson(jsonDecode(response.body));
        print(getWishList);
        if(getWishList.data!.isEmpty){
          emit(WishlistEmptyState());
        }
      }else if(response.statusCode == 500){
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        // await Get.offNamedUntil('/loginScreenGetx', (route) => false);
        emit(WishlistScreenErrorState());
      }
    }catch(e){
      print(e);
    }
  }
  Future<void> updateWishListBloc()async{
    print('getWishListBloc');
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      const url = ApiConstant.getWatchListApi;
      final header = {"Authorization" : 'Bearer $jwtToken'};
      final response = await http.get(Uri.parse(url), headers: header);
      print(jsonDecode(response.body));
      if(response.statusCode == 200){
        print('hello favorite');
        // emit(WishlistScreenSuccessState());
        getWishList = GetWishList.fromJson(jsonDecode(response.body));
        print(getWishList);
        if(getWishList.data!.isEmpty){
          emit(WishlistEmptyState());
        }
      }else if(response.statusCode == 500){
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        // await Get.offNamedUntil('/loginScreenGetx', (route) => false);
        emit(WishlistScreenErrorState());
      }
    }catch(e){
      print(e);
    }
  }

}