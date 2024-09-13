import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  const SliverBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static void show(BuildContext context, {required Widget child}) {
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
        builder: (context, controller) => ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
          child: ColoredBox(
            color: Colors.white,
            child: CustomScrollView(
              controller: controller,
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                    width: double.infinity,
                  ),
                ),
                child
              ],
            ),
          ),
        ),
      ),
    );
  }
}
