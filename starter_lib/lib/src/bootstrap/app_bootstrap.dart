import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter_lib/src/app/starter_app.dart';
import 'package:starter_lib/src/core/models/app_font_preset.dart';
import 'package:starter_lib/src/routes/app_pages.dart';
import 'package:starter_lib/src/routes/app_routes.dart';
import 'package:starter_lib/src/services/local_storage_service.dart';
import 'package:starter_lib/src/services/network_service.dart';

class AppBootstrap {
  AppBootstrap._();

  static Future<void> initialize({
    String? baseUrl,
    bool setupLocalStorage = true,
    Duration connectTimeout = const Duration(seconds: 20),
    Duration receiveTimeout = const Duration(seconds: 20),
    Duration sendTimeout = const Duration(seconds: 20),
    Map<String, dynamic>? defaultHeaders,
    Iterable<Interceptor> networkInterceptors = const <Interceptor>[],
    Future<void> Function()? onInitialized,
    NetworkService? networkService,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();

    if (setupLocalStorage) {
      await LocalStorageService.initialize();
      Get.put(LocalStorageService.instance, permanent: true);
    }

    if (networkService != null) {
      Get.put(networkService, permanent: true);
    } else if (baseUrl != null && baseUrl.isNotEmpty) {
      Get.put(
        NetworkService(
          baseUrl: baseUrl,
          connectTimeout: connectTimeout,
          receiveTimeout: receiveTimeout,
          sendTimeout: sendTimeout,
          defaultHeaders: defaultHeaders,
          interceptors: networkInterceptors,
        ),
        permanent: true,
      );
    }

    await onInitialized?.call();
  }

  static Widget app({
    String title = 'Starter App',
    String initialRoute = AppRoutes.splash,
    bool debugShowCheckedModeBanner = false,
    ThemeData? theme,
    ThemeData? darkTheme,
    ThemeMode themeMode = ThemeMode.light,
    Locale? locale,
    Locale? fallbackLocale,
    List<Locale> supportedLocales = const <Locale>[Locale('en')],
    Translations? translations,
    List<GetPage<dynamic>>? getPages,
    GetPage<dynamic>? unknownRoute,
    Transition? defaultTransition,
    Duration? transitionDuration,
    List<NavigatorObserver> navigatorObservers = const <NavigatorObserver>[],
    AppFontPreset fontPreset = AppFontPreset.inter,
    String? customGoogleFontFamily,
  }) {
    return StarterApp(
      title: title,
      initialRoute: initialRoute,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      locale: locale,
      fallbackLocale: fallbackLocale,
      supportedLocales: supportedLocales,
      translations: translations,
      getPages: getPages ?? AppPages.routes,
      unknownRoute: unknownRoute,
      defaultTransition: defaultTransition,
      transitionDuration: transitionDuration,
      navigatorObservers: navigatorObservers,
      fontPreset: fontPreset,
      customGoogleFontFamily: customGoogleFontFamily,
    );
  }
}
