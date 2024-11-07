import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
}

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.gray50,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.gray600),
    titleTextStyle: TextStyle(
      color: AppColors.gray800,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.gray600,
    onPrimary: AppColors.white,
    secondary: AppColors.gray400,
    onSecondary: AppColors.gray800,
    error: Colors.red,
    onError: AppColors.white,
    surface: AppColors.white,
    onSurface: AppColors.gray700,
  ),
  primaryColor: AppColors.gray600,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.gray700),
    bodyMedium: TextStyle(color: AppColors.gray600),
    titleLarge:
        TextStyle(color: AppColors.gray800, fontWeight: FontWeight.bold),
    titleMedium:
        TextStyle(color: AppColors.gray700, fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      backgroundColor: AppColors.gray600,
      foregroundColor: AppColors.white,
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: AppColors.gray100,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.gray400, width: 2),
    ),
    hintStyle: const TextStyle(color: AppColors.gray500),
  ),
  cardTheme: CardTheme(
    color: AppColors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(color: AppColors.gray200),
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: AppColors.gray200,
    thickness: 1,
  ),
  iconTheme: const IconThemeData(
    color: AppColors.gray500,
  ),
  useMaterial3: false,
);
