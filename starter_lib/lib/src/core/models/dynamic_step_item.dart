class DynamicStepItem {
  const DynamicStepItem({
    required this.title,
    this.subtitle,
    this.isOptional = false,
  });

  final String title;
  final String? subtitle;
  final bool isOptional;
}
