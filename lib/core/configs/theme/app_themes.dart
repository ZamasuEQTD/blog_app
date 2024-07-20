import 'package:blog_app/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  const AppThemes();
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme(
      brightness: Brightness.light, 
      primary: AppColors.primary, 
      onPrimary: AppColors.secondary, 
      secondary: AppColors.secondary, 
      onSecondary: AppColors.onSecondary, 
      error: AppColors.error, 
      onError: AppColors.onError, 
      surface: AppColors.background, 
      onSurface: AppColors.secondary
    ),
    primaryColor: AppColors.primary,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ) 
      )
    ),    
    useMaterial3: false,
  );
}