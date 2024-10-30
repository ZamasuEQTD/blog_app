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

  Get.put(AuthController()..restaurarSesion());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      routeInformationParser: routes.routeInformationParser,
      routeInformationProvider: routes.routeInformationProvider,
      routerDelegate: routes.routerDelegate,
      backButtonDispatcher: routes.backButtonDispatcher,
      title: 'Flutter Demo',
      theme: AppThemes.light.copyWith(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
        textTheme: GoogleFonts.notoSansTextTheme(),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: WidgetStatePropertyAll(0),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
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
