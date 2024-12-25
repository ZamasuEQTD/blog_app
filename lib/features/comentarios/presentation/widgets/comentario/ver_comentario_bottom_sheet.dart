import 'package:blog_app/features/app/presentation/widgets/dialog/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/features/comentarios/domain/models/comentario.dart';
import 'package:blog_app/features/comentarios/presentation/widgets/comentario/hilo_comentario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerComentarioBottomSheet extends StatelessWidget {
  final Comentario comentario;
  const VerComentarioBottomSheet({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    return RoundedBottomSheet.normal(
      child: HiloComentario(comentario: comentario)
          .paddingSymmetric(horizontal: 10, vertical: 10),
    );
  }

  static void show(
    BuildContext context, {
    required Comentario comentario,
  }) =>
      showModalBottomSheet(
        context: context,
        builder: (context) => VerComentarioBottomSheet(comentario: comentario),
      );
}
