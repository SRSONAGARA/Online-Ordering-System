import 'package:get/get.dart';

import '../viewsGetx/app_pagesGetx/homeScreenGetx.dart';
class RouteClassGetx{
  static String homeGetx = "/";

  static String getHomeRouteGetx()=>homeGetx;

  static List<GetPage> routes=[
    GetPage(name: homeGetx, page:()=> const HomeScreenGetx(), transition: Transition.fade, transitionDuration: const Duration(seconds: 1))
  ];
}