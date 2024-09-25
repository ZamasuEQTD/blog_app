import 'package:flutter/material.dart';

class BottomSheet extends StatelessWidget {
  final Widget child;
  final BorderRadiusGeometry radius;
  const BottomSheet(
      {super.key,
      required this.child,
      this.radius = const BorderRadius.vertical(top: Radius.circular(10))});

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

  static void show(BuildContext context,
      {required ShowBottomSheetOptionsBuilder options, required Widget child}) {
    showModalBottomSheet(
      isScrollControlled: options.isScrollControlled,
      isDismissible: options.isDimissible,
      constraints: options.constraints,
      backgroundColor: options.color,
      context: context,
      builder: (context) => options.builder != null
          ? options.builder!(
              context,
              BottomSheet(
                child: child,
              ))
          : BottomSheet(child: child),
    );
  }
}

class SliverDraggableBottomShow extends StatelessWidget {
  final Widget child;
  const SliverDraggableBottomShow({super.key, required this.child});

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
        child: child,
      ),
    );
  }

  static void show(
    BuildContext context, {
    required ShowBottomSheetOptionsBuilder options,
    required Widget child,
  }) =>
      BottomSheet.show(
        context,
        options: options.setScrollControlled(true),
        child: SliverDraggableBottomShow(child: child),
      );
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
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          sliver: child,
        )
      ],
    );
  }

  static void show(
    BuildContext context, {
    required ShowBottomSheetOptionsBuilder options,
    required Widget child,
  }) =>
      BottomSheet.show(context,
          options: options.setScrollControlled(true),
          child: SliverBottomSheet(child: child));
}

class ShowBottomSheetOptionsBuilder {
  bool isScrollControlled = false;
  bool isDimissible = false;
  Color? color = Colors.transparent;
  BoxConstraints? constraints;
  Widget Function(BuildContext context, Widget child)? builder;

  ShowBottomSheetOptionsBuilder setScrollControlled(bool value) {
    isScrollControlled = value;

    return this;
  }

  ShowBottomSheetOptionsBuilder setColor(Color? value) {
    color = value;

    return this;
  }

  ShowBottomSheetOptionsBuilder setIsDimissible(bool value) {
    isDimissible = value;

    return this;
  }

  ShowBottomSheetOptionsBuilder setConstraints(BoxConstraints value) {
    constraints = value;

    return this;
  }

  ShowBottomSheetOptionsBuilder setBuilder(
    Widget Function(BuildContext context, Widget child)? value,
  ) {
    builder = value;

    return this;
  }
}
