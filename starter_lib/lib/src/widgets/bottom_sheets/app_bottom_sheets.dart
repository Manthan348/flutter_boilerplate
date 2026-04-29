import 'package:flutter/material.dart';
import 'package:starter_lib/src/core/constants/app_colors.dart';
import 'package:starter_lib/src/core/constants/app_sizes.dart';
import 'package:starter_lib/src/widgets/buttons/app_primary_button.dart';

class AppBottomSheets {
  AppBottomSheets._();

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool enableDrag = true,
    bool showHandle = true,
    EdgeInsets? padding,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AppBottomSheetContainer(
          title: title,
          showHandle: showHandle,
          padding: padding,
          child: child,
        );
      },
    );
  }

  static Future<bool> showConfirmation(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDestructive = false,
  }) async {
    final bool? result = await show<bool>(
      context,
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: AppSizes.sectionSpacing),
          AppPrimaryButton(
            label: confirmText,
            onPressed: () => Navigator.of(context).pop(true),
            backgroundColor: isDestructive ? AppColors.danger : null,
          ),
          const SizedBox(height: AppSizes.itemSpacing),
          AppSecondaryButton(
            label: cancelText,
            onPressed: () => Navigator.of(context).pop(false),
            borderColor: isDestructive ? AppColors.danger : null,
            foregroundColor: isDestructive ? AppColors.danger : null,
          ),
        ],
      ),
    );

    return result ?? false;
  }
}

class AppBottomSheetContainer extends StatelessWidget {
  const AppBottomSheetContainer({
    super.key,
    required this.child,
    this.title,
    this.showHandle = true,
    this.padding,
  });

  final Widget child;
  final String? title;
  final bool showHandle;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets viewInsets = MediaQuery.of(context).viewInsets;

    return SafeArea(
      top: false,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding:
              (padding ??
                  const EdgeInsets.fromLTRB(
                    AppSizes.pagePadding,
                    12,
                    AppSizes.pagePadding,
                    AppSizes.pagePadding,
                  )) +
              EdgeInsets.only(bottom: viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showHandle)
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              if (showHandle) const SizedBox(height: 12),
              if (title != null) ...[
                Text(title!, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
              ],
              Flexible(
                fit: FlexFit.loose,
                child: SingleChildScrollView(child: child),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
