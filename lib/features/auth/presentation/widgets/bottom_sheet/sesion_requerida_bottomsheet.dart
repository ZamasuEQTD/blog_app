import 'package:blog_app/common/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';

class SesionRequeridaBottomsheet extends StatelessWidget {
  const SesionRequeridaBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Text(""),
        ),
        SliverToBoxAdapter()
      ],
    );
  }

  static void show(BuildContext context) => SliverBottomSheet.show(
        context,
        child: const SesionRequeridaBottomsheet(),
        titulo: "Sesion requerida",
      );
}

class IrLoginBtn extends StatelessWidget {
  const IrLoginBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class IrRegistroBtn extends StatelessWidget {
  const IrRegistroBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
