// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:blog_app/features/auth/presentation/widgets/bottom_sheet/sesion_requerida_bottomsheet.dart';
import 'package:blog_app/features/moderacion/domain/models/vista_de_usuario.dart';
import 'package:blog_app/features/moderacion/presentation/logic/bloc/ver_usuario/ver_usuario_bloc.dart';
import 'package:blog_app/features/moderacion/presentation/ver_usuario_panel/widgets/historial_de_comentarios/historial_de_comentarios.dart';
import 'package:blog_app/features/moderacion/presentation/ver_usuario_panel/widgets/historial_de_comentarios/logic/historial_de_comentarios/historial_de_comentarios_bloc.dart';
import 'package:blog_app/features/moderacion/presentation/ver_usuario_panel/widgets/historial_de_hilos/historial_de_hilos.dart';

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
                  usuario: state.usuario!,
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
              onPressed: () {},
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

class _SeleccionarHistorial extends StatelessWidget {
  const _SeleccionarHistorial({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: const ColoredBox(
          color: Color(0xffF5F5F5),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Row(
              children: [
                SeleccionarHistorialButton.hilos(),
                SeleccionarHistorialButton.comentarios(),
              ],
            ),
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
                child: SizedBox.square(
                  dimension: 70,
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.user,
                      size: 35,
                    ),
                  ),
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

abstract class SeleccionarHistorialButton extends StatelessWidget {
  const SeleccionarHistorialButton._({super.key});

  const factory SeleccionarHistorialButton({
    required void Function() onTap,
    required bool seleccionado,
    required Widget child,
  }) = _SeleccionarHistorialButton;

  const factory SeleccionarHistorialButton.comentarios() =
      _SeleccionarHistorialDeComentarios;

  const factory SeleccionarHistorialButton.hilos() =
      _SeleccionarHistorialDeHilos;
}

class _SeleccionarHistorialButton extends SeleccionarHistorialButton {
  final void Function() onTap;
  final bool seleccionado;
  final Widget child;
  const _SeleccionarHistorialButton({
    required this.onTap,
    required this.seleccionado,
    required this.child,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    Widget child = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: this.child,
    );

    if (seleccionado) {
      child = ColoredBox(color: Theme.of(context).scaffoldBackgroundColor);
    }

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: child,
        ),
      ),
    );
  }
}

class _SeleccionarHistorialDeHilos extends SeleccionarHistorialButton {
  const _SeleccionarHistorialDeHilos() : super._();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerUsuarioBloc, VerUsuarioState>(
      builder: (context, state) {
        bool seleccionado() {
          return state.tipoDeHistorial == TipoDeHistorial.hilos;
        }

        void onTap() => context.read<VerUsuarioBloc>().add(
              const CambiarTipoDeHistorial(tipo: TipoDeHistorial.hilos),
            );

        return SeleccionarHistorialButton(
          onTap: () => onTap,
          seleccionado: seleccionado(),
          child: const Row(
            children: [
              FaIcon(
                FontAwesomeIcons.noteSticky,
                size: 20,
                color: Colors.black,
              ),
              SizedBox(width: 8),
              Text(
                "Hilos",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SeleccionarHistorialDeComentarios extends SeleccionarHistorialButton {
  const _SeleccionarHistorialDeComentarios() : super._();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerUsuarioBloc, VerUsuarioState>(
      builder: (context, state) {
        bool seleccionado() {
          return state.tipoDeHistorial == TipoDeHistorial.comentarios;
        }

        void onTap() => context.read<VerUsuarioBloc>().add(
              const CambiarTipoDeHistorial(tipo: TipoDeHistorial.comentarios),
            );

        return SeleccionarHistorialButton(
          onTap: () => onTap,
          seleccionado: seleccionado(),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.message,
                size: 20,
                color: Colors.black,
              ),
              SizedBox(width: 8),
              Text(
                "Comentarios",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
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
