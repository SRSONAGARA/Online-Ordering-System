import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:oline_ordering_system/Bloc/ModelsBloc/PageModelsBloc/cartlist_model.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/cart_screen/cart_screen_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../common/ApiConstant.dart';

class CartScreenCubit extends Cubit<CartScreenState>{
  CartScreenCubit(): super(CartScreenInitialState());
  List<bool> isLoadingCartList = [];

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
        emit(CartScreenSuccessState());
        getMyCart = GetMyCart.fromJson(jsonDecode(response.body));
        print(getMyCart);
        isLoadingCartList = List<bool>.filled(getMyCart.data!.length, false);

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

  Future<void> updateMyCartBloc() async {
    print('updateMyCartBloc');
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken') ?? '';
      const url = ApiConstant.getMyCartApi;
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response = await http.get(Uri.parse(url), headers: header);

      if (response.statusCode == 200) {
        print('hello cart1');
        emit(CartScreenSuccessState());
        getMyCart = GetMyCart.fromJson(jsonDecode(response.body));
        print(getMyCart);
        /*if(getMyCart.data!.isEmpty){
          emit(CartEmptyState());
          // await getMyCartBloc();
        }*/
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

  removeProductFromCartBloc({required String cartItemId})async{
    print('removeProductFromCartBloc');
    emit(CartBtnInCartScreenLoadingState());
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String jwtToken=preferences.getString('jwtToken')??'';
    try{
      String url=ApiConstant.removeProductFromCartApi;
      var requestBody={'cartItemId':cartItemId};
      print(url);
      print(requestBody);
      final header={"Authorization": 'Bearer $jwtToken'};
      final response=await http.post(Uri.parse(url),headers: header, body: requestBody);
      if(response.statusCode==200){
        print('status: 200');
        await updateMyCartBloc();
        emit(CartBtnInCartScreenSuccessState());
        final responseBody=jsonDecode(response.body);
        print(responseBody);
        print('remove Product From Cart.');
      }else{
        final responseBody=jsonDecode(response.body);
        print(responseBody);
      }
    }catch(error){
      print('removeProductFromCartBloc.error: $error');
    }
  }

  Future<void> decreaseProductQuantityBloc({required String cartItemId}) async {
    emit(CartBtnInCartScreenLoadingState());
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
        await updateMyCartBloc();
        emit(CartBtnInCartScreenSuccessState());
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
    emit(CartBtnInCartScreenLoadingState());
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
        await updateMyCartBloc();
        emit(CartBtnInCartScreenSuccessState());
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

  placeOrderBloc(String cartId, String cartTotal)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String jwtToken=preferences.getString('jwtToken') ??'';
    try{
      String url= ApiConstant.placeOrderApi;
      var requestBody={
        "cartId": cartId,
        "cartTotal": cartTotal
      };
      print(url);
      print(requestBody);
      final header={"Authorization": 'Bearer $jwtToken'};
      final response= await http.post(Uri.parse(url), headers: header, body: requestBody);
      print(response);
      if(response.statusCode==200){
        final responseBody=jsonDecode(response.body);
        print(responseBody);
      }
    }catch(error){
      print('placeOrderBloc.error: $error');
    }
  }

  Future<void> sendPushNotification(String title, String msg) async {
    final prefs = await SharedPreferences.getInstance();
    String? fcmToken = prefs.getString('fcmToken');
    try {
      final body = {
        "to": fcmToken,
        "notification": {
          "title": title, //our name should be send
          "body": msg,
          "android_channel_id": "OnlineOrderingsystem"
        },
      };

      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
            'key=AAAAXT-OWaI:APA91bEtaOlPAd2eJjBah2IQ1qo7b-QOieJ42PSof1dNE4a4PH4i-9KnLYPs7vRMA2M6HkqWavHQiVZ-_tkjbqhmAHofCyHEsP88aNSUqHnlyVTGPSe02RFSSC5sIIa23dNN5D324PKG'
          },
          body: jsonEncode(body));
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
      await getMyCartBloc();
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }


  updateCartButtonState(int index) {
    isLoadingCartList[index] = true;
  }

  updateCartButtonDisableState(int index) {
    isLoadingCartList[index] = false;
  }

}