import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../buttons/text_button.dart';
import '../rounded_bottom_sheet.dart';

class IrreversibleAccionBottomSheet extends StatelessWidget {
  final String? textBase;
  final Widget child;
  final void Function() onCancel;
  final void Function() onSeguir;
  const IrreversibleAccionBottomSheet({
    super.key, 
    required this.child,
    required this.onCancel, 
    required this.onSeguir,
    this.textBase = "¿Deseas continuar?", 
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          textBase != null
              ? Text(
                  textBase!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 20),
                )
              : Container(),
          child,
          const SizedBox(height: 5),
           IrreversibleAccionButtonRow(
            onCancel: onCancel,
            onSeguir: onSeguir,
           )
        ],
    );
  }

  static void show({
    required Widget child,
    required BuildContext context,
    required void Function() onCancel,
    required void Function() onSeguir,
    Widget Function(Widget child, BuildContext context,)? builder
  }) {
    RoundedBottomSheetManager.show(
      child: IrreversibleAccionBottomSheet(
        onCancel: onCancel,
        onSeguir: onSeguir,
        child: child,
      ),
      context: context,
      builder: builder
    );
  }
}

class IrreversibleAccionButtonRow extends StatelessWidget {
  final void Function() onCancel;
  final void Function() onSeguir;

  const IrreversibleAccionButtonRow({super.key, required this.onCancel, required this.onSeguir});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 45,
        child: Row(
          children: [
            Expanded(
              child: TextFlatBtn(
                backgroundColor: CupertinoColors.destructiveRed.withOpacity(0.08),
                onTap: () {
                  onCancel();
                },
                txt: "Cancelar",
                color: Colors.red,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: TextFlatBtn(
                backgroundColor: CupertinoColors.systemGrey.withOpacity(0.15),
                onTap: onSeguir,
                txt: "Seguir",
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
 