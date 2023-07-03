import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/forgot_psw_screen/forgot_psw_screen_cubit.dart';
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
            builder: (context) => BlocProvider(
                  create: (context) => SplashScreenCubit(),
                  child: const SplashScreenBloc(),
                ));
      case "/loginScreen":
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => LoginScreenCubit(),
                  child: const LoginScreenBloc(),
                ));
      case "/forgotPswScreen":
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ForgotPswScreenCubit(),
                  child: const ForgotPswScreenBloc(),
                ));
      /*case "/forgotPswOtpScreen":
        final argument = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
            builder: (context) =>  ForgotPswOtpScreenBloc());*/
      case "/homeScreen":
        return MaterialPageRoute(builder: (context) => const HomeScreenGetx());
    }
  }
}
