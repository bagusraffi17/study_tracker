import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// App theme configuration using Material Design 3
class AppTheme {
  AppTheme._();

  static ThemeData? _cachedLightTheme;

  static TextTheme? _cachedTextTheme;
  static TextStyle? _cachedAppBarTitleStyle;

  static Future<void> preloadFonts() async {
    _cachedTextTheme = GoogleFonts.interTextTheme();
    _cachedAppBarTitleStyle = GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.onPrimary,
    );

    try {
      GoogleFonts.inter();
    } catch (e) {
      debugPrint('Failed to preload fonts: $e');
    }
  }

  static ThemeData get lightTheme {
    if (_cachedLightTheme != null) {
      return _cachedLightTheme!;
    }

    _cachedLightTheme = ThemeData(
      useMaterial3: true,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.onPrimaryContainer,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: AppColors.onSecondaryContainer,
        background: AppColors.background,
        onBackground: AppColors.onBackground,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        error: AppColors.error,
        onError: AppColors.onError,
      ),

      textTheme: _cachedTextTheme ?? GoogleFonts.interTextTheme(),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        titleTextStyle: _cachedAppBarTitleStyle ??
            GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.onPrimary,
            ),
      ),

      // Card Theme
      cardTheme: const CardThemeData(
        elevation: 2,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // FloatingActionButton Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
    );

    return _cachedLightTheme!;
  }
}
