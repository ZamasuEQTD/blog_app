import 'package:blog_app/features/app/presentation/widgets/dialog/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/grupo_seleccionable.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/item_seleccionable.dart';
import 'package:blog_app/features/app/presentation/widgets/snackbars/snackbar.dart';
import 'package:blog_app/features/auth/presentation/logic/controllers/auth_controller.dart';
import 'package:blog_app/features/comentarios/domain/icomentarios_repository.dart';
import 'package:blog_app/features/comentarios/domain/models/comentario.dart';
import 'package:blog_app/features/hilos/presentation/screens/hilo_screen/logic/controllers/hilo_controller.dart';
import 'package:blog_app/features/moderacion/presentation/widgets/usuario_panel/usuario_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class OpcionesDeComentarioBottomSheet extends StatelessWidget {
  final Comentario comentario;
  const OpcionesDeComentarioBottomSheet({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find();
    return RoundedBottomSheet.draggable(
      slivers: [
        ...<GrupoItemSeleccionable>[
          if (comentario.esOp)
            GrupoItemSeleccionable.sliver(
              titulo: "Opciones",
              seleccionables: [
                ItemSeleccionable.text(
                  onTap: () async {
                    var repository = GetIt.I.get<IComentariosRepository>();

                    var result = await repository.destacar(
                      hilo: Get.find<HiloController>().id,
                      comentario: comentario.id,
                    );

                    result.fold(
                      (l) => Snackbars.showFailure(context, l),
                      (r) => Snackbars.showSuccess(context, "Destacado"),
                    );
                  },
                  titulo: "Destacar",
                ),
              ],
            ),
          GrupoItemSeleccionable.sliver(
            seleccionables: [
              ItemSeleccionable.text(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: comentario.id));
                },
                titulo: "Copiar",
              ),
              ItemSeleccionable.text(
                onTap: () async {
                  var repository = GetIt.I.get<IComentariosRepository>();

                  var result = await repository.ocultar(id: comentario.id);

                  result.fold(
                    (l) => Snackbars.showFailure(context, l),
                    (r) => Snackbars.showSuccess(context, "Ocultado"),
                  );
                },
                titulo: "Ocultar",
              ),
              ItemSeleccionable.text(
                onTap: () async {},
                titulo: "Denunciar",
              ),
            ],
          ),
          if (controller.isAuthenticated &&
              controller.usuario.value!.isModerador)
            GrupoItemSeleccionable.sliver(
              titulo: "Moderación",
              seleccionables: [
                ItemSeleccionable.text(
                  onTap: () async {
                    IComentariosRepository repository = GetIt.I.get();

                    var result = await repository.eliminar(id: comentario.id);

                    result.fold(
                      (l) => Snackbars.showFailure(context, l),
                      (r) => Snackbars.showSuccess(
                        context,
                        "Comentario eliminado",
                      ),
                    );
                  },
                  titulo: "Eliminar",
                ),
                ItemSeleccionable.text(
                  onTap: () {
                    UsuarioPanelBottomSheet.show(
                      context,
                      usuario: comentario.autorId!,
                    );
                  },
                  titulo: "Ver usuario",
                ),
              ],
            ),
        ],
      ],
    );
  }

  static void show(
    BuildContext context, {
    required Comentario comentario,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Provider.value(
        value: comentario,
        child: OpcionesDeComentarioBottomSheet(comentario: comentario),
      ),
    );
  }
}
