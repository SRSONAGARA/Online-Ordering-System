import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/product_screen/product_screen_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../common/ApiConstant.dart';
import '../../../ModelsBloc/PageModelsBloc/productlist_model.dart';

class ProductScreenCarouselCubit extends Cubit<int>{
  ProductScreenCarouselCubit(): super(0);

  void updateCarouselPage(int index){
    emit(index);
  }
}

class ProductListCubit extends Cubit<ProductScreenState>{
  ProductListCubit(): super(ProductScreenInitialState());
  List<bool> isLoadingList = [];
  ProductListBloc productDataListBloc = ProductListBloc(status: 0, msg: '', totalProduct: 0, data: []);

  Future<void> getDataBloc() async {
    emit(ProductScreenLoadingState());

    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      print('jwtToken:$jwtToken');
      const url = ApiConstant.getAllProductApi;
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response = await http.get(Uri.parse(url), headers: header);
      var responseBody =jsonDecode(response.body);
      print('responseBody: $responseBody');
      if (response.statusCode == 200) {
        print('hello product');
        emit(ProductScreenSuccessState());
        productDataListBloc = ProductListBloc.fromJson(jsonDecode(response.body));
        print(productDataListBloc);
        isLoadingList = List<bool>.filled(productDataListBloc.data.length, false);

      }else if (response.statusCode == 400) {
        final jsonData = json.decode(response.body);
        productDataListBloc = ProductListBloc.fromJson(jsonData);
        emit(ProductScreenErrorState());
      }  else if (response.statusCode == 500) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        emit(ProductScreenErrorState());
        // await Get.offNamedUntil('/loginScreenGetx', (route) => false);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateDataBloc() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      print('jwtToken:$jwtToken');
      const url = ApiConstant.getAllProductApi;
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response = await http.get(Uri.parse(url), headers: header);
      var responseBody =jsonDecode(response.body);
      print('responseBody: $responseBody');
      if (response.statusCode == 200) {
        print('hello product');
        emit(ProductScreenSuccessState());
        productDataListBloc = ProductListBloc.fromJson(jsonDecode(response.body));
        print(productDataListBloc);

      } else if (response.statusCode == 500) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        emit(ProductScreenErrorState());
        // await Get.offNamedUntil('/loginScreenGetx', (route) => false);
      }
    } catch (e) {
      print(e);
    }
  }

  addToWatchListBloc({required String productId, required int index}) async {
    // emit(ProductScreenWatchListBtnLoadingState(index));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    print('addToWatchListBloc Method');

    try {
      String url = ApiConstant.addToWatchListApi;
      var requestBody = {"productId": productId};

      print(url);
      print(requestBody);

      final header = {"Authorization": 'Bearer $jwtToken'};
      final response =
      await http.post(Uri.parse(url), headers: header, body: requestBody);

      if (response.statusCode == 200) {
        emit(ProductScreenWatchListBtnSuccessState());
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        await updateDataBloc();
        print('added to watchlist');

      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody);

      }
    } catch (error) {
      print('ApiConnection_Provider.addToWatchListBloc.error: $error');
    }
  }

  removeFromWatchListBloc({required String wathListItemId, required int index}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    print('removeFromWatchListBloc Method');

    try {
      String url = ApiConstant.removeFromWatchListApi;
      var requestBody = {"wathListItemId": wathListItemId};

      print(url);
      print(requestBody);

      final header = {"Authorization": 'Bearer $jwtToken'};
      final response =
      await http.post(Uri.parse(url), headers: header, body: requestBody);

      if (response.statusCode == 200) {
        emit(ProductScreenWatchListBtnSuccessState());
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        await updateDataBloc();


        print('remove from watchlist');

      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody);

      }
    } catch (error) {
      print('ApiConnection_Provider.removeFromWatchListBloc.error: $error');
    }
  }

  updateButtonState(int index) {
    isLoadingList[index] = true;
  }

  updateButtonDisableState(int index) {
    isLoadingList[index] = false;
  }

}