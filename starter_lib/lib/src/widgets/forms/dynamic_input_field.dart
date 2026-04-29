import 'package:flutter/material.dart';
import 'package:starter_lib/src/core/models/dynamic_input_field_config.dart';
import 'package:starter_lib/src/widgets/inputs/app_text_field.dart';

class DynamicInputField extends StatelessWidget {
  const DynamicInputField({
    super.key,
    required this.config,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.validator,
  });

  final DynamicInputFieldConfig config;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;

  TextInputType _keyboardType() {
    switch (config.type) {
      case DynamicInputType.email:
        return TextInputType.emailAddress;
      case DynamicInputType.phone:
        return TextInputType.phone;
      case DynamicInputType.number:
        return const TextInputType.numberWithOptions(decimal: true);
      case DynamicInputType.multiline:
        return TextInputType.multiline;
      case DynamicInputType.password:
      case DynamicInputType.text:
        return TextInputType.text;
    }
  }

  bool _obscureText() {
    return config.type == DynamicInputType.password || config.obscureText;
  }

  int _maxLines() {
    if (config.type == DynamicInputType.multiline) {
      return config.maxLines > 1 ? config.maxLines : 4;
    }

    return 1;
  }

  String? Function(String?)? _validator() {
    if (!config.required && validator == null) {
      return null;
    }

    return (String? value) {
      if (config.required && (value == null || value.trim().isEmpty)) {
        return '${config.label} is required';
      }

      if (validator != null) {
        return validator!(value);
      }

      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      focusNode: focusNode,
      label: config.label,
      hint: config.hint,
      initialValue: config.initialValue,
      keyboardType: _keyboardType(),
      textInputAction: config.textInputAction,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      validator: _validator(),
      prefixIcon: config.prefixIcon,
      suffixIcon: config.suffixIcon,
      obscureText: _obscureText(),
      readOnly: config.readOnly,
      enabled: config.enabled,
      maxLines: _maxLines(),
      minLines: config.minLines,
      maxLength: config.maxLength,
      autofocus: config.autofocus,
    );
  }
}
