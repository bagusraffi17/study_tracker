import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_models.dart';
import '../../../core/constants/app_strings.dart';

/// TaskProvider manages task state with CRUD operations using SharedPreferences
class TaskProvider extends ChangeNotifier {
  List<TaskModel> _tasks = [];
  bool _isLoading = false;
  String? _error;

  List<TaskModel> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get error => _error;

  static const String _keyTasks = 'tasks_data';

  TaskProvider() {
    loadTasks();
  }

  Future<void> loadTasks() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksJsonString = prefs.getString(_keyTasks);

      if (tasksJsonString != null) {
        final List<dynamic> tasksJson = json.decode(tasksJsonString);
        _tasks = tasksJson.map((json) => TaskModel.fromJson(json)).toList();
      } else {
        _tasks = TaskModel.getDummyTasks();
        await _saveTasksToPrefs();
      }
      _error = null;
    } catch (e) {
      _error = AppStrings.errorLoadingTasks;
      debugPrint('Error loading tasks: $e');
      _tasks = TaskModel.getDummyTasks();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveTasksToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksJson = _tasks.map((task) => task.toJson()).toList();
      final tasksJsonString = json.encode(tasksJson);
      await prefs.setString(_keyTasks, tasksJsonString);
    } catch (e) {
      debugPrint('Error saving tasks: $e');
    }
  }

  Future<void> addTask(TaskModel task) async {
    _tasks.add(task);
    await _saveTasksToPrefs();
    notifyListeners();
  }

  Future<void> updateTask(TaskModel updatedTask) async {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      await _saveTasksToPrefs();
      notifyListeners();
    }
  }

  Future<void> deleteTask(String taskId) async {
    _tasks.removeWhere((task) => task.id == taskId);
    await _saveTasksToPrefs();
    notifyListeners();
  }

  /// Toggle task completion status
  Future<void> toggleTaskCompletion(String taskId) async {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(
        isCompleted: !_tasks[index].isCompleted,
      );
      await _saveTasksToPrefs();
      notifyListeners();
    }
  }

  /// Get task by ID
  TaskModel? getTaskById(String taskId) {
    try {
      return _tasks.firstWhere((task) => task.id == taskId);
    } catch (e) {
      return null;
    }
  }

  Future<void> clearAllTasks() async {
    _tasks.clear();
    await _saveTasksToPrefs();
    notifyListeners();
  }
}

