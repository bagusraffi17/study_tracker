import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:study_tracker/app.dart';
import 'package:study_tracker/core/theme/app_theme.dart';
import 'package:study_tracker/features/auth/providers/auth_provider.dart';
import 'package:study_tracker/features/tasks/providers/task_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await AppTheme.preloadFonts();

  // Setup Provider dengan MultiProvider
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const StudyTrackerApp(),
    ),
  );
}
