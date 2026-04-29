import 'package:get/get.dart';
import 'package:starter_lib/src/features/home/controller/home_controller.dart';
import 'package:starter_lib/src/features/shell/controller/app_shell_controller.dart';
import 'package:starter_lib/src/features/shell/presentation/app_shell_page.dart';
import 'package:starter_lib/src/features/splash/controller/splash_controller.dart';
import 'package:starter_lib/src/features/splash/presentation/splash_page.dart';
import 'package:starter_lib/src/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: AppRoutes.splash,
      page: SplashPage.new,
      binding: BindingsBuilder(() {
        Get.lazyPut<SplashController>(SplashController.new);
      }),
    ),
    GetPage(
      name: AppRoutes.home,
      page: AppShellPage.new,
      binding: BindingsBuilder(() {
        Get.lazyPut<AppShellController>(AppShellController.new);
        Get.lazyPut<HomeController>(HomeController.new);
      }),
    ),
  ];
}
