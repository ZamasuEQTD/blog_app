import 'package:blog_app/src/domain/features/comentarios/models/comentario.dart';
import 'package:blog_app/src/presentation/common/widgets/bottom_sheet/rounded_bottom_sheet.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/widget/grupo_seleccionable_list.dart';
import 'package:blog_app/src/presentation/features/comentarios/widgets/comentario/comentario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class OpcionesDeComentariosBottomSheet extends StatelessWidget {
  final Comentario comentario;
  const OpcionesDeComentariosBottomSheet({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    return GrupoSeleccionableList(
        controller: context.read(),
        seleccionables: const [
          GrupoSeleccionable(seleccionables: [
            ItemSeleccionable(nombre: "Ver usuario",
              leading: Icon(
                CupertinoIcons.person_fill,
              ),
            ),
            ItemSeleccionable(
                leading: Icon(
                  CupertinoIcons.cube_box_fill,
                ),
                nombre: "Archivar",
            ),
            ItemSeleccionable(
              leading:  Icon(
                  CupertinoIcons.trash_fill,
                  color: CupertinoColors.destructiveRed,
                ),
              nombre: "Eliminar",
              style: TextStyle(color: CupertinoColors.destructiveRed)
            ),
          ]),
          GrupoSeleccionable(seleccionables: [
            ItemSeleccionable(
              leading: Icon(
                  CupertinoIcons.flag_fill,
                ),
              nombre: "Denunciar"
            ),
            ItemSeleccionable(
              leading: Icon(
                  CupertinoIcons.pin_fill,
              ),
              nombre: "Destacar"
            ),
            ItemSeleccionable(
              leading: Icon(
                CupertinoIcons.eye_fill,
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