import 'package:flutter/material.dart';
import '../../features/tasks/models/task_models.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';

/// Reusable Category Dropdown Widget
class CategoryDropdown extends StatelessWidget {
  final TaskCategory selectedCategory;
  final ValueChanged<TaskCategory>? onChanged;
  final String? errorText;

  const CategoryDropdown({
    super.key,
    required this.selectedCategory,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.category,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<TaskCategory>(
          value: selectedCategory,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.category),
            border: const OutlineInputBorder(),
            errorText: errorText,
          ),
          items: TaskCategory.values.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _getCategoryColor(category),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(_getCategoryLabel(category)),
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

  Color _getCategoryColor(TaskCategory category) {
    switch (category) {
      case TaskCategory.general:
        return AppColors.categoryGeneral;
      case TaskCategory.study:
        return AppColors.categoryStudy;
      case TaskCategory.assignment:
        return AppColors.categoryAssignment;
      case TaskCategory.exam:
        return AppColors.categoryExam;
      case TaskCategory.project:
        return AppColors.categoryProject;
      case TaskCategory.personal:
        return AppColors.categoryPersonal;
    }
  }

  String _getCategoryLabel(TaskCategory category) {
    switch (category) {
      case TaskCategory.general:
        return AppStrings.categoryGeneral;
      case TaskCategory.study:
        return AppStrings.categoryStudy;
      case TaskCategory.assignment:
        return AppStrings.categoryAssignment;
      case TaskCategory.exam:
        return AppStrings.categoryExam;
      case TaskCategory.project:
        return AppStrings.categoryProject;
      case TaskCategory.personal:
        return AppStrings.categoryPersonal;
    }
  }
}

