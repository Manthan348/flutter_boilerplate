class DynamicDropdownOption<T> {
  const DynamicDropdownOption({
    required this.label,
    required this.value,
    this.enabled = true,
  });

  final String label;
  final T value;
  final bool enabled;
}
