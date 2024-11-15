import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  const AppThemes();

  static const TextStyle defaultLabelTextStyle = TextStyle(
    color: AppColors.label,
  );

  static const TextStyle defaultDisplayTextStyle = TextStyle(
    color: AppColors.display,
  );

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    drawerTheme: const DrawerThemeData(backgroundColor: AppColors.surface),
    dialogBackgroundColor: AppColors.surface,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surface,
    ),
    scaffoldBackgroundColor: AppColors.surface,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
    ),
    textTheme: const TextTheme(
      displayMedium: defaultDisplayTextStyle,
      displaySmall: defaultDisplayTextStyle,
      displayLarge: defaultDisplayTextStyle,
      labelLarge: defaultLabelTextStyle,
      labelMedium: defaultLabelTextStyle,
      labelSmall: defaultLabelTextStyle,
    ),
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
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: AppColors.onSurface,
    ),
    useMaterial3: false,
  );
}
