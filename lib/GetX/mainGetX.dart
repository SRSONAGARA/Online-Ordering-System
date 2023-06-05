import 'package:flutter/cupertino.dart';
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
import 'package:oline_ordering_system/GetX/viewsGetx/onBoardingScreens/onBoardingMain.dart';
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
      // Map<String, dynamic> localeMap = jsonDecode(localeString);
      setState(() {
        _locale = Locale(langCode);
        _isLoading = false;
      });
    }else{
      setState(() {
        _locale = Locale('en_US');
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    if(_isLoading){
      return CircularProgressIndicator();
    }else{
      return  GetMaterialApp(
        translations: LocaleString(),
        locale: _locale,
        debugShowCheckedModeBanner: false,
        // home: SplashScreenGetX(),
         initialRoute:'/splashScreenGetX',
         // home: OnBoardingMain(),
        //  home: LoginScreenGetx(),
        getPages: [
          GetPage(name: '/splashScreenGetX', page: ()=>SplashScreenGetX(),),
          GetPage(name: '/loginScreenGetx', page: ()=>LoginScreenGetx(),),
          GetPage(name: '/registrationScreenGetx', page: ()=>RegistrationScreenGetx(),),
          GetPage(name: '/otpScreenGetx', page: ()=>OtpScreenGetx(),),
          GetPage(name: '/forgotPswScreenGetx', page: ()=>ForgotPswScreenGetx(),),
          GetPage(name: '/forgotPswOtpScreenGetx', page: ()=>ForgotPswOtpScreenGetx(),),
          GetPage(name: '/changePswScreenGetx', page: ()=>ChangePswScreenGetx(),),
          GetPage(name: '/homeScreenGetx', page: ()=>HomeScreenGetx(),),
          GetPage(name: '/productScreenGetx', page: ()=>ProductScreenGetx(),),
          GetPage(name: '/productDetailScreenGetx', page: ()=>ProductDetailScreenGetx(),),
          GetPage(name: '/wishlistScreenGetx', page: ()=>WishlistScreenGetx(),),
          GetPage(name: '/cartScreenGetx', page: ()=>CartScreenGetx(),),
          GetPage(name: '/orderHistoryScreenGetx', page: ()=>OrderHistoryScreenGetx(),),
          GetPage(name: '/accountScreenGetx', page: ()=>AccountScreenGetx(),),

        ],
      );
    }
     }
}
