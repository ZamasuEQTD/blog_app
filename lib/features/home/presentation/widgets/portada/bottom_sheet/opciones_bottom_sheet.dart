import 'package:blog_app/common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import 'package:blog_app/common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import 'package:blog_app/common/widgets/seleccionable/widget/grupo_seleccionable_list.dart';
import 'package:blog_app/features/auth/domain/models/usuario.dart';
import 'package:blog_app/features/hilos/domain/usecase/agregar_a_favoritos_usecase.dart';
import 'package:blog_app/features/hilos/domain/usecase/denunciar_hilo_usecase.dart';
import 'package:blog_app/features/hilos/domain/usecase/destacar_hilo_usecase.dart';
import 'package:blog_app/features/hilos/domain/usecase/eliminar_hilo_usecase.dart';
import 'package:blog_app/features/hilos/domain/usecase/ocultar_hilo_usecase.dart';
import 'package:blog_app/features/hilos/domain/usecase/seguir_hilo_usecase.dart';
import 'package:blog_app/features/auth/presentation/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/features/home/presentation/logic/bloc/home_portadas_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

import '../../../../../auth/presentation/logic/bloc/auth/auth_bloc.dart';
import '../../../../../moderacion/presentation/ver_usuario_panel/ver_usuario_panel.dart';

class OpcionesDePortadaBottomSheet extends StatelessWidget {
  const OpcionesDePortadaBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    void denunciar() {
      SeleccionarRazonDeDenuncia.show(
        context,
        onSeleccionada: (razon) {
          DenunciarHiloUsecase usecase = GetIt.I.get();
          usecase.handle(DenunciarHiloParms()).then(
                (value) => value.fold(
                  (l) => null,
                  (r) => null,
                ),
              );
        },
      );
    }

    void seguir() {
      SeguirHiloUsecase usecase = GetIt.I.get();

      usecase.handle(SeguirHiloParams()).then(
        (value) {
          value.fold((l) => null, (r) => null);
        },
      );
    }

    void ocultar() {
      OcultarHiloUsecase usecase = GetIt.I.get();
      usecase.handle(OcultarHiloParams()).then(
        (value) {
          value.fold(
            (l) => null,
            (r) => context
                .read<HomePortadasBloc>()
                .add(const EliminarPortada(id: "")),
          );
        },
      );
    }

    void agregarFavorito() {
      AgregarAFavoritosUsecase usecase = GetIt.I.get();

      usecase.handle(AgregarAFavoritosParams()).then(
        (value) {
          value.fold((l) => null, (r) => null);
        },
      );
    }

    List<GrupoSeleccionable> opciones = [
      GrupoSeleccionable(
        seleccionables: [
          OcultarHiloOpcion(
            onTap: ocultar,
          ),
          AgregarFavorito(
            onTap: agregarFavorito,
          ),
          SeguirHilo(
            onTap: seguir,
          ),
          Denunciar(
            onTap: denunciar,
          ),
        ],
      ),
    ];

    final state = context.read<AuthBloc>().state;

    if (state is SesionIniciada && state.usuario is Moderador) {
      opciones.add(
        GrupoSeleccionable(
          seleccionables: [
            ItemSeleccionableTileList(
              nombre: "Destacar",
              onTap: () {
                DestructibleBottomSheet.show(
                  context,
                  titulo: "Destacar hilo",
                  child: const Text(
                    "Estás seguro que quieres destacar este hilo",
                  ),
                  onAccept: () {
                    DestacarHiloUsecase usecase = GetIt.I.get();
                    usecase.handle(DestacarHiloParams()).then(
                          (value) => value.fold(
                            (l) => null,
                            (r) => null,
                          ),
                        );
                  },
                );
              },
              icon: FontAwesomeIcons.thumbtack,
            ),
            ItemSeleccionableTileList(
              onTap: () => VerUsuarioPanel.show(context, usuario: ""),
              nombre: "Ver usuario",
              icon: FontAwesomeIcons.person,
            ),
            DestructibleItem(
              onTap: () => DestructibleBottomSheet.show(
                context,
                titulo: "Eliminar hilo",
                child: const Text(
                  "Estás seguro que quieres eliminar este hilo?",
                ),
                onAccept: () {
                  EliminarHiloUsecase usecase = GetIt.I.get();
                  usecase.handle(EliminarHiloParams()).then(
                        (value) => value.fold(
                          (l) => null,
                          (r) => null,
                        ),
                      );
                },
              ),
              destructiveColor: Colors.red,
              nombre: "Eliminar hilo",
              icon: FontAwesomeIcons.trash,
            ),
          ],
        ),
      );
    }

    return SliverMainAxisGroup(
      slivers: ItemGrupoSliverList.GenerarSlivers(opciones),
    );
  }

  static void show(BuildContext context) {
    SliverDraggableBottomSheet.show(
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

  static void show(
    BuildContext context, {
    required void Function(OpcionDeDenunciaHilo razon) onSeleccionada,
  }) {
    SliverBottomSheet.show(
      context,
      child: SeleccionarRazonDeDenuncia(onSeleccionada: onSeleccionada),
    );
  }
}

enum OpcionDeDenunciaHilo { ilegal, otro }

class OcultarHiloOpcion extends ItemSeleccionableTileList {
  OcultarHiloOpcion({
    required super.onTap,
  }) : super(nombre: "Ocultar", icon: FontAwesomeIcons.eye);
}

class AgregarFavorito extends ItemSeleccionableTileList {
  AgregarFavorito({
    required super.onTap,
  }) : super(nombre: "Ocultar", icon: FontAwesomeIcons.star);
}

class SeguirHilo extends ItemSeleccionableTileList {
  SeguirHilo({
    required super.onTap,
  }) : super(nombre: "Seguir", icon: FontAwesomeIcons.plus);
}

class Denunciar extends ItemSeleccionableTileList {
  Denunciar({
    required super.onTap,
  }) : super(nombre: "Denunciar", icon: FontAwesomeIcons.flag);
}
