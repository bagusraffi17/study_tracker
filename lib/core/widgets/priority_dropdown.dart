import 'package:flutter/material.dart';
import '../../features/tasks/models/task_models.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';

/// Reusable Priority Dropdown Widget
class PriorityDropdown extends StatelessWidget {
  final TaskPriority selectedPriority;
  final ValueChanged<TaskPriority>? onChanged;

  const PriorityDropdown({
    super.key,
    required this.selectedPriority,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.priority,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<TaskPriority>(
          value: selectedPriority,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.flag),
            border: OutlineInputBorder(),
          ),
          items: TaskPriority.values.map((priority) {
            return DropdownMenuItem(
              value: priority,
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _getPriorityColor(priority),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(_getPriorityLabel(priority)),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null && onChanged != null) {
              onChanged!(value);
            }
          },
        ),
      ],
    );
  }

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return AppColors.priorityHigh;
      case TaskPriority.medium:
        return AppColors.priorityMedium;
      case TaskPriority.low:
        return AppColors.priorityLow;
    }
  }

  String _getPriorityLabel(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return AppStrings.priorityHigh;
      case TaskPriority.medium:
        return AppStrings.priorityMedium;
      case TaskPriority.low:
        return AppStrings.priorityLow;
    }
  }
}

