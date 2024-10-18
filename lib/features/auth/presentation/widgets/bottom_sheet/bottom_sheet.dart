// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:blog_app/features/auth/presentation/widgets/bottom_sheet/sesion_requerida_bottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class RoundedBottomSheet extends StatelessWidget {
  final String? titulo;
  final Widget child;
  final BorderRadiusGeometry radius;
  const RoundedBottomSheet({
    super.key,
    required this.child,
    this.titulo,
    this.radius = const BorderRadius.vertical(top: Radius.circular(10)),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius,
      child: ColoredBox(
        color: Theme.of(context).colorScheme.surface,
        child: child,
      ),
    );
  }

  static void show(
    BuildContext context, {
    required ShowBottomSheetOptions options,
    required Widget child,
    String? titulo,
  }) {
    Widget rounded = RoundedBottomSheet(
      titulo: titulo,
      child: child,
    );

    showMaterialModalBottomSheet(
      context: context,
      isDismissible: options.isDimissible,
      backgroundColor: Colors.transparent,
      builder: (context) => options.builder != null
          ? options.builder!(
              context,
              rounded,
            )
          : rounded,
    );
  }
}

class SliverDraggableBottomSheet extends StatelessWidget {
  final Widget child;
  const SliverDraggableBottomSheet({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 0.7,
      initialChildSize: 0.7,
      snap: true,
      snapSizes: const [0.5, 0.7],
      builder: (context, controller) => SliverBottomSheet(
        controller: controller,
        child: child,
      ),
    );
  }

  static void show(
    BuildContext context, {
    ShowBottomSheetOptions options = const ShowBottomSheetOptions(),
    required Widget child,
  }) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => RoundedBottomSheet(
        child: SliverDraggableBottomSheet(child: child),
      ),
    );
  }
}

class SliverBottomSheet extends StatelessWidget {
  final ScrollController? controller;
  final Widget child;
  const SliverBottomSheet({super.key, this.controller, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      controller: controller,
      slivers: [
        ChangeNotifierProvider.value(
          value: controller,
          child: SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: child,
          ),
        ),
      ],
    );
  }

  static void show(
    BuildContext context, {
    ShowBottomSheetOptions options = const ShowBottomSheetOptions(),
    required Widget child,
  }) {
    RoundedBottomSheet.show(
      context,
      options: options.copyWith(
        isScrollControlled: true,
      ),
      child: options.constraints != null
          ? ConstrainedBox(
              constraints: options.constraints!,
              child: SliverBottomSheet(
                child: child,
              ),
            )
          : SliverBottomSheet(
              controller: ModalScrollController.of(context),
              child: child,
            ),
    );
  }
}

class ShowBottomSheetOptions {
  final bool isScrollControlled;
  final bool isDimissible;
  final Color? color = Colors.transparent;
  final BorderRadius? radius;
  final BoxConstraints? constraints;
  final Widget Function(BuildContext context, Widget child)? builder;

  const ShowBottomSheetOptions({
    this.isScrollControlled = false,
    this.isDimissible = true,
    this.constraints,
    this.radius,
    this.builder,
  });

  ShowBottomSheetOptions copyWith({
    bool? isScrollControlled,
    bool? isDimissible,
    BoxConstraints? constraints,
    Widget Function(BuildContext context, Widget child)? builder,
  }) {
    return ShowBottomSheetOptions(
      isScrollControlled: isScrollControlled ?? this.isScrollControlled,
      isDimissible: isDimissible ?? this.isDimissible,
      constraints: constraints ?? this.constraints,
      builder: builder ?? this.builder,
    );
  }
}

class DestructibleBottomSheet extends StatelessWidget {
  final Widget child;
  final void Function() onAccept;
  const DestructibleBottomSheet({
    super.key,
    required this.child,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: FlatBtnStyle().copyWith(
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.error,
                    ),
                  ),
                  onPressed: onAccept,
                  child: const Text("Seguir"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: FlatBtnStyle().copyWith(
                    backgroundColor:
                        const WidgetStatePropertyAll(Color(0xff212121)),
                  ),
                  onPressed: () => context.pop(),
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static void show(
    BuildContext context, {
    required Widget child,
    required void Function() onAccept,
    String? titulo,
  }) =>
      RoundedBottomSheet.show(
        context,
        titulo: titulo,
        options: const ShowBottomSheetOptions(),
        child: DestructibleBottomSheet(
          onAccept: onAccept,
          child: child,
        ),
      );
}

class BottomSheetTitulo extends StatelessWidget {
  final String titulo;
  const BottomSheetTitulo({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          titulo,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
