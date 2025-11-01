import 'package:flutter/material.dart';
import '../../features/tasks/models/task_models.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';

/// Reusable Priority Indicator Widget
/// Can be used as a simple dot indicator or as a badge
class PriorityIndicator extends StatelessWidget {
  final TaskPriority priority;
  final bool showLabel;
  final bool compact;

  const PriorityIndicator({
    super.key,
    required this.priority,
    this.showLabel = false,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final (color, label) = _getPriorityData();

    if (showLabel) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 8 : 10,
          vertical: compact ? 4 : 6,
        ),
        decoration: BoxDecoration(
          color: _getPriorityLightColor(priority),
          borderRadius: BorderRadius.circular(compact ? 10 : 12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: compact ? 6 : 8,
              height: compact ? 6 : 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: compact ? 4 : 6),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: compact ? 11 : null,
                  ),
            ),
          ],
        ),
      );
    }

    // Simple dot indicator
    return Container(
      width: compact ? 10 : 12,
      height: compact ? 10 : 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  (Color color, String label) _getPriorityData() {
    switch (priority) {
      case TaskPriority.high:
        return (AppColors.priorityHigh, AppStrings.priorityHigh);
      case TaskPriority.medium:
        return (AppColors.priorityMedium, AppStrings.priorityMedium);
      case TaskPriority.low:
        return (AppColors.priorityLow, AppStrings.priorityLow);
    }
  }

  Color _getPriorityLightColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return AppColors.priorityHighLight;
      case TaskPriority.medium:
        return AppColors.priorityMediumLight;
      case TaskPriority.low:
        return AppColors.priorityLowLight;
    }
  }
}

