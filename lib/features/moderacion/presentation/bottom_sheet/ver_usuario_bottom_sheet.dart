import 'package:flutter/material.dart';

class VerUsuarioBottomSheet extends StatelessWidget {
  const VerUsuarioBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static void show(BuildContext context) => showBottomSheet(
        context: context,
        builder: (context) => DraggableScrollableSheet(
          builder: (context, scrollController) => Container(),
        ),
      );
}
