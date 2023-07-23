import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/product_screen/product_screen_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../common/ApiConstant.dart';
import '../../../ModelsBloc/PageModelsBloc/productlist_model.dart';

class ProductScreenCarouselCubit extends Cubit<int> {
  ProductScreenCarouselCubit() : super(0);

  void updateCarouselPage(int index) {
    emit(index);
  }
}

class ProductListCubit extends Cubit<ProductScreenState> {
  ProductListCubit() : super(ProductScreenInitialState());
  List<bool> isLoadingList = [];
  List<bool> isLoadingList1 = [];

  ProductListBloc productDataListBloc =
      ProductListBloc(status: 0, msg: '', totalProduct: 0, data: []);

  Future<void> getDataBloc() async {
    print('getDataBloc');
    emit(ProductScreenLoadingState());
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      print('jwtToken:$jwtToken');
      const url = ApiConstant.getAllProductApi;
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response = await http.get(Uri.parse(url), headers: header);
      if (response.statusCode == 200) {
        print('hello product');
        emit(ProductScreenSuccessState());
        productDataListBloc =
            ProductListBloc.fromJson(jsonDecode(response.body));
        print(productDataListBloc);
        isLoadingList =
            List<bool>.filled(productDataListBloc.data.length, false);
        isLoadingList1 =
            List<bool>.filled(productDataListBloc.data.length, false);
      } else if (response.statusCode == 400) {
        final jsonData = json.decode(response.body);
        productDataListBloc = ProductListBloc.fromJson(jsonData);
      } else if (response.statusCode == 500) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        emit(ProductScreenErrorState());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateDataBloc() async {
    print('updateDataBloc');
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      print('jwtToken:$jwtToken');
      const url = ApiConstant.getAllProductApi;
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response = await http.get(Uri.parse(url), headers: header);
      if (response.statusCode == 200) {
        print('hello product');
        productDataListBloc =
            ProductListBloc.fromJson(jsonDecode(response.body));
        print(productDataListBloc);
      } else if (response.statusCode == 500) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        emit(ProductScreenErrorState());
      }
    } catch (e) {
      print(e);
    }
  }

  addToWatchListBloc({required String productId}) async {
    emit(WatchListBtnLoadingState());
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
        await updateDataBloc();
        emit(WatchListBtnSuccessState());
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        print('added to watchlist');
      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
      }
    } catch (error) {
      print('ApiConnection_Provider.addToWatchListBloc.error: $error');
    }
  }

  removeFromWatchListBloc({required String wathListItemId}) async {
    emit(WatchListBtnLoadingState());
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
        await updateDataBloc();
        emit(WatchListBtnSuccessState());
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        print('remove from watchlist');
      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
      }
    } catch (error) {
      print('removeFromWatchListBloc.error: $error');
    }
  }

  addToCartBloc({required String productId, required int index}) async {
    emit(CartListBtnLoadingState());
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      String url = ApiConstant.addToCartApi;
      var requestBody = {"productId": productId};
      print(url);
      print(requestBody);

      final header = {"Authorization": 'Bearer $jwtToken'};
      final response =
          await http.post(Uri.parse(url), headers: header, body: requestBody);

      if (response.statusCode == 201) {
        await updateDataBloc();
        final responseBody = jsonDecode(response.body);
        emit(CartListBtnSuccessState());
        print(responseBody);
        print('added to cart');
      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
      }
    } catch (error) {
      print('addToCartBloc.error: $error');
    }
  }

  Future<void> decreaseProductQuantityBloc({required String cartItemId}) async {
    emit(CartListBtnLoadingState());
    print(cartItemId);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    print(jwtToken);
    try {
      String url = ApiConstant.decreaseProductQuantityApi;
      var requestBody = {"cartItemId": cartItemId};
      print(url);
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response =
          await http.post(Uri.parse(url), headers: header, body: requestBody);
      print(response.body);

      if (response.statusCode == 200) {
        await updateDataBloc();
        emit(CartListBtnSuccessState());
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        print('product Quantity decreased');
      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
      }
    } catch (error) {
      print('decreaseProductQuantityBloc: $error');
    }
  }

  Future<void> increaseProductQuantityBloc({required String cartItemId}) async {
    emit(CartListBtnLoadingState());
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    try {
      String url = ApiConstant.increaseProductQuantityApi;
      var requestBody = {"cartItemId": cartItemId};
      print(url);
      print(requestBody);
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response =
          await http.post(Uri.parse(url), headers: header, body: requestBody);
      if (response.statusCode == 200) {
        await updateDataBloc();
        emit(CartListBtnSuccessState());
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        print('product Quantity increased');
      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
      }
    } catch (error) {
      print('increaseProductQuantityBloc: $error');
    }
  }

  updateFavButtonState(int index) {
    isLoadingList[index] = true;
  }

  updateFavButtonDisableState(int index) {
    isLoadingList[index] = false;
  }

  updateCartButtonState(int index) {
    isLoadingList1[index] = true;
  }

  updateCartButtonDisableState(int index) {
    isLoadingList1[index] = false;
  }
}
