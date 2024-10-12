// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class RoundedBottomSheet extends StatelessWidget {
  final Widget child;
  final BorderRadiusGeometry radius;
  const RoundedBottomSheet({
    super.key,
    required this.child,
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
  }) {
    showMaterialModalBottomSheet(
      context: context,
      isDismissible: options.isDimissible,
      backgroundColor: Colors.transparent,
      builder: (context) => options.builder != null
          ? options.builder!(
              context,
              RoundedBottomSheet(
                child: child,
              ),
            )
          : RoundedBottomSheet(child: child),
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
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          sliver: child,
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