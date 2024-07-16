import 'package:blog_app/src/domain/features/comentarios/models/comentario.dart';
import 'package:blog_app/src/presentation/common/widgets/bottom_sheet/rounded_bottom_sheet.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/widget/grupo_seleccionable_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OpcionesDeComentariosBottomSheet extends StatelessWidget {
  final Comentario comentario;
  const OpcionesDeComentariosBottomSheet({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    return GrupoSeleccionableList(
        seleccionables:   [
            GrupoSeleccionable(seleccionables: [
            const ItemSeleccionable(nombre: "Ver usuario",
              leading: Icon(
                CupertinoIcons.person,
              ),
            ),
            const ItemSeleccionable(
                leading: Icon(
                  CupertinoIcons.cube_box,
                ),
                nombre: "Archivar",
            ),
            DestructibleItem.fromContext(
              context,
              nombre: "Denunciar",
              icon: Icons.flag_outlined
            ),
          ]),
          GrupoSeleccionable(seleccionables: [
            DestructibleItem.fromContext(
              context,
              nombre: "Eliminar",
              icon: Icons.delete_outline
            ),
            const ItemSeleccionable(
              leading: Icon(
                  CupertinoIcons.pin,
              ),
              nombre: "Destacar"
            ),
            const ItemSeleccionable(
              leading: Icon(
                CupertinoIcons.eye
              ),
              nombre: "Ocultar"
            ),
          ])
        ]);
  }

  static void show({
    required BuildContext context,
    required Comentario comentario
  }){
    RoundedBottomSheetManager.show(context: context, child: OpcionesDeComentariosBottomSheet(
      comentario: comentario
    ));
  }
}