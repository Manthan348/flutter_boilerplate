import 'package:flutter/material.dart';

enum DynamicInputType { text, email, phone, number, password, multiline }

class DynamicInputFieldConfig {
  const DynamicInputFieldConfig({
    required this.id,
    required this.label,
    this.hint,
    this.type = DynamicInputType.text,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.required = false,
    this.initialValue,
  });

  final String id;
  final String label;
  final String? hint;
  final DynamicInputType type;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final bool autofocus;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool required;
  final String? initialValue;
}
