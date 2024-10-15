import 'package:blog_app/core/configs/routing.dart';
import 'package:blog_app/core/configs/theme/app_themes.dart';
import 'package:blog_app/core/dependency_injection/data_dependencies.dart';
import 'package:blog_app/features/auth/presentation/logic/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  GetIt.I.addData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: AppThemes.light.copyWith(
    //     textTheme: GoogleFonts.notoSansTextTheme(),
    //   ),
    //   home: const Home.Screen(),
    // );
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppThemes.light.copyWith(
        textTheme: GoogleFonts.notoSansTextTheme(),
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Color(0xfff5f5f5),
        ),
      ),
      routerConfig: routes,
      builder: (context, child) {
        return BlocProvider(
          create: (_) => AuthBloc(),
          child: child,
        );
      },
    );
  }
}
