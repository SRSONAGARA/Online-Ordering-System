import 'package:get/get.dart';
class BackButtonGetxController extends GetxController {
  DateTime? currentBackPressTime;

  Future<bool> onBackButtonPressed() async {
    if (currentBackPressTime == null ||
        DateTime.now().difference(currentBackPressTime!) > Duration(seconds: 2)) {
      // If it's the first press or the previous press was more than 2 seconds ago
      currentBackPressTime = DateTime.now();
      Get.snackbar(
        'Press again to exit',
        '',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
      return false;
    } else {
      // If the second press is within 2 seconds of the first press
      return true;
    }
  }
}