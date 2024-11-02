import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  const AppThemes();
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.surface,
    appBarTheme:
        const AppBarTheme(backgroundColor: AppColors.surface, elevation: 0),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.secondary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      error: AppColors.error,
      onError: AppColors.onError,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
    ),
    primaryColor: AppColors.primary,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: AppColors.primary,
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: AppColors.onSurface,
    ),
    useMaterial3: false,
  );
}
