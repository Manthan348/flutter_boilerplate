import 'package:flutter/material.dart';
import 'package:starter_lib/src/core/models/dynamic_dropdown_option.dart';

class DynamicDropdownField<T> extends StatelessWidget {
  const DynamicDropdownField({
    super.key,
    required this.label,
    required this.options,
    this.value,
    this.hint,
    this.required = false,
    this.enabled = true,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.isExpanded = true,
  });

  final String label;
  final List<DynamicDropdownOption<T>> options;
  final T? value;
  final String? hint;
  final bool required;
  final bool enabled;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final Widget? prefixIcon;
  final bool isExpanded;

  String? Function(T?)? _validator() {
    if (!required && validator == null) {
      return null;
    }

    return (T? selected) {
      if (required && selected == null) {
        return '$label is required';
      }

      if (validator != null) {
        return validator!(selected);
      }

      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      isExpanded: isExpanded,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon,
      ),
      items: options
          .map(
            (DynamicDropdownOption<T> option) => DropdownMenuItem<T>(
              value: option.value,
              enabled: option.enabled,
              child: Text(option.label),
            ),
          )
          .toList(growable: false),
      onChanged: enabled ? onChanged : null,
      validator: _validator(),
    );
  }
}
