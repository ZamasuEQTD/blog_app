import 'package:blog_app/features/home/domain/models/home_portada_entry.dart';
import 'package:blog_app/features/home/presentation/widgets/portada/portada_card.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:blog_app/features/media/presentation/logic/extensions/media_extensions.dart';
import 'package:blog_app/features/moderacion/domain/models/historia_entry.dart';
import 'package:blog_app/features/moderacion/domain/models/vista_de_usuario.dart';
import 'package:blog_app/features/moderacion/presentation/logic/bloc/bloc/ver_usuario_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../common/logic/classes/spoileable.dart';
import '../../../auth/presentation/widgets/bottom_sheet/bottom_sheet.dart';

class VerUsuarioPanel extends StatelessWidget {
  final String usuario;
  const VerUsuarioPanel({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerUsuarioBloc(usuario)..add(CargarUsuario()),
      child: SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: BlocBuilder<VerUsuarioBloc, VerUsuarioState>(
              builder: (context, state) {
                return _InformacionDeUsuario(
                  usuario: VistaDeUsuario(
                    id: "id",
                    nombre: "Codubi",
                    fechaDeRegistro: DateTime.now(),
                  ),
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
                  return const _HistorialDeComentarios();
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
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: ColoredBox(
          color: const Color(0xffF5F5F5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: SizedBox(
              child: BlocBuilder<VerUsuarioBloc, VerUsuarioState>(
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
        behavior: HitTestBehavior.opaque,
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

class _HistorialDeHilos extends StatelessWidget {
  const _HistorialDeHilos({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerUsuarioBloc, VerUsuarioState>(
      builder: (context, state) => SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        sliver: SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 200,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            crossAxisCount: 2,
          ),
          itemCount: 10,
          itemBuilder: (context, index) => PortadaCard(
            portada: PortadaEntity(
              imagen: Spoileable(
                true,
                Imagen(
                  provider: const NetworkProvider(
                    path:
                        "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696",
                  ),
                ),
              ),
              id: "id",
              titulo: "Entras y esta tu prima asi",
              categoria: "NSFW",
              features: [
                HomePortadaFeatures.nuevo,
                HomePortadaFeatures.sticky,
                HomePortadaFeatures.dados,
                HomePortadaFeatures.idUnico,
              ],
              ultimoBump: DateTime.now(),
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
                color: Colors.white,
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: Center(child: FaIcon(FontAwesomeIcons.user, size: 35)),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: usuario.nombre,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: usuario.id),
                    ],
                    style: const TextStyle(color: Colors.black),
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
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(entry.descripcion),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
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
        child: Image(fit: BoxFit.cover, image: imagen.toProvider()),
      ),
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
          child: child,
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

class _HistorialDeComentarios extends StatelessWidget {
  const _HistorialDeComentarios({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 10,
      itemBuilder: (context, index) => const ComentarioDeUsuario(),
    );
  }
}

class ComentarioDeUsuario extends StatelessWidget {
  const ComentarioDeUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const ColoredBox(
                  color: Colors.red,
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Image(
                      image: NetworkImage(
                        "https://comiquetaxxx.com/wp-content/uploads/2023/10/seme-pan-rom-0-350x487.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ha comentado en: Los Momos",
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "Aguante la bornografia infaltilAguante la bornografia infaltilAguante la bornografia infaltilAguante la bornografia infaltilAguante la bornografia infaltil",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {},
              child: const Text("hola"),
            ),
          ],
        ),
      ],
    );
  }
}
