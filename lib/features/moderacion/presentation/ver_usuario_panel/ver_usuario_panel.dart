import 'package:blog_app/common/widgets/inputs/decorations/decorations.dart';
import 'package:blog_app/features/auth/presentation/widgets/bottom_sheet/sesion_requerida_bottomsheet.dart';
import 'package:blog_app/features/home/domain/models/home_portada_entry.dart';
import 'package:blog_app/features/home/presentation/widgets/portada/portada_card.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:blog_app/features/media/presentation/logic/extensions/media_extensions.dart';
import 'package:blog_app/features/moderacion/domain/models/historia_entry.dart';
import 'package:blog_app/features/moderacion/domain/models/vista_de_usuario.dart';
import 'package:blog_app/features/moderacion/presentation/logic/bloc/ver_usuario/ver_usuario_bloc.dart';
import 'package:blog_app/features/moderacion/presentation/ver_usuario_panel/widgets/historial_de_comentarios/historial_de_comentarios.dart';
import 'package:blog_app/features/moderacion/presentation/ver_usuario_panel/widgets/historial_de_comentarios/logic/historial_de_comentarios/historial_de_comentarios_bloc.dart';
import 'package:blog_app/features/moderacion/presentation/ver_usuario_panel/widgets/historial_de_hilos/historial_de_hilos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../auth/presentation/widgets/bottom_sheet/bottom_sheet.dart';
import 'widgets/historial_de_hilos/logic/bloc/historial_de_hilos_bloc.dart';

class VerUsuarioPanel extends StatelessWidget {
  final String usuario;
  const VerUsuarioPanel({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VerUsuarioBloc(usuario)..add(CargarUsuario()),
        ),
        BlocProvider(
          create: (context) => HistorialDeHilosBloc(),
        ),
        BlocProvider(
          create: (context) => HistorialDeComentariosBloc(),
        ),
      ],
      child: SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: BlocBuilder<VerUsuarioBloc, VerUsuarioState>(
              builder: (context, state) {
                return _InformacionDeUsuario(
                  usuario: VistaDeUsuario(
                    id: "id",
                    nombre: "nombre",
                    fechaDeRegistro: DateTime.now(),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: ElevatedButton(
              style: FlatBtnStyle(
                boderRadius: BorderRadius.circular(5),
              ).copyWith(
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.error,
                ),
              ),
              onPressed: () => BanearUsuarioBottomSheet.show(context),
              child: const Text(
                "Banear usuario",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: _SeleccionarHistorial(),
          ),
          BlocBuilder<VerUsuarioBloc, VerUsuarioState>(
            builder: (context, state) {
              switch (state.tipoDeHistorial) {
                case TipoDeHistorial.hilos:
                  return const HistorialDeHilosPosteados();
                case TipoDeHistorial.comentarios:
                  return const HistorialDeComentarios();
                default:
              }
              throw Exception("");
            },
          ),
        ],
      ),
    );
  }

  static void show(BuildContext context, {required String usuario}) =>
      SliverDraggableBottomSheet.show(
        context,
        child: VerUsuarioPanel(usuario: usuario),
      );
}

class _VerUsuarioPanelCargando extends StatelessWidget {
  const _VerUsuarioPanelCargando({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverMainAxisGroup(slivers: []);
  }
}

class _SeleccionarHistorial extends StatelessWidget {
  const _SeleccionarHistorial({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: ColoredBox(
          color: const Color(0xffF5F5F5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: SizedBox(
              child: BlocBuilder<VerUsuarioBloc, VerUsuarioState>(
                buildWhen: (previous, current) =>
                    previous.tipoDeHistorial != current.tipoDeHistorial,
                builder: (context, state) {
                  return Row(
                    children: [
                      SeleccionarHistorialBtn(
                        onTap: () => context.read<VerUsuarioBloc>()
                          ..add(
                            const CambiarTipoDeHistorial(
                              tipo: TipoDeHistorial.hilos,
                            ),
                          ),
                        icon: const FaIcon(
                          FontAwesomeIcons.noteSticky,
                          size: 20,
                          color: Colors.black,
                        ),
                        label: "Hilos",
                        seleccionado:
                            state.tipoDeHistorial == TipoDeHistorial.hilos,
                      ),
                      SeleccionarHistorialBtn(
                        onTap: () => context.read<VerUsuarioBloc>()
                          ..add(
                            const CambiarTipoDeHistorial(
                              tipo: TipoDeHistorial.comentarios,
                            ),
                          ),
                        icon: const FaIcon(
                          FontAwesomeIcons.message,
                          size: 20,
                          color: Colors.black,
                        ),
                        label: "Comentarios",
                        seleccionado: state.tipoDeHistorial ==
                            TipoDeHistorial.comentarios,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SeleccionarHistorialBtn extends StatelessWidget {
  final String label;
  final Widget icon;
  final bool seleccionado;
  final void Function() onTap;
  const SeleccionarHistorialBtn({
    super.key,
    required this.label,
    required this.icon,
    required this.seleccionado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color:
                seleccionado ? Theme.of(context).scaffoldBackgroundColor : null,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InformacionDeUsuario extends StatelessWidget {
  final VistaDeUsuario usuario;

  const _InformacionDeUsuario({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ClipOval(
              child: ColoredBox(
                color: Color(0xfff5f5f5),
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: Center(child: FaIcon(FontAwesomeIcons.user, size: 35)),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  usuario.nombre,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text(
                  "Unido desde ${usuario.fechaDeRegistro.day}/${usuario.fechaDeRegistro.month}/${usuario.fechaDeRegistro.year}",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AdvetirDeBaneo extends StatelessWidget {
  const AdvetirDeBaneo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Has sido baneado",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const _InformacionDeBaneo(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 100,
                  minWidth: double.infinity,
                ),
                child: const ColoredBox(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                    child: Text(
                      "No lo vuelvas a hacer\nokk?",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InformacionDeBaneo extends StatelessWidget {
  const _InformacionDeBaneo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Baneo {
  final String id;
  final String moderador;
  final DateTime expiracion;
  final String? texto;

  const Baneo({
    required this.id,
    required this.moderador,
    required this.expiracion,
    required this.texto,
  });
}

class BanearUsuarioBottomSheet extends StatelessWidget {
  const BanearUsuarioBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Razon",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Text(
            "Duración",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          TextField(
            decoration: FlatInputDecoration(),
          ),
        ],
      ),
    );
  }

  static show(BuildContext context) {
    DestructibleBottomSheet.show(
      context,
      titulo: "Banear usuario",
      child: const BanearUsuarioBottomSheet(),
      onAccept: () {},
    );
  }
}
