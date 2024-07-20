import 'package:blog_app/presentation/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: const Color(0xff787880).withOpacity(0.2),
          border: InputBorder.none
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color(0xffF2F2F7)
        ),
        colorScheme: const ColorScheme.light(
          surface: Color(0xffF2F2F7),
        ),
        scaffoldBackgroundColor: const Color(0xffF2F2F7),
        useMaterial3: false,
      ),
      home: const HomeView(),
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
