import 'package:flutter/material.dart';
import 'package:starter_lib/src/core/constants/app_colors.dart';
import 'package:starter_lib/src/widgets/app_bars/app_safe_app_bar.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.safeAreaTopWhenNoAppBar = true,
    this.safeAreaBottom = true,
    this.padding,
    this.maxContentWidth,
    this.scrollable = false,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
    this.resizeToAvoidBottomInset,
    this.bottomSheet,
  });

  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool safeAreaTopWhenNoAppBar;
  final bool safeAreaBottom;
  final EdgeInsetsGeometry? padding;
  final double? maxContentWidth;
  final bool scrollable;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final bool? resizeToAvoidBottomInset;
  final Widget? bottomSheet;

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget? resolvedAppBar =
        appBar ??
        (title == null ? null : AppSafeAppBar(title: title!, actions: actions));

    Widget content = body;
    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    if (maxContentWidth != null) {
      content = Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxContentWidth!),
          child: content,
        ),
      );
    }

    if (scrollable) {
      content = SingleChildScrollView(
        keyboardDismissBehavior: keyboardDismissBehavior,
        child: content,
      );
    }

    final Widget resolvedBody = SafeArea(
      top: resolvedAppBar == null && safeAreaTopWhenNoAppBar,
      bottom: safeAreaBottom,
      child: content,
    );

    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.scaffoldBackground,
      appBar: resolvedAppBar,
      body: resolvedBody,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      bottomSheet: bottomSheet,
    );
  }
}
