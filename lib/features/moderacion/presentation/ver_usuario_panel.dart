import 'package:blog_app/common/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:blog_app/features/media/presentation/logic/extensions/media_extensions.dart';
import 'package:blog_app/features/moderacion/domain/models/historia_entry.dart';
import 'package:blog_app/features/moderacion/domain/models/vista_de_usuario.dart';
import 'package:blog_app/features/moderacion/presentation/logic/bloc/bloc/ver_usuario_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VerUsuarioPanel extends StatelessWidget {
  final String usuario;
  final ScrollController controller;
  const VerUsuarioPanel(
      {super.key, required this.controller, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerUsuarioBloc(usuario)..add(CargarUsuario()),
      child: CustomScrollView(
        controller: controller,
        slivers: [
          SliverToBoxAdapter(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const ColoredBox(
                color: Colors.white, child: SizedBox(height: 15, width: 250)),
          )),
          SliverToBoxAdapter(
            child: BlocBuilder<VerUsuarioBloc, VerUsuarioState>(
              builder: (context, state) {
                return _InformacionDeUsuario(
                  usuario: state.usuario!,
                );
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: _SeleccionarHistorial(),
          ),
          BlocBuilder<VerUsuarioBloc, VerUsuarioState>(
            builder: (context, state) {
              switch (state.tipoDeHistorial) {
                case TipoDeHistorial.hilos:
                  return const _HistorialDeHilos();
                case TipoDeHistorial.comentarios:
                  return const _HistorialDeHilos();
                default:
              }

              throw Exception("");
            },
          ),
          const _HistorialDeHilos(),
        ],
      ),
    );
  }

  static void show(BuildContext context, {required String usuario}) =>
      BottomSheetManager.show(
        context,
        child: DraggableScrollableSheet(
          builder: (context, scrollController) => VerUsuarioPanel(
            controller: scrollController,
            usuario: usuario,
          ),
        ),
      );
}

class _SeleccionarHistorial extends StatelessWidget {
  const _SeleccionarHistorial({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: ColoredBox(
          color: Colors.white,
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
                          ..add(const CambiarTipoDeHistorial(
                            tipo: TipoDeHistorial.hilos,
                          )),
                        icon: const FaIcon(FontAwesomeIcons.noteSticky,
                            size: 20, color: Colors.black),
                        label: "Hilos",
                        seleccionado:
                            state.tipoDeHistorial == TipoDeHistorial.hilos,
                      ),
                      SeleccionarHistorialBtn(
                        onTap: () => context.read<VerUsuarioBloc>()
                          ..add(const CambiarTipoDeHistorial(
                            tipo: TipoDeHistorial.comentarios,
                          )),
                        icon: const FaIcon(FontAwesomeIcons.message,
                            size: 20, color: Colors.black),
                        label: "Comentarios",
                        seleccionado: state.tipoDeHistorial ==
                            TipoDeHistorial.comentarios,
                      )
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
            color: !seleccionado
                ? Theme.of(context).scaffoldBackgroundColor
                : null,
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

class _HistorialDeHilos extends StatelessWidget {
  const _HistorialDeHilos({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerUsuarioBloc, VerUsuarioState>(
        builder: (context, state) => SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              sliver: SliverList.builder(
                itemCount: 100,
                itemBuilder: (context, index) => Container(),
              ),
            ));
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
                color: Colors.white,
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: Center(child: FaIcon(FontAwesomeIcons.user, size: 35)),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(children: [
              Row(
                children: [
                  Text(
                    usuario.nombre,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text(usuario.id),
                ],
              ),
              Text("Unido desde ${usuario.fechaDeRegistro}")
            ]),
          ],
        ),
      ),
    );
  }
}

class _PostDeUsuarioCreadoHistorial extends StatelessWidget {
  final HiloCreadoHistorialEntry entry;
  const _PostDeUsuarioCreadoHistorial({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: _HistorialEntry(
        child: Row(
          children: [
            _HistoriaHiloImagen(
              imagen: entry.portada,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RichText(
                            maxLines: 1,
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                    text: entry.titulo,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        overflow: TextOverflow.ellipsis)),
                              ],
                            ),
                          ),
                          Text(entry.descripcion)
                        ]),
                  ),
                  const Icon(Icons.chevron_right)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _HistoriaHiloImagen extends StatelessWidget {
  final Imagen imagen;
  const _HistoriaHiloImagen({
    super.key,
    required this.imagen,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
          height: 120,
          width: 110,
          child: Image(fit: BoxFit.cover, image: imagen.toProvider())),
    );
  }
}

class _HistorialEntry extends StatelessWidget {
  final Widget child;
  const _HistorialEntry({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: child),
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
                      minHeight: 100, minWidth: double.infinity),
                  child: const ColoredBox(
                      color: Colors.white,
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                          child: Text(
                            "No lo vuelvas a hacer\nokk?",
                            style: TextStyle(fontSize: 17),
                          )))),
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
