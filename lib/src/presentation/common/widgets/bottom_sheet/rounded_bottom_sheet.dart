
import 'package:flutter/material.dart';

class RoundedBottomSheetManager extends StatelessWidget {
  final Widget child;
  final Widget Function(Widget child, BuildContext context)? builder;

  const RoundedBottomSheetManager({super.key, required this.child, this.builder});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10)
        ),
        child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 400,
            ),
          child: getChild(context))
      ),
    );
  }

  Widget getChild(BuildContext context) => builder != null ? builder!(child, context) : child;

  static void show({
      required BuildContext context,
      required Widget child,
      Widget Function(Widget child, BuildContext context)? builder
  }) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => RoundedBottomSheetManager(
        builder: builder,
        child: child
      )
    );
  }
}