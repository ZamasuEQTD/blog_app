import 'package:blog_app/src/lib/features/app/presentation/logic/extensions.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/dialogs/bottom_sheet.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/item_seleccionable.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/seleccionable/grupo_seleccionable.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/snackbar.dart';
import 'package:blog_app/src/lib/features/auth/presentation/logic/controlls/auth_controller.dart';
import 'package:blog_app/src/lib/features/hilo/domain/ihilos_repository.dart';
import 'package:blog_app/src/lib/features/hilo/presentation/logic/actions.dart';
import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';
import 'package:blog_app/src/lib/features/home/presentation/screens/widgets/portada.dart';
import 'package:blog_app/src/lib/features/moderacion/presentation/ver_usuario_panel.dart';
import 'package:blog_app/src/lib/features/usuarios/domain/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

abstract class PortadaHomeWidget extends StatelessWidget {
  const PortadaHomeWidget._({super.key});
}

class PortadaHome extends PortadaHomeWidget {
  final Portada portada;
  const PortadaHome({super.key, required this.portada}) : super._();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push("/hilo/${portada.id}"),
      onLongPress: () => HomePortadaOpciones.show(context, portada: portada),
      child: PortadaWidget.portada(portada: portada),
    );
  }
}

class PortadaHomeBone extends PortadaHomeWidget {
  const PortadaHomeBone({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return const PortadaWidget.bone();
  }
}

class HomePortadaOpciones extends StatelessWidget {
  final Portada portada;
  const HomePortadaOpciones({super.key, required this.portada});

  @override
  Widget build(BuildContext context) {
    return RoundedBottomSheet.normal(
      child: Column(
        children: [
          ...[
            GrupoItemSeleccionable(
              seleccionables: [
                ItemSeleccionable.text(
                  titulo: "Seguir",
                  onTap: () => GestorDeHilo.seguir(context, portada.id),
                ),
                ItemSeleccionable.text(
                  titulo: "Poner en favoritos",
                  onTap: () => GestorDeHilo.favoritos(context, portada.id),
                ),
                ItemSeleccionable.text(
                  titulo: "Ocultar",
                  onTap: () => GestorDeHilo.ocultar(context, portada.id),
                ),
                ItemSeleccionable.text(titulo: "Denunciar", onTap: () => {}),
              ],
            ),
            if (portada.esOp)
              GrupoItemSeleccionable(
                seleccionables: [
                  ItemSeleccionable.text(
                    titulo: "Desactivar notificaciones",
                    onTap: () async {
                      var repository = GetIt.I.get<IHilosRepository>();

                      var res = await repository.desactivarNotificaciones(
                        id: portada.id,
                      );

                      res.fold(
                        (l) => Snackbars.showFailure(context, l),
                        (r) => Snackbars.showSuccess(
                          context,
                          "Notificaciones desactivadas",
                        ),
                      );
                    },
                  ),
                ],
              ),
            if (Get.find<AuthController>().usuario.value?.rango is! Moderador)
              GrupoItemSeleccionable(
                seleccionables: [
                  ItemSeleccionable.text(
                    titulo: "Establecer como sticky",
                    onTap: () => GestorDeHilo.establecerSticky(
                      context,
                      portada.id,
                    ),
                  ),
                  ItemSeleccionable.text(
                    titulo: "Ver usuario",
                    onTap: () => showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => const VerUsuarioPanelBottomSheet(),
                    ),
                  ),
                  ItemSeleccionable.text(
                    titulo: "Eliminar",
                    onTap: () async {
                      var res = await GetIt.I.get<IHilosRepository>().eliminar(
                            id: portada.id,
                          );

                      res.fold(
                        (l) => Snackbars.showFailure(context, l),
                        (r) => Snackbars.showSuccess(
                          context,
                          "Hilo eliminado",
                        ),
                      );
                    },
                  ),
                ],
              ),
          ].addPadding,
        ],
      ).paddingSymmetric(horizontal: 20, vertical: 10),
    );
  }

  static void show(
    BuildContext context, {
    required Portada portada,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => HomePortadaOpciones(portada: portada),
    );
  }
}
