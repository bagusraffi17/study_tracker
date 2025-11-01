import 'package:flutter/material.dart';
import '../constants/app_strings.dart';

/// Reusable Title Text Field with Validation
class TitleTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const TitleTextField({
    super.key,
    required this.controller,
    this.errorText,
    this.onChanged,
  });

  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.fieldRequired;
    }
    if (value.trim().length < 3) {
      return AppStrings.titleTooShort;
    }
    if (value.trim().length > 100) {
      return AppStrings.titleTooLong;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: AppStrings.taskTitle,
        hintText: 'Enter task title',
        prefixIcon: const Icon(Icons.title),
        errorText: errorText,
        border: const OutlineInputBorder(),
      ),
      validator: validate,
      onChanged: onChanged,
      textCapitalization: TextCapitalization.sentences,
      maxLength: 100,
      buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
        return Text('$currentLength/$maxLength');
      },
    );
  }
}

