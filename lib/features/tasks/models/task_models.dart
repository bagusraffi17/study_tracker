class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final TaskPriority priority;
  final TaskCategory category;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    this.category = TaskCategory.general,
    this.isCompleted = false,
  });

  /// Get task status based on completion and due date
  TaskStatus get status {
    if (isCompleted) return TaskStatus.completed;
    if (dueDate.isBefore(DateTime.now())) return TaskStatus.overdue;
    return TaskStatus.pending;
  }

  /// Convert TaskModel to JSON Map for SharedPreferences
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'priority': priority.name,
      'category': category.name,
      'isCompleted': isCompleted,
    };
  }

  /// Create TaskModel from JSON Map
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      priority: TaskPriority.values.firstWhere(
        (e) => e.name == json['priority'],
        orElse: () => TaskPriority.medium,
      ),
      category: json['category'] != null
          ? TaskCategory.values.firstWhere(
              (e) => e.name == json['category'],
              orElse: () => TaskCategory.general,
            )
          : TaskCategory.general,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  /// Create a copy of TaskModel with optional updated fields
  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    TaskPriority? priority,
    TaskCategory? category,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  /// Dummy data generator untuk testing UI
  static List<TaskModel> getDummyTasks() {
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
        category: TaskCategory.project,
        isCompleted: false,
      ),
      TaskModel(
        id: '4',
        title: 'English Essay Draft',
        description: 'First draft of argumentative essay',
        dueDate: now.add(const Duration(days: 7)),
        priority: TaskPriority.low,
        category: TaskCategory.assignment,
        isCompleted: false,
      ),
      TaskModel(
        id: '5',
        title: 'Chemistry Quiz Prep',
        description: 'Study organic chemistry for quiz',
        dueDate: now.subtract(const Duration(days: 3)),
        priority: TaskPriority.medium,
        category: TaskCategory.exam,
        isCompleted: true,
      ),
    ];
  }
}

/// Task priority levels
enum TaskPriority {
  low,
  medium,
  high,
}

/// Task status based on completion and due date
enum TaskStatus {
  completed,
  pending,
  overdue,
}

/// Task category for organizing tasks
enum TaskCategory {
  general,
  study,
  assignment,
  exam,
  project,
  personal,
}
