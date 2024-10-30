// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:blog_app/src/lib/features/app/presentation/widgets/dialogs/dialog.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/dialogs/widgets/button.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/dialogs/widgets/titulo.dart';

typedef OnEnlaceAgregado = void Function(String enlace);

class AgregarEnlaceDialog extends StatefulWidget {
  final OnEnlaceAgregado onEnlaceAgregado;
  const AgregarEnlaceDialog({
    super.key,
    required this.onEnlaceAgregado,
  });

  @override
  State<AgregarEnlaceDialog> createState() => _AgregarEnlaceDialogState();
}

class _AgregarEnlaceDialogState extends State<AgregarEnlaceDialog> {
  String enlace = "";
  @override
  Widget build(BuildContext context) {
    return DialogRounded.normal(
      titulo: const DialogTitulo.text(titulo: "Agregar enlace"),
      child: Column(
        children: [
          TextField(
            onChanged: (value) => enlace = value,
            decoration: const InputDecoration(
              hintText: "Youtube.com...",
            ),
          ),
          DialogButton.normal(
            onPressed: () => widget.onEnlaceAgregado(""),
            text: "Agregar",
          ),
        ],
      ),
    );
  }
}
