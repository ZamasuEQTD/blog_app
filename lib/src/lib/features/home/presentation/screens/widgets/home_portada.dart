import 'package:blog_app/src/lib/features/app/presentation/logic/extensions.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/dialogs/bottom_sheet.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/grupo_seleccionable.dart';
import 'package:blog_app/src/lib/features/auth/presentation/logic/controlls/auth_controller.dart';
import 'package:blog_app/src/lib/features/hilo/domain/ihilos_repository.dart';
import 'package:blog_app/src/lib/features/hilo/presentation/widgets/portada.dart';
import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';
import 'package:blog_app/src/lib/features/moderacion/presentation/ver_usuario_panel.dart';
import 'package:blog_app/src/lib/features/usuarios/domain/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/presentation/widgets/item_seleccionable.dart';

abstract class HomePortada extends StatelessWidget {
  const HomePortada._();

  const factory HomePortada({required Portada portada}) = HomePortadaLoaded;

  const factory HomePortada.bone() = HomePortadaBone;
}

class HomePortadaLoaded extends HomePortada {
  final Portada portada;
  const HomePortadaLoaded({required this.portada}) : super._();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push("/hilo/${portada.id}"),
      onLongPress: () => HomePortadaOpciones.show(context, portada: portada),
      child: PortadaView.portada(portada: portada),
    );
  }
}

class HomePortadaBone extends HomePortada {
  const HomePortadaBone() : super._();

  @override
  Widget build(BuildContext context) {
    return const PortadaView.bone();
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
            GrupoSeleccionable(
              seleccionables: [
                ItemSeleccionable.text(
                  titulo: "Seguir",
                  onTap: () async {
                    var res = await GetIt.I
                        .get<IHilosRepository>()
                        .seguir(id: portada.id);

                    res.fold((l) => null, (r) => null);
                  },
                ),
                ItemSeleccionable.text(
                  titulo: "Poner en favoritos",
                  onTap: () async {
                    var res = await GetIt.I
                        .get<IHilosRepository>()
                        .ponerEnFavoritos(id: portada.id);

                    res.fold((l) => null, (r) => null);
                  },
                ),
                ItemSeleccionable.text(
                  titulo: "Ocultar",
                  onTap: () async {
                    var res = await GetIt.I.get<IHilosRepository>().ocultar(
                          id: portada.id,
                        );

                    res.fold((l) => null, (r) => null);
                  },
                ),
                ItemSeleccionable.text(titulo: "Denunciar", onTap: () => {}),
              ],
            ),
            if (portada.esOp)
              const GrupoSeleccionable(
                seleccionables: [
                  ItemSeleccionable.text(titulo: "Desactivar notificaciones"),
                ],
              ),
            if (Get.find<AuthController>().usuario.value?.rango is! Moderador)
              GrupoSeleccionable(
                seleccionables: [
                  ItemSeleccionable.text(
                    titulo: "Establecer como sticky",
                    onTap: () async {
                      var res = await GetIt.I
                          .get<IHilosRepository>()
                          .establecerSticky(
                            id: portada.id,
                          );

                      res.fold((l) => null, (r) => null);
                    },
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

                      res.fold((l) => null, (r) => null);
                    },
                  ),
                ],
              ),
          ].addPadding(),
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
