import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/home_screen/home_screen.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/login_screen/cubit/login_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/splashScreen/cubit/splash_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/splashScreen/cubit/splash_screen_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth_pages/login_screen/login_screen.dart';

class SplashScreenBloc extends StatefulWidget {
  const SplashScreenBloc({Key? key}) : super(key: key);

  @override
  State<SplashScreenBloc> createState() => _SplashScreenBlocState();
}

class _SplashScreenBlocState extends State<SplashScreenBloc> {
  bool? logInBool;
  late SplashScreenCubit _cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = SplashScreenCubit();
    _cubit.init(context);
    isLogIn();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  isLogIn() async {
    final preferences = await SharedPreferences.getInstance();
    logInBool = preferences.getBool('loginBool');
    print(preferences.getBool('loginBool'));
    await Future.delayed(const Duration(seconds: 2), () {
      if (logInBool != null && logInBool == true) {
         Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_)=>const HomeScreenBloc()));
        return;
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (_) => LoginScreenCubit(),
                child: const LoginScreenBloc(),
              )));
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashScreenCubit(),
      child: BlocBuilder<SplashScreenCubit, SplashScreenState>(
          bloc: _cubit,
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Container(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedOpacity(
                          opacity: state.opacity ? 1 : 0,
                          duration: const Duration(seconds: 2),
                          child: const Image(
                              image: AssetImage('assets/SplashImage.jpg')))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
