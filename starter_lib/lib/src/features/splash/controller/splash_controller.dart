import 'package:get/get.dart';
import 'package:starter_lib/src/routes/app_routes.dart';

class SplashController extends GetxController {
  void continueToHome() {
    Get.offAllNamed(AppRoutes.home);
  }
}
