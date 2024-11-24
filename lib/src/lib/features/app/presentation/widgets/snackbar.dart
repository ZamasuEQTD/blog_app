import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

typedef SnackbarBuilder = Widget Function(BuildContext context, Widget? child);

abstract class SnackbarCustom extends StatelessWidget {
  const SnackbarCustom._({super.key});

  static void show(
    BuildContext context,
    Widget child,
  ) {
    context.showFlash(
      duration: const Duration(seconds: 3),
      builder: (context, controller) => _SnackbarCustom(
        controller: controller,
        builder: (context, _) => Provider.value(
          value: controller,
          child: child,
        ),
      ),
    );
  }
}

class _SnackbarCustom extends SnackbarCustom {
  final FlashController controller;
  final SnackbarBuilder builder;
  const _SnackbarCustom({
    super.key,
    required this.controller,
    required this.builder,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return FlashBar(
      content: const Text("data"),
      controller: controller,
      backgroundColor: const Color(0xff2e2e2e),
      position: FlashPosition.top,
      builder: builder,
    );
  }
}

extension BuildContextExtensions on BuildContext {
  ThemeData get actualTheme => Theme.of(this);

  ThemeData get newTheme => Theme.of(this).copyWith(
        checkboxTheme: const CheckboxThemeData(),
        appBarTheme: actualTheme.appBarTheme.copyWith(
          backgroundColor: const Color(0xffF1F1F1),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: actualTheme.elevatedButtonTheme.style?.copyWith(
            foregroundColor: const WidgetStatePropertyAll(Colors.black),
            backgroundColor: const WidgetStatePropertyAll(Colors.white),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 16),
            ),
            iconColor: const WidgetStatePropertyAll(Colors.black),
            textStyle: const WidgetStatePropertyAll(
              TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        inputDecorationTheme: actualTheme.inputDecorationTheme.copyWith(),
      );
}

abstract class MySnackbar extends StatelessWidget {
  const MySnackbar({super.key});
}

class _MySnackbar extends MySnackbar {
  final Widget child;
  const _MySnackbar({required this.child});

  @override
  Widget build(BuildContext context) {
    return FlashBar(
      controller: context.read(),
      behavior: FlashBehavior.floating,
      backgroundColor: const Color(0xff2e2e2e),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      position: FlashPosition.top,
      content: const SizedBox(),
      builder: (context, _) => child.paddingSymmetric(
        horizontal: 15,
        vertical: 15,
      ),
    );
  }
}

class SuccessSnackbar extends MySnackbar {
  final String message;
  const SuccessSnackbar({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return _MySnackbar(
      child: Row(
        children: [
          const ClipOval(
            child: SizedBox.square(
              dimension: 25,
              child: ColoredBox(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                    child: FaIcon(
                      FontAwesomeIcons.check,
                    ),
                  ),
                ),
              ),
            ),
          )
              .animate()
              .scale(
                duration: const Duration(
                  milliseconds: 500,
                ),
                curve: Curves.bounceOut,
              )
              .marginOnly(right: 10),
          const Text(
            "Hilo creado",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class FailureSnackbar extends MySnackbar {
  final Failure failure;
  const FailureSnackbar({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    return _MySnackbar(
      child: Text(
        failure.descripcion ?? failure.code,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
