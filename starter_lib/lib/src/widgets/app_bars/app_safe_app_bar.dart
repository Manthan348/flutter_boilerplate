import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starter_lib/src/core/constants/app_colors.dart';

class AppSafeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppSafeAppBar({
    super.key,
    required this.title,
    this.centerTitle = false,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.systemOverlayStyle,
  });

  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final Color barColor = backgroundColor ?? AppColors.primary;
    final Color textColor = foregroundColor ?? AppColors.onPrimary;
    final Brightness iconBrightness =
        ThemeData.estimateBrightnessForColor(barColor) == Brightness.dark
        ? Brightness.light
        : Brightness.dark;

    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      actions: actions,
      leading: leading,
      elevation: elevation,
      surfaceTintColor: Colors.transparent,
      backgroundColor: barColor,
      foregroundColor: textColor,
      systemOverlayStyle:
          systemOverlayStyle ??
          SystemUiOverlayStyle(
            statusBarColor: barColor,
            statusBarIconBrightness: iconBrightness,
            statusBarBrightness:
                iconBrightness == Brightness.light
                    ? Brightness.dark
                    : Brightness.light,
          ),
    );
  }
}
