import 'package:flutter/material.dart';
import '../../features/tasks/models/task_models.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';

/// Reusable Category Chip Widget for displaying category badges
class CategoryChip extends StatelessWidget {
  final TaskCategory category;
  final bool compact;

  const CategoryChip({
    super.key,
    required this.category,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final (bgColor, textColor, label) = _getCategoryData();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(compact ? 10 : 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: compact ? 6 : 8,
            height: compact ? 6 : 8,
            decoration: BoxDecoration(
              color: textColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: compact ? 4 : 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: compact ? 11 : null,
                ),
          ),
        ],
      ),
    );
  }

  (Color bgColor, Color textColor, String label) _getCategoryData() {
    switch (category) {
      case TaskCategory.general:
        return (
          AppColors.categoryGeneralLight,
          AppColors.categoryGeneral,
          AppStrings.categoryGeneral
        );
      case TaskCategory.study:
        return (
          AppColors.categoryStudyLight,
          AppColors.categoryStudy,
          AppStrings.categoryStudy
        );
      case TaskCategory.assignment:
        return (
          AppColors.categoryAssignmentLight,
          AppColors.categoryAssignment,
          AppStrings.categoryAssignment
        );
      case TaskCategory.exam:
        return (
          AppColors.categoryExamLight,
          AppColors.categoryExam,
          AppStrings.categoryExam
        );
      case TaskCategory.project:
        return (
          AppColors.categoryProjectLight,
          AppColors.categoryProject,
          AppStrings.categoryProject
        );
      case TaskCategory.personal:
        return (
          AppColors.categoryPersonalLight,
          AppColors.categoryPersonal,
          AppStrings.categoryPersonal
        );
    }
  }
}

