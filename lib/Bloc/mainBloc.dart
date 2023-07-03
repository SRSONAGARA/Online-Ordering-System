import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oline_ordering_system/Bloc/RoutesBloc/routes.dart';

class BlocApp extends StatelessWidget {
  const BlocApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesBloc.onGenerateRoute,
      initialRoute: '/splashScreen',
    );
  }
}
