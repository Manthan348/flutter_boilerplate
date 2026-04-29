import 'package:flutter/material.dart';
import 'package:starter_lib/src/bootstrap/app_bootstrap.dart';
import 'package:starter_lib/src/core/models/app_font_preset.dart';

Future<void> main() async {
  await AppBootstrap.initialize(
    baseUrl: 'https://api.example.com',
    defaultHeaders: <String, String>{'x-app': 'starter'},
  );
  runApp(
    AppBootstrap.app(
      title: 'My New App',
      themeMode: ThemeMode.system,
      fontPreset: AppFontPreset.poppins,
      supportedLocales: const <Locale>[Locale('en'), Locale('hi')],
    ),
  );
}
