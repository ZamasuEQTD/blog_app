import 'package:blog_app/src/lib/features/auth/presentation/logic/controlls/auth_controller.dart';
import 'package:blog_app/src/lib/modules/dependency_injection/init.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:blog_app/src/lib/modules/routing.dart';
import 'package:blog_app/src/lib/modules/theme/app_themes.dart';

import 'package:blog_app/src/lib/modules/theme/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.I.addDepedencies();

  Get.put(GetIt.I.get<AuthController>()).restaurarSesion();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const TextStyle defaultTitleTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
  );

  static TextStyle largeTitleTextStyle = defaultTitleTextStyle.merge(
    const TextStyle(
      fontSize: 20,
    ),
  );
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = AppThemes.light;

    return GetMaterialApp.router(
      routeInformationParser: routes.routeInformationParser,
      routeInformationProvider: routes.routeInformationProvider,
      routerDelegate: routes.routerDelegate,
      backButtonDispatcher: routes.backButtonDispatcher,
      title: 'Flutter Demo',
      theme: theme.copyWith(
        appBarTheme: theme.appBarTheme.copyWith(
          elevation: 0,
          backgroundColor: AppColors.surface,
          titleTextStyle: (theme.textTheme.titleLarge)?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(theme.textTheme).copyWith(
          displayLarge: theme.textTheme.displayLarge?.copyWith(
            fontSize: 16,
          ),
          displayMedium: theme.textTheme.displayMedium?.copyWith(
            fontSize: 14,
          ),
          displaySmall: theme.textTheme.displaySmall?.copyWith(
            fontSize: 12,
          ),
          labelLarge: theme.textTheme.labelLarge?.copyWith(
            fontSize: 16,
          ),
          labelMedium: theme.textTheme.labelMedium?.copyWith(
            fontSize: 14,
          ),
          labelSmall: theme.textTheme.labelSmall?.copyWith(
            fontSize: 12,
          ),
          titleSmall: theme.textTheme.titleSmall?.merge(
            defaultTitleTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
          titleMedium: theme.textTheme.titleMedium?.merge(
            defaultTitleTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
          titleLarge: theme.textTheme.titleLarge?.merge(
            largeTitleTextStyle,
          ),
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            textStyle: WidgetStatePropertyAll(
              TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            ),
            elevation: WidgetStatePropertyAll(0),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
          ),
          fillColor: AppColors.onSurface,
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
        ),
      ),
    );
  }
}
