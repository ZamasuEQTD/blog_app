import 'package:blog_app/common/widgets/seleccionable/widget/grupo_seleccionable_list.dart';
import 'package:flutter/material.dart';

import '../seleccionable/logic/class/grupo_seleccionable.dart';

class BottomSheet extends StatelessWidget {
  final Widget child;
  final Widget Function(BuildContext context, Widget child)? builder;
  const BottomSheet({
    super.key,
    required this.child, 
    this.builder
  });

  @override
  Widget build(BuildContext context) {
    if(builder != null) return builder!(context, child);

    return child;
  }

  static void show(BuildContext context, {
    required Widget child,
    Widget Function(BuildContext context, Widget child)? builder
  }) => showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.onSecondary,
    context: context, builder:(context) 
  => BottomSheet(
    builder: builder,
    child: child,
  ));
}

class DraggableScrollableBottomSheet extends StatelessWidget {
  final Widget Function(BuildContext context, ScrollController controller) builder;

  const DraggableScrollableBottomSheet({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: builder 
    );
  }

  static void show(BuildContext context, {
    required Widget Function(BuildContext context, ScrollController controller) builder
  }) => BottomSheet.show(
    context, 
    child: DraggableScrollableBottomSheet(
      builder: builder
    )
  );
}

class DraggableSeleccionableBottomSheet extends StatelessWidget {
  final ScrollController controller;
  final List<GrupoSeleccionable> grupos;
  const DraggableSeleccionableBottomSheet({
    super.key, 
    required this.grupos, required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GrupoSeleccionableList(seleccionables: grupos))
    );
  }

  static void show(BuildContext context,{
    required List<GrupoSeleccionable> grupos
  }) => DraggableScrollableBottomSheet.show(context, builder: (context, controller) => DraggableSeleccionableBottomSheet(grupos: grupos,controller: controller,));
}