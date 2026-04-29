import 'dart:async';

import 'package:flutter/material.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    super.key,
    this.controller,
    this.initialValue,
    this.hintText = 'Search',
    this.autofocus = false,
    this.enabled = true,
    this.debounceDuration = const Duration(milliseconds: 350),
    this.onChanged,
    this.onDebouncedChanged,
    this.onSubmitted,
    this.leading,
    this.trailing,
  }) : assert(
         controller == null || initialValue == null,
         'Use either controller or initialValue, not both.',
       );

  final TextEditingController? controller;
  final String? initialValue;
  final String hintText;
  final bool autofocus;
  final bool enabled;
  final Duration debounceDuration;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onDebouncedChanged;
  final ValueChanged<String>? onSubmitted;
  final Widget? leading;
  final Widget? trailing;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late final TextEditingController _internalController;
  TextEditingController get _controller =>
      widget.controller ?? _internalController;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _internalController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _internalController.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    widget.onChanged?.call(value);

    if (widget.onDebouncedChanged == null) {
      return;
    }

    _debounceTimer?.cancel();
    _debounceTimer = Timer(widget.debounceDuration, () {
      widget.onDebouncedChanged?.call(value);
    });
  }

  void _clear() {
    _controller.clear();
    _onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      onChanged: _onChanged,
      onSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.leading ?? const Icon(Icons.search),
        suffixIcon:
            widget.trailing ??
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _controller,
              builder: (context, value, _) {
                if (value.text.isEmpty || !widget.enabled) {
                  return const SizedBox.shrink();
                }

                return IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: _clear,
                );
              },
            ),
      ),
      textInputAction: TextInputAction.search,
    );
  }
}
