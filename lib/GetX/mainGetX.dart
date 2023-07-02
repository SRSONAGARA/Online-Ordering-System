import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oline_ordering_system/GetX/locale.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/AccountScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/CartScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/OrderHistoryScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/ProductDetailScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/ProductScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/WishlistScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/homeScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/auth_pagesGetx/ChangePswScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/auth_pagesGetx/ForgotPswOtpScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/auth_pagesGetx/ForgotPswScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/auth_pagesGetx/LoginScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/auth_pagesGetx/OtpScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/auth_pagesGetx/RegistrationScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/splashScreenGetX.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GetApp extends StatefulWidget {
  const GetApp({Key? key}) : super(key: key);

  @override
  State<GetApp> createState() => _GetAppState();
}

class _GetAppState extends State<GetApp> {
  late Locale _locale;
  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocale();
  }

  getLocale()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString('lang_code');
    if (langCode != null) {
      setState(() {
        _locale = Locale(langCode);
        _isLoading = false;
      });
    }else{
      setState(() {
        _locale = const Locale('en_US');
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    if(_isLoading){
      return const CircularProgressIndicator();
    }else{
      return  GetMaterialApp(
        translations: LocaleString(),
        locale: _locale,
        debugShowCheckedModeBanner: false,
         initialRoute:'/splashScreenGetX',
        getPages: [
          GetPage(name: '/splashScreenGetX', page: ()=>const SplashScreenGetX(),),
          GetPage(name: '/loginScreenGetx', page: ()=>const LoginScreenGetx(),),
          GetPage(name: '/registrationScreenGetx', page: ()=>const RegistrationScreenGetx(),),
          GetPage(name: '/otpScreenGetx', page: ()=>const OtpScreenGetx(),),
          GetPage(name: '/forgotPswScreenGetx', page: ()=>const ForgotPswScreenGetx(),),
          GetPage(name: '/forgotPswOtpScreenGetx', page: ()=>const ForgotPswOtpScreenGetx(),),
          GetPage(name: '/changePswScreenGetx', page: ()=>const ChangePswScreenGetx(),),
          GetPage(name: '/homeScreenGetx', page: ()=>const HomeScreenGetx(),),
          GetPage(name: '/productScreenGetx', page: ()=>const ProductScreenGetx(),),
          GetPage(name: '/productDetailScreenGetx', page: ()=>const ProductDetailScreenGetx(),),
          GetPage(name: '/wishlistScreenGetx', page: ()=>const WishlistScreenGetx(),),
          GetPage(name: '/cartScreenGetx', page: ()=>const CartScreenGetx(),),
          GetPage(name: '/orderHistoryScreenGetx', page: ()=>const OrderHistoryScreenGetx(),),
          GetPage(name: '/accountScreenGetx', page: ()=>const AccountScreenGetx(),),
        ],
      );
    }
     }
}
