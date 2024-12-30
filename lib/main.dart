import 'package:blog_app/features/app/presentation/theme/app_colors.dart';
import 'package:blog_app/features/app/presentation/theme/app_themes.dart';
import 'package:blog_app/features/auth/presentation/logic/controllers/auth_controller.dart';
import 'package:blog_app/features/notificaciones/domain/inotificaciones_hub.dart';
import 'package:blog_app/features/notificaciones/presentation/logic/controles/mis_notificaciones_controller.dart';
import 'package:blog_app/modules/dependency_injection/init.dart';
import 'package:blog_app/modules/routing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.I.addDepedencies();

  await Get.put(GetIt.I.get<AuthController>()).restaurarSesion();

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
        textTheme: GoogleFonts.poppinsTextTheme(theme.textTheme).copyWith(),
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
          labelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
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
