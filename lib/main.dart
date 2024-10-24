import 'package:blog_app/core/configs/routing.dart';
import 'package:blog_app/core/configs/theme/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:blog_app/src/lib/features/auth/presentation/blocs/auth/auth_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          filled: true,
          fillColor: Color(0xfff5f5f5),
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
