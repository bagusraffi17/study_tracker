import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../tasks/models/task_models.dart';
import '../../tasks/providers/task_provider.dart';

void runTaskListDebugTests(BuildContext context) {
  Future(() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (!context.mounted) return;
    final tasks = _getDebugTasks();
    try {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      if (taskProvider.tasks.isEmpty) {
        for (final t in tasks) {
          await taskProvider.addTask(t);
        }
      }
    } catch (_) {}
  });
}

List<TaskModel> _getDebugTasks() {
  final now = DateTime.now();
  return [
    TaskModel(
      id: '1',
      title: 'Complete Math Assignment',
      description: 'Finish calculus homework chapter 5',
      dueDate: now.add(const Duration(days: 2)),
      priority: TaskPriority.high,
      category: TaskCategory.assignment,
      isCompleted: false,
    ),
    TaskModel(
      id: '2',
      title: 'Read History Chapter 3',
      description: 'Read about World War II and make notes',
      dueDate: now.add(const Duration(days: 5)),
      priority: TaskPriority.medium,
      category: TaskCategory.study,
      isCompleted: false,
    ),
    TaskModel(
      id: '3',
      title: 'Physics Lab Report',
      description: 'Write lab report for pendulum experiment',
      dueDate: now.subtract(const Duration(days: 1)),
      priority: TaskPriority.high,
      category: TaskCategory.assignment,
      isCompleted: false,
    ),
    TaskModel(
      id: '4',
      title: 'English Essay Draft',
      description: 'First draft of argumentative essay',
      dueDate: now.add(const Duration(days: 7)),
      priority: TaskPriority.low,
      category: TaskCategory.project,
      isCompleted: false,
    ),
    TaskModel(
      id: '5',
      title: 'Chemistry Quiz Prep',
      description: 'Study organic chemistry for quiz',
      dueDate: now.subtract(const Duration(days: 3)),
      priority: TaskPriority.medium,
      category: TaskCategory.study,
      isCompleted: true,
    ),
    TaskModel(
      id: '6',
      title: 'Biology Presentation',
      description: 'Prepare slides for cell division topic',
      dueDate: now.add(const Duration(days: 3)),
      priority: TaskPriority.high,
      category: TaskCategory.project,
      isCompleted: false,
    ),
    TaskModel(
      id: '7',
      title: 'Review Linear Algebra',
      description: 'Study matrices and determinants',
      dueDate: now.add(const Duration(days: 1)),
      priority: TaskPriority.medium,
      category: TaskCategory.study,
      isCompleted: false,
    ),
    TaskModel(
      id: '8',
      title: 'Computer Science Lab',
      description: 'Implement binary search tree algorithm',
      dueDate: now.add(const Duration(days: 4)),
      priority: TaskPriority.high,
      category: TaskCategory.assignment,
      isCompleted: false,
    ),
    TaskModel(
      id: '9',
      title: 'Update Study Notes',
      description: 'Organize and review last week notes',
      dueDate: now.add(const Duration(days: 10)),
      priority: TaskPriority.low,
      category: TaskCategory.personal,
      isCompleted: false,
    ),
    TaskModel(
      id: '10',
      title: 'Literature Analysis',
      description: 'Analyze Shakespeare sonnets',
      dueDate: now.subtract(const Duration(days: 2)),
      priority: TaskPriority.medium,
      category: TaskCategory.assignment,
      isCompleted: true,
    ),
    TaskModel(
      id: '11',
      title: 'Economics Group Project',
      description: 'Research on market structures',
      dueDate: now.add(const Duration(days: 14)),
      priority: TaskPriority.medium,
      category: TaskCategory.project,
      isCompleted: false,
    ),
    TaskModel(
      id: '12',
      title: 'Study Spanish Vocabulary',
      description: 'Memorize 50 new words for quiz',
      dueDate: now.add(const Duration(hours: 18)),
      priority: TaskPriority.high,
      category: TaskCategory.study,
      isCompleted: false,
    ),
    TaskModel(
      id: '13',
      title: 'Statistics Homework',
      description: 'Complete probability exercises',
      dueDate: now.subtract(const Duration(days: 4)),
      priority: TaskPriority.high,
      category: TaskCategory.assignment,
      isCompleted: false,
    ),
    TaskModel(
      id: '14',
      title: 'Plan Weekly Schedule',
      description: 'Organize study time for next week',
      dueDate: now.add(const Duration(days: 6)),
      priority: TaskPriority.low,
      category: TaskCategory.personal,
      isCompleted: false,
    ),
    TaskModel(
      id: '15',
      title: 'Geography Field Work',
      description: 'Visit local ecosystem for research',
      dueDate: now.add(const Duration(days: 8)),
      priority: TaskPriority.medium,
      category: TaskCategory.project,
      isCompleted: false,
    ),
    TaskModel(
      id: '16',
      title: 'Python Programming Practice',
      description: 'Solve 10 coding challenges',
      dueDate: now.add(const Duration(days: 12)),
      priority: TaskPriority.low,
      category: TaskCategory.study,
      isCompleted: false,
    ),
    TaskModel(
      id: '17',
      title: 'Art History Essay',
      description: 'Write about Renaissance period',
      dueDate: now.subtract(const Duration(hours: 12)),
      priority: TaskPriority.high,
      category: TaskCategory.assignment,
      isCompleted: false,
    ),
    TaskModel(
      id: '18',
      title: 'Review Last Semester Notes',
      description: 'Prepare for comprehensive exam',
      dueDate: now.add(const Duration(days: 20)),
      priority: TaskPriority.low,
      category: TaskCategory.study,
      isCompleted: false,
    ),
    TaskModel(
      id: '19',
      title: 'Music Theory Assignment',
      description: 'Compose a short melody',
      dueDate: now.add(const Duration(days: 9)),
      priority: TaskPriority.medium,
      category: TaskCategory.assignment,
      isCompleted: true,
    ),
    TaskModel(
      id: '20',
      title: 'Organize Study Materials',
      description: 'File and label all documents',
      dueDate: now.add(const Duration(days: 15)),
      priority: TaskPriority.low,
      category: TaskCategory.personal,
      isCompleted: true,
    ),
  ];
}
