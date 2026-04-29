import 'package:flutter/material.dart';
import 'package:starter_lib/src/core/constants/app_colors.dart';
import 'package:starter_lib/src/core/models/dynamic_step_item.dart';

class DynamicStepBar extends StatelessWidget {
  const DynamicStepBar({
    super.key,
    required this.steps,
    required this.currentStep,
    this.activeColor = AppColors.primary,
    this.inactiveColor = AppColors.divider,
    this.completedColor = AppColors.success,
    this.showLabels = true,
  }) : assert(currentStep >= 0, 'currentStep cannot be negative');

  final List<DynamicStepItem> steps;
  final int currentStep;
  final Color activeColor;
  final Color inactiveColor;
  final Color completedColor;
  final bool showLabels;

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) {
      return const SizedBox.shrink();
    }

    final int safeStep = currentStep.clamp(0, steps.length - 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (int i = 0; i < steps.length; i++) ...[
              _StepDot(
                index: i,
                isCurrent: i == safeStep,
                isCompleted: i < safeStep,
                activeColor: activeColor,
                completedColor: completedColor,
                inactiveColor: inactiveColor,
              ),
              if (i < steps.length - 1)
                Expanded(
                  child: Container(
                    height: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: i < safeStep ? completedColor : inactiveColor,
                  ),
                ),
            ],
          ],
        ),
        if (showLabels) ...[
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < steps.length; i++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: i == steps.length - 1 ? 0 : 8),
                    child: _StepLabel(
                      step: steps[i],
                      isCurrent: i == safeStep,
                      isCompleted: i < safeStep,
                      activeColor: activeColor,
                      completedColor: completedColor,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _StepDot extends StatelessWidget {
  const _StepDot({
    required this.index,
    required this.isCurrent,
    required this.isCompleted,
    required this.activeColor,
    required this.completedColor,
    required this.inactiveColor,
  });

  final int index;
  final bool isCurrent;
  final bool isCompleted;
  final Color activeColor;
  final Color completedColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isCompleted
        ? completedColor
        : (isCurrent ? activeColor : inactiveColor);

    final bool showIndex = !isCompleted;

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: showIndex
          ? Text(
              '${index + 1}',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            )
          : const Icon(Icons.check, size: 14, color: Colors.white),
    );
  }
}

class _StepLabel extends StatelessWidget {
  const _StepLabel({
    required this.step,
    required this.isCurrent,
    required this.isCompleted,
    required this.activeColor,
    required this.completedColor,
  });

  final DynamicStepItem step;
  final bool isCurrent;
  final bool isCompleted;
  final Color activeColor;
  final Color completedColor;

  @override
  Widget build(BuildContext context) {
    final Color color = isCompleted
        ? completedColor
        : (isCurrent ? activeColor : Theme.of(context).hintColor);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          step.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: color,
            fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        if (step.subtitle != null)
          Text(
            step.subtitle!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall,
          ),
      ],
    );
  }
}
