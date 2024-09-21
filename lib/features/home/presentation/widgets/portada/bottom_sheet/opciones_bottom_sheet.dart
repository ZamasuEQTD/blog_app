import 'package:blog_app/common/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import 'package:blog_app/common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import 'package:blog_app/common/widgets/seleccionable/widget/grupo_seleccionable_list.dart';
import 'package:blog_app/features/hilos/domain/usecase/agregar_a_favoritos_usecase.dart';
import 'package:blog_app/features/hilos/domain/usecase/denunciar_hilo_usecase.dart';
import 'package:blog_app/features/hilos/domain/usecase/destacar_hilo_usecase.dart';
import 'package:blog_app/features/hilos/domain/usecase/eliminar_hilo_usecase.dart';
import 'package:blog_app/features/hilos/domain/usecase/ocultar_hilo_usecase.dart';
import 'package:blog_app/features/hilos/domain/usecase/seguir_hilo_usecase.dart';
import 'package:blog_app/features/home/presentation/logic/bloc/home_portadas_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

import '../../../../../moderacion/presentation/ver_usuario_panel.dart';

class OpcionesDePortadaBottomSheet extends StatelessWidget {
  const OpcionesDePortadaBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    List<GrupoSeleccionable> opciones = [
      GrupoSeleccionable(seleccionables: [
        ItemSeleccionableTileList(
            onTap: () {
              OcultarHiloUsecase usecase = GetIt.I.get();

              usecase.handle(OcultarHiloParams()).then(
                (value) {
                  value.fold(
                      (l) => null,
                      (r) => context
                          .read<HomePortadasBloc>()
                          .add(const EliminarPortada(id: "")));
                },
              );
            },
            nombre: "Ocultar",
            icon: FontAwesomeIcons.eye),
        ItemSeleccionableTileList(
            nombre: "Agregar a favoritos",
            onTap: () {
              AgregarAFavoritosUsecase usecase = GetIt.I.get();

              usecase.handle(AgregarAFavoritosParams()).then(
                (value) {
                  value.fold((l) => null, (r) => null);
                },
              );
            },
            icon: FontAwesomeIcons.star),
        ItemSeleccionableTileList(
            nombre: "Seguir",
            onTap: () {
              SeguirHiloUsecase usecase = GetIt.I.get();

              usecase.handle(SeguirHiloParams()).then(
                (value) {
                  value.fold((l) => null, (r) => null);
                },
              );
            },
            icon: FontAwesomeIcons.plus),
        ItemSeleccionableTileList(
            onTap: () => SeleccionarRazonDeDenuncia.show(
                  context,
                  onSeleccionada: (razon) {
                    DenunciarHiloUsecase usecase = GetIt.I.get();
                    usecase
                        .handle(DenunciarHiloParms())
                        .then((value) => value.fold(
                              (l) => null,
                              (r) => null,
                            ));
                  },
                ),
            nombre: "Denunciar",
            icon: Icons.flag),
      ])
    ];

    if (true) {
      opciones.add(GrupoSeleccionable(seleccionables: [
        ItemSeleccionableTileList(
            nombre: "Destacar",
            onTap: () {
              DestructibleSeleccionableSheet.show(
                context,
                titulo: "Destacar hilo",
                onAccept: () {
                  DestacarHiloUsecase usecase = GetIt.I.get();

                  usecase
                      .handle(DestacarHiloParams())
                      .then((value) => value.fold(
                            (l) => null,
                            (r) => null,
                          ));
                },
              );
            },
            icon: FontAwesomeIcons.thumbtack),
        ItemSeleccionableTileList(
            onTap: () => VerUsuarioPanel.show(context, usuario: ""),
            nombre: "Ver usuario",
            icon: FontAwesomeIcons.person),
        DestructibleItem(
            onTap: () => DestructibleSeleccionableSheet.show(
                  context,
                  titulo: "Eliminar hilo",
                  onAccept: () {
                    EliminarHiloUsecase usecase = GetIt.I.get();
                    usecase
                        .handle(EliminarHiloParams())
                        .then((value) => value.fold(
                              (l) => null,
                              (r) => null,
                            ));
                  },
                ),
            destructiveColor: Colors.red,
            nombre: "Eliminar hilo",
            icon: FontAwesomeIcons.trash)
      ]));
    }

    return SliverMainAxisGroup(
      slivers: ItemGrupoSliverList.GenerarSlivers(opciones),
    );
  }

  static void show(BuildContext context) {
    SliverBottomSheet.show(
      context,
      child: const OpcionesDePortadaBottomSheet(),
    );
  }
}

class SeleccionarRazonDeDenuncia extends StatelessWidget {
  final void Function(OpcionDeDenunciaHilo razon) onSeleccionada;
  const SeleccionarRazonDeDenuncia({super.key, required this.onSeleccionada});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: OpcionDeDenunciaHilo.values.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(OpcionDeDenunciaHilo.values[index].name),
      ),
    );
  }

  static void show(BuildContext context,
      {required void Function(OpcionDeDenunciaHilo razon) onSeleccionada}) {
    SliverBottomSheet.show(
      context,
      child: SeleccionarRazonDeDenuncia(onSeleccionada: onSeleccionada),
    );
  }
}

enum OpcionDeDenunciaHilo { ilegal, otro }

abstract class CustomSnackbar extends StatelessWidget {
  final Color background;
  final String titulo;
  const CustomSnackbar(
      {super.key, required this.background, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
