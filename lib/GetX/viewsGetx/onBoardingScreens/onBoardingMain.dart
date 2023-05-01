import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oline_ordering_system/GetX/routesGetx/RouteClassGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/homeScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/onBoardingScreens/onBoarding1.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/onBoardingScreens/onBoarding2.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/onBoardingScreens/onBoarding3.dart';
import 'package:oline_ordering_system/views/Home%20Screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingMain extends StatefulWidget {
  const OnBoardingMain({Key? key}) : super(key: key);

  @override
  State<OnBoardingMain> createState() => _OnBoardingMainState();
}

class _OnBoardingMainState extends State<OnBoardingMain> {
  PageController _controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: [OnBoarding1(), OnBoarding2(), OnBoarding3()],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    _controller.jumpToPage(2);
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.indigo),
                  )),
              SmoothPageIndicator(controller: _controller, count: 3),
              onLastPage
                  ? TextButton(
                      onPressed: () {
                        Get.offAllNamed('/loginScreenGetx');
                        // Get.offAllNamed(RouteClassGetx.getHomeRouteGetx());
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(color: Colors.indigo),
                      ))
                  : TextButton(
                      onPressed: () {
                        _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child: Row(
                        children: [
                          Text(
                            'Next',
                            style: TextStyle(color: Colors.indigo),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 13,
                            color: Colors.indigo,
                          )
                        ],
                      ))
            ],
          ),
        ));
  }
}
