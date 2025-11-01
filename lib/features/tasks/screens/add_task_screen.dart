import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart';
import '../models/task_models.dart';
import '../providers/task_provider.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/priority_dropdown.dart';
import '../../../core/widgets/category_dropdown.dart';
import '../../../core/widgets/date_picker_field.dart';
import '../../../core/widgets/title_text_field.dart';
import '../../../core/constants/app_colors.dart';

class AddTaskScreen extends StatefulWidget {
  final TaskModel? task;

  const AddTaskScreen({
    super.key,
    this.task,
  });

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late QuillController _quillController;
  DateTime? _selectedDate;
  TaskPriority _selectedPriority = TaskPriority.medium;
  TaskCategory _selectedCategory = TaskCategory.general;
  String? _titleError;
  String? _dateError;
  String? _descriptionError;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _quillController = QuillController.basic();

    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _selectedDate = widget.task!.dueDate;
      _selectedPriority = widget.task!.priority;
      _selectedCategory = widget.task!.category;

      // Initialize Quill document - must end with '\n'
      final description = widget.task!.description;
      _quillController.document = Document.fromJson([
        {'insert': description.isEmpty ? '\n' : description + '\n'}
      ]);
    } else {
      _selectedDate = DateTime.now().add(const Duration(days: 1));
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _quillController.dispose();
    super.dispose();
  }

  String? _validateTitle(String? value) {
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

  String? _validateDescription(String? description) {
    if (description == null || description.trim().isEmpty) {
      return null; // Description is optional
    }
    if (description.trim().length > 500) {
      return AppStrings.descriptionTooLong;
    }
    return null;
  }

  void _validateForm() {
    setState(() {
      _titleError = _validateTitle(_titleController.text);
      _dateError = _selectedDate == null ? AppStrings.dateRequired : null;

      // Validate description from QuillEditor or TextField
      var quillDescription = _quillController.document.toPlainText().trim();
      var textDescription = _descriptionController.text.trim();
      var finalDescription =
          quillDescription.isNotEmpty ? quillDescription : textDescription;
      _descriptionError = _validateDescription(finalDescription);
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      _dateError = null;
    });
  }

  Future<void> _handleSubmit() async {
    _validateForm();

    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _titleError == null &&
        _descriptionError == null) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        // Get description from QuillEditor (removes trailing newline automatically)
        var description = _quillController.document.toPlainText().trim();
        // Fallback to simple TextField if QuillEditor is empty
        if (description.isEmpty) {
          description = _descriptionController.text.trim();
        }

        // Final validation check
        if (description.length > 500) {
          setState(() {
            _descriptionError = AppStrings.descriptionTooLong;
          });
          return;
        }

        final taskProvider = Provider.of<TaskProvider>(context, listen: false);

        if (widget.task != null) {
          final updatedTask = widget.task!.copyWith(
            title: _titleController.text.trim(),
            description: description,
            dueDate: _selectedDate!,
            priority: _selectedPriority,
            category: _selectedCategory,
          );
          await taskProvider.updateTask(updatedTask);

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(AppStrings.taskUpdated),
                backgroundColor: Colors.green,
              ),
            );
          }
        } else {
          final newTask = TaskModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: _titleController.text.trim(),
            description: description,
            dueDate: _selectedDate!,
            priority: _selectedPriority,
            category: _selectedCategory,
            isCompleted: false,
          );
          await taskProvider.addTask(newTask);

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(AppStrings.taskCreated),
                backgroundColor: Colors.green,
              ),
            );
          }
        }

        if (mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${AppStrings.errorGeneric}: $e'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth > 600;
        final isTablet = constraints.maxWidth > 768;

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.task == null ? AppStrings.addTask : 'Edit Task'),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(isWideScreen ? 24.0 : 16.0),
            child: Form(
              key: _formKey,
              child: isWideScreen
                  ? _buildWideLayout(isTablet)
                  : _buildNarrowLayout(),
            ),
          ),
          bottomNavigationBar: _buildBottomBar(),
        );
      },
    );
  }

  Widget _buildNarrowLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTitleField(),
        const SizedBox(height: 16),
        _buildDatePicker(),
        const SizedBox(height: 16),
        _buildPriorityDropdown(),
        const SizedBox(height: 16),
        _buildCategoryDropdown(),
        const SizedBox(height: 16),
        _buildDescriptionField(),
      ],
    );
  }

  Widget _buildWideLayout(bool isTablet) {
    return Center(
      child: SizedBox(
        width: isTablet ? 700 : 600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitleField(),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildDatePicker(),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildPriorityDropdown(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildCategoryDropdown(),
            const SizedBox(height: 20),
            _buildDescriptionField(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TitleTextField(
      controller: _titleController,
      errorText: _titleError,
      onChanged: (_) {
        setState(() {
          _titleError = null;
        });
      },
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.taskDescription,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        if (_descriptionError != null) ...[
          Text(
            _descriptionError!,
            style: TextStyle(
              color: AppColors.error,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
        ],
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline),
            borderRadius: BorderRadius.circular(4),
          ),
          child: QuillEditor.basic(
            configurations: QuillEditorConfigurations(
              controller: _quillController,
              sharedConfigurations: const QuillSharedConfigurations(),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Theme.of(context).colorScheme.outline),
            ),
          ),
          child: QuillToolbar.simple(
            configurations: QuillSimpleToolbarConfigurations(
              controller: _quillController,
              sharedConfigurations: const QuillSharedConfigurations(),
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(
            labelText: 'Simple Description (optional)',
            hintText: 'Or type a simple description here',
            border: const OutlineInputBorder(),
          ),
          maxLines: 3,
          maxLength: 500,
          textCapitalization: TextCapitalization.sentences,
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return DatePickerField(
      selectedDate: _selectedDate,
      onDateSelected: _onDateSelected,
      errorText: _dateError,
    );
  }

  Widget _buildPriorityDropdown() {
    return PriorityDropdown(
      selectedPriority: _selectedPriority,
      onChanged: (priority) {
        setState(() {
          _selectedPriority = priority;
        });
      },
    );
  }

  Widget _buildCategoryDropdown() {
    return CategoryDropdown(
      selectedCategory: _selectedCategory,
      onChanged: (category) {
        setState(() {
          _selectedCategory = category;
        });
      },
    );
  }

  Widget _buildBottomBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed:
                    _isSubmitting ? null : () => Navigator.of(context).pop(),
                child: Text(AppStrings.cancel),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: FilledButton.icon(
                onPressed: _isSubmitting ? null : _handleSubmit,
                icon: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.check),
                label:
                    Text(_isSubmitting ? AppStrings.loading : AppStrings.save),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
