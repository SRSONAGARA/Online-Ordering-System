import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/splashScreen/cubit/splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit(): super(SplashScreenState());

  void init(BuildContext context){
    opacityFunc(context);
  }

  void opacityFunc(BuildContext context)async{
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(opacity: !state.opacity));
  }

}