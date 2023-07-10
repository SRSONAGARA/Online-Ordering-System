import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/account_screen/account_screen.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/cart_screen/cart_screen.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/order_history_screen/order_history_screen.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/product_screen/product_screen.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/product_screen/product_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/wishlist_screen/wishlist_screen.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/forgot_psw_screen/forgot_psw_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/registration_otp_screen/registration_otp_screen.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/registration_screen/registration_screen.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/registration_screen/registration_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/splashScreen/splash_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/splashScreen/splash_screen.dart';

import '../../GetX/viewsGetx/app_pagesGetx/homeScreenGetx.dart';
import '../ViewsBloc/app_pages/home_screen/home_screen.dart';
import '../ViewsBloc/auth_pages/forgot_psw_otp_screen/forgot_psw_otp_screen.dart';
import '../ViewsBloc/auth_pages/forgot_psw_screen/forgot_psw_screen.dart';
import '../ViewsBloc/auth_pages/login_screen/login_screen_cubit.dart';
import '../ViewsBloc/auth_pages/login_screen/login_screen.dart';

class RoutesBloc {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/splashScreen":
        return MaterialPageRoute(
            builder: (context) => const SplashScreenBloc());
      case "/loginScreen":
        return MaterialPageRoute(builder: (context) => const LoginScreenBloc());
      case "/forgotPswScreen":
        return MaterialPageRoute(
            builder: (context) => const ForgotPswScreenBloc());
      case "/registrationScreen":
        return MaterialPageRoute(
            builder: (context) => const RegistrationScreenBloc());
      case "/homeScreen":
        return MaterialPageRoute(builder: (context) => const HomeScreenBloc());
      case "/productScreen":
        return MaterialPageRoute(
            builder: (context) => const ProductScreenBloc());
      case "/wishlistScreen":
        return MaterialPageRoute(
            builder: (context) => const WishlistScreenBloc());
      case "/cartScreen":
        return MaterialPageRoute(builder: (context) => const CartScreenBloc());
      case "/orderHistoryScreen":
        return MaterialPageRoute(
            builder: (context) => const OrderHistoryScreenBloc());
      case "/accountScreen":
        return MaterialPageRoute(
            builder: (context) => const AccountScreenBloc());
    }
  }
}
