import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: ColoredBox(
        color: Theme.of(context).dialogBackgroundColor,
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
    return RoundedBottomSheet(
      child: CustomScrollView(
        shrinkWrap: true,
        controller: controller,
        slivers: [
          if (titulo != null) titulo!.marginSymmetric(horizontal: 10).sliverBox,
          ...slivers,
        ],
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
      maxChildSize: 0.6,
      builder: (context, controller) => RoundedBottomSheet.sliver(
        controller: controller,
        slivers: slivers,
        titulo: titulo,
      ),
    );
  }
}
