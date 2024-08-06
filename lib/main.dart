import 'package:blog_app/core/configs/theme/app_themes.dart';
import 'package:blog_app/data/configuration/dependency_injection.dart';
import 'package:blog_app/domain/configuration/dependency_injection.dart';
import 'package:blog_app/presentation/hilos/views/postear_hilo/postear_hilo_view.dart';
import 'package:blog_app/presentation/hilos/views/ver_hilo/ver_hilo_view.dart';
import 'package:blog_app/presentation/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  GetIt.I
  .addData()
  .addDomain();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemes.light.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme()
      ),
      home: const VerHiloView(),
      builder: (context, child) {
        return PopScope(
          canPop: true,
          child: Stack(
            children: [
              child!,
              // Positioned.fill(
              //   child: Container(
              //     color: Colors.black.withOpacity(0.6),
              //     child: const Center(
              //       child: CircularProgressIndicator(
              //         color: Colors.white,
              //       ),
              //     ),
              //   )
              // )
            ],
          )
        );
      },
    );

  }
}
