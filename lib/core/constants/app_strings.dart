/// App string constants
///
/// NOTE: Strings akan ditambahkan progressively seiring tutorial:
/// - P4-5: App identity & basic actions
/// - P5-7: Task feature strings
/// - P6: Form validation messages
/// - P9: Authentication strings
/// - P13: Dashboard strings
/// - P14: Profile & settings strings
class AppStrings {
  AppStrings._(); // Prevent instantiation

  // ==================== App Identity ====================
  static const String appName = 'StudyTracker';
  static const String appTagline = 'Track Your Study Progress';

  // ==================== Common Actions ====================
  // Used across the app for buttons, dialogs, etc.
  static const String loading = 'Loading...';
  static const String retry = 'Retry';
  static const String cancel = 'Cancel';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String ok = 'OK';

  // ==================== TODO: Additional Strings ====================
  static const String confirm = 'Confirm';

  // NEW: Navigation strings
  static const String tasks = 'Tasks';
  static const String dashboard = 'Dashboard';
  static const String profile = 'Profile';

  // NEW: Task List Screen strings
  static const String myTasks = 'My Tasks';
  static const String noTasks = 'No tasks yet';
  static const String addTask = 'Add Task';
  static const String searchHint = 'Search tasks by title';
  static const String noSearchResults = 'Tidak ada tasks yang match dengan';
  static const String tryAnotherKeyword = 'Coba kata kunci lain';

  // NEW: Priority Labels
  static const String priorityHigh = 'High';
  static const String priorityMedium = 'Medium';
  static const String priorityLow = 'Low';

  // NEW: Category Labels
  static const String categoryGeneral = 'General';
  static const String categoryStudy = 'Study';
  static const String categoryAssignment = 'Assignment';
  static const String categoryExam = 'Exam';
  static const String categoryProject = 'Project';
  static const String categoryPersonal = 'Personal';

  // NEW: Status Labels
  static const String statusCompleted = 'Completed';
  static const String statusPending = 'Pending';
  static const String statusOverdue = 'Overdue';

  // NEW: Task Actions
  static const String deleteTask = 'Delete Task';
  static const String deleteTaskConfirm =
      'Are you sure you want to delete this task?';

  // ==================== Form Labels ====================
  static const String taskTitle = 'Task Title';
  static const String taskDescription = 'Description';
  static const String dueDate = 'Due Date';
  static const String priority = 'Priority';
  static const String category = 'Category';
  static const String selectDate = 'Select Date';
  static const String selectPriority = 'Select Priority';
  static const String selectCategory = 'Select Category';

  // ==================== Form Validation Messages ====================
  static const String fieldRequired = 'This field is required';
  static const String titleTooShort = 'Title must be at least 3 characters';
  static const String titleTooLong = 'Title must not exceed 100 characters';
  static const String descriptionTooLong =
      'Description must not exceed 500 characters';
  static const String dateRequired = 'Please select a due date';
  static const String priorityRequired = 'Please select a priority level';
  static const String categoryRequired = 'Please select a category';

  // ==================== Success/Error Messages ====================
  static const String taskCreated = 'Task created successfully';
  static const String taskUpdated = 'Task updated successfully';
  static const String taskDeleted = 'Task deleted';
  static const String errorGeneric = 'Something went wrong';
  static const String errorLoadingTasks = 'Failed to load tasks';

  // ==================== Authentication Strings ====================
  static const String login = 'Login';
  static const String logout = 'Logout';
  static const String register = 'Register';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String enterEmail = 'Enter your email';
  static const String enterPassword = 'Enter your password';
  static const String loginSuccess = 'Login successful';
  static const String loginFailed = 'Login failed. Please try again.';
  static const String logoutConfirm = 'Are you sure you want to logout?';
  static const String invalidEmail = 'Please enter a valid email';
  static const String passwordTooShort =
      'Password must be at least 6 characters';

  // TODO P13: Add dashboard & analytics strings
  // TODO P14: Add profile & settings strings
}
