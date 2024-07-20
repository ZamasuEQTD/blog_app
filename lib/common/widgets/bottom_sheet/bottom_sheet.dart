import 'package:flutter/material.dart';

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
  }) => showModalBottomSheet(context: context, builder:(context) 
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
      builder: builder 
    );
  }

  static void show(BuildContext context, {
    required Widget Function(BuildContext context, ScrollController controller) builder
  }) => BottomSheet.show(
    context, 
    child: DraggableScrollableBottomSheet(builder: builder)
  );
}