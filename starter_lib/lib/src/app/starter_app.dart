import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter_lib/src/core/models/app_font_preset.dart';
import 'package:starter_lib/src/routes/app_pages.dart';
import 'package:starter_lib/src/theme/app_theme.dart';

class StarterApp extends StatelessWidget {
  const StarterApp({
    super.key,
    required this.title,
    required this.initialRoute,
    this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.light,
    this.locale,
    this.fallbackLocale,
    this.supportedLocales = const <Locale>[Locale('en')],
    this.translations,
    this.debugShowCheckedModeBanner = false,
    this.getPages,
    this.unknownRoute,
    this.defaultTransition,
    this.transitionDuration,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.fontPreset = AppFontPreset.inter,
    this.customGoogleFontFamily,
  });

  final String title;
  final String initialRoute;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode themeMode;
  final Locale? locale;
  final Locale? fallbackLocale;
  final List<Locale> supportedLocales;
  final Translations? translations;
  final bool debugShowCheckedModeBanner;
  final List<GetPage<dynamic>>? getPages;
  final GetPage<dynamic>? unknownRoute;
  final Transition? defaultTransition;
  final Duration? transitionDuration;
  final List<NavigatorObserver> navigatorObservers;
  final AppFontPreset fontPreset;
  final String? customGoogleFontFamily;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      title: title,
      theme:
          theme ??
          AppTheme.light(
            fontPreset: fontPreset,
            customGoogleFontFamily: customGoogleFontFamily,
          ),
      darkTheme:
          darkTheme ??
          AppTheme.dark(
            fontPreset: fontPreset,
            customGoogleFontFamily: customGoogleFontFamily,
          ),
      themeMode: themeMode,
      locale: locale,
      fallbackLocale: fallbackLocale,
      supportedLocales: supportedLocales,
      translations: translations,
      initialRoute: initialRoute,
      getPages: getPages ?? AppPages.routes,
      unknownRoute: unknownRoute,
      defaultTransition: defaultTransition,
      transitionDuration: transitionDuration,
      navigatorObservers: navigatorObservers,
    );
  }
}
