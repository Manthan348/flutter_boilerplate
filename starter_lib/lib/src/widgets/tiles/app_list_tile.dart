import 'package:flutter/material.dart';
import 'package:starter_lib/src/core/constants/app_colors.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.isDestructive = false,
    this.showTopBorder = false,
    this.showBottomBorder = true,
    this.contentPadding,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isDestructive;
  final bool showTopBorder;
  final bool showBottomBorder;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final Color? textColor = isDestructive ? AppColors.danger : null;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: showTopBorder
              ? const BorderSide(color: AppColors.divider)
              : BorderSide.none,
          bottom: showBottomBorder
              ? const BorderSide(color: AppColors.divider)
              : BorderSide.none,
        ),
      ),
      child: ListTile(
        contentPadding:
            contentPadding ?? const EdgeInsets.symmetric(horizontal: 4),
        leading: leading,
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: subtitle == null
            ? null
            : Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
        trailing:
            trailing ??
            Icon(
              Icons.chevron_right,
              color: isDestructive ? AppColors.danger : null,
            ),
        onTap: onTap,
      ),
    );
  }
}
