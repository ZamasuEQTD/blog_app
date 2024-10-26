import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class RoundedBottomSheet extends StatelessWidget {
  const RoundedBottomSheet._({super.key});

  const factory RoundedBottomSheet({
    Key? key,
    BoxConstraints? constraints,
    required Widget child,
  }) = _BottomSheet;

  const factory RoundedBottomSheet.sliver({
    Key? key,
    Widget? titulo,
    ScrollController? controller,
    required List<Widget> slivers,
  }) = _SliverBottomSheet;

  const factory RoundedBottomSheet.draggable({
    Key? key,
    Widget? titulo,
    required List<Widget> slivers,
  }) = _DraggableSliverBottomSheet;

  const factory RoundedBottomSheet.normal({
    Key? key,
    Widget? titulo,
    BoxConstraints? constraints,
    required Widget child,
  }) = _NormalBottomSheet;
}

class _BottomSheet extends RoundedBottomSheet {
  final Widget child;
  final BoxConstraints? constraints;
  const _BottomSheet({
    super.key,
    required this.child,
    this.constraints,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    Widget child = ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColoredBox(
        color: Theme.of(context).colorScheme.onSurface,
        child: this.child,
      ),
    );

    if (constraints != null) {
      child = ConstrainedBox(
        constraints: constraints!,
        child: child,
      );
    }

    return child;
  }
}

class _NormalBottomSheet extends RoundedBottomSheet {
  final Widget child;
  final Widget? titulo;
  final BoxConstraints? constraints;
  const _NormalBottomSheet({
    super.key,
    required this.child,
    this.titulo,
    this.constraints,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return RoundedBottomSheet(
      constraints: constraints,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (titulo != null) titulo!,
          child,
        ],
      ),
    );
  }
}

class _SliverBottomSheet extends RoundedBottomSheet {
  final ScrollController? controller;
  final Widget? titulo;
  final List<Widget> slivers;
  const _SliverBottomSheet({
    super.key,
    required this.slivers,
    this.titulo,
    this.controller,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      controller: controller,
      slivers: slivers,
    );
    return RoundedBottomSheet(
      child: CustomScrollView(
        shrinkWrap: true,
        controller: controller,
        slivers: slivers,
      ),
    );
  }
}

class _DraggableSliverBottomSheet extends RoundedBottomSheet {
  final List<Widget> slivers;
  final Widget? titulo;
  const _DraggableSliverBottomSheet({
    super.key,
    required this.slivers,
    this.titulo,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, controller) => RoundedBottomSheet.sliver(
        controller: controller,
        slivers: slivers,
        titulo: titulo,
      ),
    );
  }
}

class DestructibleBottomSheet extends RoundedBottomSheet {
  final Widget child;
  final String? titulo;

  const DestructibleBottomSheet({
    super.key,
    required this.child,
    this.titulo,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return RoundedBottomSheet.normal(
      titulo: titulo != null ? Text(titulo!) : null,
      child: Column(
        children: [
          child,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Seguir"),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
