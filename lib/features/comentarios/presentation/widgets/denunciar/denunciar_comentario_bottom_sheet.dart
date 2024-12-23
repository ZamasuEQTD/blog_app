import 'package:blog_app/features/app/presentation/widgets/dialog/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/grupo_seleccionable.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/item_seleccionable.dart';
import 'package:blog_app/features/app/presentation/widgets/snackbars/snackbar.dart';
import 'package:blog_app/features/comentarios/domain/icomentarios_repository.dart';
import 'package:blog_app/features/comentarios/domain/models/typedef.dart';
import 'package:flutter/material.dart';

import 'package:blog_app/features/comentarios/domain/razon_de_denuncia.dart';
import 'package:get_it/get_it.dart';

Map<ComentarioRazonDenuncia, String> denuncias = {
  ComentarioRazonDenuncia.spam: "Spam",
  ComentarioRazonDenuncia.contenidoInapropiado: "Contenido inapropiado",
  ComentarioRazonDenuncia.otro: "Otro",
};

class DenunciarComentarioBottomSheet extends StatelessWidget {
  final ComentarioId id;
  const DenunciarComentarioBottomSheet({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return RoundedBottomSheet.sliver(
      slivers: [
        GrupoItemSeleccionable.sliver(
          seleccionables: denuncias.entries
              .map(
                (e) => ItemSeleccionable.text(
                  titulo: e.value,
                  onTap: () async {
                    IComentariosRepository repository = GetIt.I.get();

                    var result = await repository.denunciar(
                      hilo: "",
                      comentario: id,
                    );

                    result.fold(
                      (l) => Snackbars.showFailure(context, l),
                      (r) => Snackbars.showSuccess(
                        context,
                        "Comentario denunciado",
                      ),
                    );
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
