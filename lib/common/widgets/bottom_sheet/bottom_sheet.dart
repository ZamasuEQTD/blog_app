import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class BottomSheetManager extends StatelessWidget {
  final Widget child;
  final Widget Function(BuildContext context, Widget child)? builder;
  const BottomSheetManager({super.key, required this.child, this.builder});

  @override
  Widget build(BuildContext context) {
    HapticFeedback.mediumImpact();
    if (builder != null) return builder!(context, child);

    return child;
  }

  static void show(BuildContext context,
          {required Widget child,
          Widget Function(BuildContext context, Widget child)? builder}) =>
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => BottomSheetManager(
                builder: builder,
                child: child,
              ));
}

class SliverBottomSheet extends StatelessWidget {
  final ScrollController controller;
  final Widget child;
  final String? titulo;
  const SliverBottomSheet(
      {super.key, required this.controller, required this.child, this.titulo});

  @override
  Widget build(BuildContext context) {
    HapticFeedback.heavyImpact();

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      child: ColoredBox(
        color: const Color(0xfff2f3f5),
        child: CustomScrollView(
          controller: controller,
          slivers: [
            const SliverToBoxAdapter(child: _BottomSheetSeparator()),
            titulo != null
                ? SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titulo!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const Divider()
                        ],
                      ),
                    ),
                  )
                : const SliverToBoxAdapter(),
            SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                sliver: child)
          ],
        ),
      ),
    );
  }

  static void show(BuildContext context,
      {required Widget child, String? titulo}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
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
      ),
    );
  }
}

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

class DestructibleSeleccionableSheet extends StatelessWidget {
  static const TextStyle _tituloStyle =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w900);

  final String? titulo;
  final void Function() onAccept;
  const DestructibleSeleccionableSheet(
      {super.key, this.titulo, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titulo != null ? Text(titulo!, style: _tituloStyle) : Container(),
        TextButton(onPressed: onAccept, child: const Text("Aceptar")),
        const SizedBox(height: 10),
        OutlinedButton(
            onPressed: () {
              context.pop();
            },
            child: const Text("Cancelar"))
      ],
    );
  }

  static void show(BuildContext context,
      {required String titulo, required void Function() onAccept}) {
    BottomSheetManager.show(context,
        child:
            DestructibleSeleccionableSheet(titulo: titulo, onAccept: onAccept));
  }
}
