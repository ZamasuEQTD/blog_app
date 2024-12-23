import 'package:blog_app/features/app/presentation/widgets/dialog/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/grupo_seleccionable.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/item_seleccionable.dart';
import 'package:blog_app/features/auth/presentation/logic/controllers/auth_controller.dart';
import 'package:blog_app/features/hilos/domain/ihilos_repository.dart';
import 'package:blog_app/features/hilos/domain/models/portada.dart';
import 'package:blog_app/features/hilos/presentation/widgets/denunciar_hilo/denunciar_hilo.dart';
import 'package:blog_app/features/moderacion/presentation/widgets/usuario_panel/usuario_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class HiloOpciones extends StatelessWidget {
  final PortadaHilo portada;
  const HiloOpciones({super.key, required this.portada});

  @override
  Widget build(BuildContext context) {
    final IHilosRepository repository = GetIt.I.get<IHilosRepository>();

    final auth = Get.find<AuthController>();

    return RoundedBottomSheet.sliver(
      slivers: [
        GrupoItemSeleccionable.sliver(
          seleccionables: [
            ItemSeleccionable.text(
              titulo: "Poner en favoritos",
              onTap: () {},
            ),
            ItemSeleccionable.text(
              titulo: "Seguir",
              onTap: () {},
            ),
            ItemSeleccionable.text(
              titulo: "Ocultar",
              onTap: () {},
            ),
          ],
        ),
        GrupoItemSeleccionable.sliver(
          seleccionables: [
            ItemSeleccionable.text(
              titulo: "Denunciar",
              onTap: () {
                DenunciarHiloBottomSheet.show(context);
              },
            ),
          ],
        ),
        if (portada.esOp)
          GrupoItemSeleccionable.sliver(
            seleccionables: [
              ItemSeleccionable.text(
                titulo: portada.recibirNotificaciones!
                    ? "Desactivar notificaciones"
                    : "Activar notificaciones",
              ),
            ],
          ),
        if (auth.isAuthenticated && auth.usuario.value!.isModerador)
          GrupoItemSeleccionable.sliver(
            seleccionables: [
              ItemSeleccionable.text(
                titulo: "Ver usuario",
                onTap: () {
                  UsuarioPanelBottomSheet.show(
                    context,
                    usuario: portada.autor!,
                  );
                },
              ),
              ItemSeleccionable.text(
                titulo: "Eliminar",
                onTap: () {
                  repository.eliminar(id: portada.id);

                  context.pop();
                },
              ),
            ],
          ),
      ],
    );
  }
}
