import 'package:blog_app/src/lib/features/auth/presentation/widgets/dialog/logic/controlls/auth_controller.dart';
import 'package:blog_app/src/lib/modules/dependency_injection/init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:blog_app/src/lib/features/auth/presentation/blocs/auth/auth_bloc.dart';

import 'package:blog_app/src/lib/modules/routing.dart';
import 'package:blog_app/src/lib/modules/theme/app_themes.dart';

import 'package:blog_app/src/lib/modules/theme/app_colors.dart';
import 'package:provider/provider.dart';

void main() {
  GetIt.I.addDepedencies();
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
      builder: (context, child) {
        return ListenableProvider(
          create: (context) => AuthController()..restaurarSesion(),
          builder: (context, _) {
            return child!;
          },
        );
      },
    );
  }
}
