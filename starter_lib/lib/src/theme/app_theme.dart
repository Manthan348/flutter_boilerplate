import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_lib/src/core/constants/app_colors.dart';
import 'package:starter_lib/src/core/constants/app_sizes.dart';
import 'package:starter_lib/src/core/models/app_font_preset.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light({
    AppFontPreset fontPreset = AppFontPreset.inter,
    String? customGoogleFontFamily,
  }) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        surface: AppColors.surface,
      ),
      textTheme: _resolveTextTheme(
        Brightness.light,
        fontPreset: fontPreset,
        customGoogleFontFamily: customGoogleFontFamily,
      ),
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      cardColor: AppColors.surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: Color(0xFFE1F3EE),
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.danger),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          side: const BorderSide(color: AppColors.divider),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData dark({
    AppFontPreset fontPreset = AppFontPreset.inter,
    String? customGoogleFontFamily,
  }) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),
      textTheme: _resolveTextTheme(
        Brightness.dark,
        fontPreset: fontPreset,
        customGoogleFontFamily: customGoogleFontFamily,
      ),
      scaffoldBackgroundColor: const Color(0xFF0D1117),
      useMaterial3: true,
    );
  }

  static TextTheme _resolveTextTheme(
    Brightness brightness, {
    required AppFontPreset fontPreset,
    String? customGoogleFontFamily,
  }) {
    final TextTheme base = ThemeData(
      brightness: brightness,
      useMaterial3: true,
    ).textTheme;

    if (customGoogleFontFamily != null &&
        customGoogleFontFamily.trim().isNotEmpty) {
      return GoogleFonts.getTextTheme(customGoogleFontFamily.trim(), base);
    }

    switch (fontPreset) {
      case AppFontPreset.poppins:
        return GoogleFonts.poppinsTextTheme(base);
      case AppFontPreset.montserrat:
        return GoogleFonts.montserratTextTheme(base);
      case AppFontPreset.lato:
        return GoogleFonts.latoTextTheme(base);
      case AppFontPreset.nunito:
        return GoogleFonts.nunitoTextTheme(base);
      case AppFontPreset.dmSans:
        return GoogleFonts.dmSansTextTheme(base);
      case AppFontPreset.workSans:
        return GoogleFonts.workSansTextTheme(base);
      case AppFontPreset.rubik:
        return GoogleFonts.rubikTextTheme(base);
      case AppFontPreset.inter:
        return GoogleFonts.interTextTheme(base);
    }
  }
}
