import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

abstract class Snackbars extends StatelessWidget {
  const Snackbars._({super.key});

  const factory Snackbars({required Widget child}) = _Snackbar;

  const factory Snackbars.failure({required Failure failure}) =
      _FailureSnackbar;

  const factory Snackbars.success({required String message}) = _SuccessSnackbar;

  static void show(BuildContext context, Widget child) => context.showFlash(
        duration: const Duration(seconds: 3),
        builder: (context, controller) => Provider.value(
          value: controller,
          child: child,
        ),
      );

  static void showFailure(BuildContext context, Failure failure) => show(
        context,
        Snackbars.failure(failure: failure),
      );

  static void showSuccess(BuildContext context, String message) => show(
        context,
        Snackbars.success(message: message),
      );
}

class _Snackbar extends Snackbars {
  final Widget child;
  const _Snackbar({required this.child}) : super._();

  @override
  Widget build(BuildContext context) {
    return FlashBar(
      dismissDirections: const [],
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
        vertical: 12,
      ),
    );
  }
}

class _SuccessSnackbar extends Snackbars {
  final String message;
  const _SuccessSnackbar({super.key, required this.message}) : super._();

  @override
  Widget build(BuildContext context) {
    return _Snackbar(
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
          Text(
            message,
            style: const TextStyle(
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

class _FailureSnackbar extends Snackbars {
  final Failure failure;
  const _FailureSnackbar({super.key, required this.failure}) : super._();

  @override
  Widget build(BuildContext context) {
    return _Snackbar(
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
