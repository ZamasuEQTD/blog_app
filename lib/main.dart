import 'package:blog_app/core/configs/theme/app_themes.dart';
import 'package:blog_app/core/dependency_injection/data_dependencies.dart';
import 'package:blog_app/features/hilos/presentation/screens/hilo_screen.dart';
import 'package:blog_app/features/hilos/presentation/screens/postear_hilo_screen.dart';
import 'package:blog_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          AppThemes.light.copyWith(textTheme: GoogleFonts.poppinsTextTheme()),
      home: const HiloScreen(),
    );
  }
}
