import 'package:blog_app/features/auth/presentation/widgets/bottom_sheet/sesion_requerida_bottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_widget_cache.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';

class _BottomSheetSeparator extends StatelessWidget {
  const _BottomSheetSeparator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: double.infinity,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: const ColoredBox(
            color: Colors.white,
            child: SizedBox(
              height: 7,
              width: 80,
            ),
          ),
        ),
      ),
    );
  }
}

class DestructibleSeleccionableSheet extends NormalBottomSheet {
  DestructibleSeleccionableSheet({super.key, super.titulo})
      : super(
            child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: const FlatBtnStyle().copyWith(
                      backgroundColor: const WidgetStatePropertyAll(
                          CupertinoColors.destructiveRed)),
                  onPressed: () {},
                  child: const Text("Seguir")),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: const FlatBtnStyle().copyWith(
                      backgroundColor:
                          const WidgetStatePropertyAll(CupertinoColors.white)),
                  onPressed: () {},
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.black),
                  )),
            ),
          ],
        ));

  static show(
    BuildContext context, {
    required void Function() onAccept,
    String? titulo,
  }) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => DestructibleSeleccionableSheet(titulo: titulo));
  }
}

abstract class BottomSheet extends StatelessWidget {
  final Widget child;
  final String? titulo;
  const BottomSheet({super.key, required this.child, this.titulo});

  @override
  Widget build(BuildContext context) {
    HapticFeedback.mediumImpact();

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      child: ColoredBox(
        color: Theme.of(context).colorScheme.surface,
        child: child,
      ),
    );
  }

  static Widget generarTitulo(String? titulo) {
    return titulo != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Divider()
              ],
            ),
          )
        : const SizedBox();
  }
}

class NormalBottomSheet extends BottomSheet {
  NormalBottomSheet({super.key, super.titulo, required Widget child})
      : super(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _BottomSheetSeparator(),
            BottomSheet.generarTitulo(titulo),
            child,
          ],
        ));
  static show(
    BuildContext context, {
    required Widget child,
    String? titulo,
  }) =>
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => NormalBottomSheet(
          titulo: titulo,
          child: child,
        ),
      );
}

class SliverBottomSheet extends BottomSheet {
  final ScrollController? controller;

  SliverBottomSheet(
      {super.key, required Widget child, super.titulo, this.controller})
      : super(
            child: CustomScrollView(
          controller: controller,
          slivers: [
            const SliverToBoxAdapter(child: _BottomSheetSeparator()),
            SliverToBoxAdapter(child: BottomSheet.generarTitulo(titulo)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              sliver: child,
            )
          ],
        ));

  static void show(
    BuildContext context, {
    required Widget child,
    String? titulo,
  }) =>
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => SliverBottomSheet(
                titulo: titulo,
                child: child,
              ));
}

class SliverDraggableBottomSheet extends StatelessWidget {
  final String? titulo;
  final Widget child;
  const SliverDraggableBottomSheet(
      {super.key, required this.child, this.titulo});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 0.7,
      initialChildSize: 0.5,
      snap: true,
      snapSizes: const [0.5, 0.7],
      builder: (context, controller) => SliverBottomSheet(
        controller: controller,
        titulo: titulo,
        child: child,
      ),
    );
  }

  static void show(
    BuildContext context, {
    String? titulo,
    required Widget child,
  }) =>
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => SliverDraggableBottomSheet(
          titulo: titulo,
          child: child,
        ),
      );
}
