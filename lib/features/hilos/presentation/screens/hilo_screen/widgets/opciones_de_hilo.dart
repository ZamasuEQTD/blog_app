import 'package:blog_app/features/app/presentation/widgets/dialog/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/grupo_seleccionable.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/item_seleccionable.dart';
import 'package:blog_app/features/auth/presentation/logic/controllers/auth_controller.dart';
import 'package:blog_app/features/hilos/domain/ihilos_repository.dart';
import 'package:blog_app/features/hilos/domain/models/hilo.dart';
import 'package:blog_app/features/hilos/domain/models/portada.dart';
import 'package:blog_app/features/hilos/presentation/widgets/denunciar_hilo/denunciar_hilo.dart';
import 'package:blog_app/features/moderacion/presentation/widgets/usuario_panel/usuario_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class HiloOpciones extends StatelessWidget {
  final OpcionesDeHiloConfiguration opciones;

  factory HiloOpciones.fromPortada({
    required PortadaHilo portada,
  }) =>
      HiloOpciones(
        opciones: OpcionesDeHiloConfiguration(
          autorId: portada.autor,
          id: portada.id,
          esOp: portada.esOp,
          recibirNotificaciones: portada.recibirNotificaciones,
        ),
      );

  factory HiloOpciones.fromHilo({
    required Hilo hilo,
  }) =>
      HiloOpciones(
        opciones: OpcionesDeHiloConfiguration(
          id: hilo.id,
          autorId: hilo.autorId,
          esOp: hilo.esOp,
          recibirNotificaciones: hilo.recibirNotificaciones,
        ),
      );

  const HiloOpciones({super.key, required this.opciones});

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
              onTap: () {
                repository.ponerEnFavoritos(id: opciones.id);
              },
            ),
            ItemSeleccionable.text(
              titulo: "Seguir",
              onTap: () {
                repository.seguir(id: opciones.id);
              },
            ),
            ItemSeleccionable.text(
              titulo: "Ocultar",
              onTap: () {
                repository.ocultar(id: opciones.id);
              },
            ),
          ],
        ),
        GrupoItemSeleccionable.sliver(
          seleccionables: [
            ItemSeleccionable.text(
              titulo: "Denunciar",
              onTap: () {
                DenunciarHiloBottomSheet.show(context, hilo: opciones.id);
              },
            ),
          ],
        ),
        if (opciones.esOp)
          GrupoItemSeleccionable.sliver(
            seleccionables: [
              ItemSeleccionable.text(
                titulo: opciones.recibirNotificaciones!
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
                    usuario: opciones.autorId!,
                  );
                },
              ),
              ItemSeleccionable.text(
                titulo: "Eliminar",
                onTap: () {
                  repository.eliminar(id: opciones.id);

                  context.pop();
                },
              ),
            ],
          ),
      ],
    );
  }
}

class OpcionesDeHiloConfiguration {
  final String id;
  final String? autorId;
  final bool esOp;
  final bool? recibirNotificaciones;
  const OpcionesDeHiloConfiguration({
    required this.id,
    required this.autorId,
    required this.esOp,
    required this.recibirNotificaciones,
  });
}
