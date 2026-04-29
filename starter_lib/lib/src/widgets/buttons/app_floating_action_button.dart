import 'package:flutter/material.dart';
import 'package:starter_lib/src/core/constants/app_colors.dart';

class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
    this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.heroTag,
    this.isExtended = false,
    this.tooltip,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final String? label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Object? heroTag;
  final bool isExtended;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = backgroundColor ?? AppColors.primary;
    final Color fgColor = foregroundColor ?? AppColors.onPrimary;

    if (isExtended && label != null && label!.isNotEmpty) {
      return FloatingActionButton.extended(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label!),
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        heroTag: heroTag,
        tooltip: tooltip,
      );
    }

    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      heroTag: heroTag,
      tooltip: tooltip,
      child: Icon(icon),
    );
  }
}
