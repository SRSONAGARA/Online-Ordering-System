import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/RoutesBloc/routes.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/order_history_screen/order_history_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/product_screen/search_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/wishlist_screen/wishlist_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/change_psw_screen/change_psw_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/forgot_psw_otp_screen/forgot_psw_otp_screen_cubit.dart';
import 'package:oline_ordering_system/views/AuthViews/ForgotPasswordOtpScreen.dart';
import 'package:provider/provider.dart';

import 'ViewsBloc/app_pages/cart_screen/cart_screen_cubit.dart';
import 'ViewsBloc/app_pages/product_screen/product_screen_cubit.dart';
import 'ViewsBloc/auth_pages/forgot_psw_screen/forgot_psw_screen_cubit.dart';
import 'ViewsBloc/auth_pages/login_screen/login_screen_cubit.dart';
import 'ViewsBloc/auth_pages/registration_otp_screen/registration_otp_screen_cubit.dart';
import 'ViewsBloc/auth_pages/registration_screen/registration_screen_cubit.dart';
import 'ViewsBloc/splashScreen/splash_screen_cubit.dart';

class BlocApp extends StatelessWidget {
  const BlocApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          BlocProvider(create: (_) => SplashScreenCubit()),
          BlocProvider(create: (_) => LoginScreenCubit()),
          BlocProvider(create: (_) => ForgotPswScreenCubit()),
          BlocProvider(create: (_) => ForgotPswOtpScreenCubit()),
          BlocProvider(create: (_) => RegistrationScreenCubit()),
          BlocProvider(create: (_) => RegistrationOtpScreenCubit()),
          BlocProvider(create: (_) => ProductScreenCarouselCubit()),
          BlocProvider(create: (_) => ProductListCubit()),
          BlocProvider(create: (_) => SearchCubit()),
          BlocProvider(create: (_) => WishlistScreenCubit()),
          BlocProvider(create: (_) => CartScreenCubit()),
          BlocProvider(create: (_) => OrderHistoryScreenCubit()),
          BlocProvider(create: (_) => ChangePswScreenCubit()),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RoutesBloc.onGenerateRoute,
          initialRoute: '/splashScreen',
        ));
  }
}
