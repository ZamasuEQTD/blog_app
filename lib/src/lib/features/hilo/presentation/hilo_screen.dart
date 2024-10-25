import 'package:blog_app/src/lib/features/categorias/presentation/subcategoria_tile.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/models/comentario.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/src/lib/features/hilo/presentation/widgets/banderas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../comentarios/presentation/widgets/comentario.dart';
import '../../media/presentation/logic/blocs/gestor_de_media/gestor_de_media_bloc.dart';
import '../../media/presentation/multi_media.dart';
import '../domain/models/hilo.dart';
import 'blocs/comentar_hilo/comentar_hilo_bloc.dart';
import 'blocs/hilo/hilo_bloc.dart';
import 'widgets/acciones.dart';
import 'widgets/comentar_hilo.dart';

class HiloScreen extends StatelessWidget {
  final String id;
  const HiloScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AlturaController(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GestorDeMediaBloc(),
          ),
          BlocProvider(
            create: (context) => ComentarHiloBloc(),
          ),
          BlocProvider(create: (context) => HiloBloc(id)..add(CargarHilo())),
        ],
        child: Scaffold(
          bottomSheet: const ComentarHiloBottomSheet(),
          body: BlocBuilder<HiloBloc, HiloState>(
            builder: (context, state) {
              if (state.status == HiloStatus.cargado) {
                return Container(
                  margin: EdgeInsets.only(
                    bottom: context.watch<AlturaController>().altura,
                  ),
                  child: CustomScrollView(
                    slivers: [
                      InformacionDeHilo(hilo: state.hilo!),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class InformacionDeHilo extends StatelessWidget {
  final Hilo hilo;
  const InformacionDeHilo({super.key, required this.hilo});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(7),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          color: Color(0xfff5f5f5),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BanderasDeHiloRow(hilo: hilo),
                SubcategoriaTile(subcategoria: hilo.categoria),
                HiloAccionesRow(
                  hilo: hilo,
                ),
                Center(
                  child: DimensionableScope(
                    borderRadius: BorderRadius.circular(10),
                    constraints: const BoxConstraints(
                      maxHeight: 300,
                      maxWidth: double.infinity,
                    ),
                    builder: (context, dimensionable) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: dimensionable,
                      );
                    },
                    child: MultiMedia(
                      media: hilo.portada.spoileable,
                    ),
                  ),
                ),
                Text(
                  hilo.titulo,
                  style: const TituloStyle(),
                ),
                Text(
                  hilo.descripcion,
                  style: const TextStyle(fontSize: 18),
                ),
              ]
                  .map(
                    (w) => Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: w,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class ComentariosEnHilo extends StatefulWidget {
  const ComentariosEnHilo({super.key});

  @override
  State<ComentariosEnHilo> createState() => _ComentariosEnHiloState();
}

class _ComentariosEnHiloState extends State<ComentariosEnHilo> {
  final Map<ComentarioId, GlobalKey> keys = {};

  @override
  Widget build(BuildContext context) {
    return BlocListener<HiloBloc, HiloState>(
      listenWhen: (previous, current) =>
          current.comentariosState is ComentariosCargadosState,
      listener: (context, state) {
        List<Comentario> comentarios =
            (state.comentariosState as ComentariosCargadosState).comentarios;

        for (var c in comentarios) {
          keys[c.id] = GlobalKey();
        }
      },
      child: BlocBuilder<HiloBloc, HiloState>(
        builder: (context, state) {
          return SliverList.builder(
            itemCount: state.comentarios.length,
            itemBuilder: (context, index) {
              return ComentarioCard.comentario(
                key: keys[state.comentarios[index].id],
                comentario: state.comentarios[index],
              );
            },
          );
        },
      ),
    );
  }
}

class TituloStyle extends TextStyle {
  const TituloStyle() : super(fontSize: 29, fontWeight: FontWeight.w900);
}

class AlturaController extends ChangeNotifier {
  double altura = 0;

  void cambiar(double altura) {
    this.altura = altura;
    notifyListeners();
  }
}

class HiloScreenCargando extends StatelessWidget {
  const HiloScreenCargando({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MediaSpoileable extends StatelessWidget {
  final Widget child;
  const MediaSpoileable({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container();
    //return BlurBuilder(
    //   builder: (context, child, controller) {
    //     return Stack(
    //       children: [
    //         child,
    //         controller.blurear
    //             ? Positioned.fill(
    //                 child: Center(
    //                   child: _VerContenidoButton(
    //                     controller: controller,
    //                   ),
    //                 ),
    //               )
    //             : const SizedBox(),
    //       ],
    //     );
    //   },
    //   child: child,
    // );
  }
}

// class _VerContenidoButton extends StatelessWidget {
//   final BlurController controller;
//   const _VerContenidoButton({
//     super.key,
//     required this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//       onPressed: () => controller.switchBlur(),
//       style: ButtonStyle(
//         backgroundColor: WidgetStatePropertyAll(Colors.white.withOpacity(0.15)),
//         side: const WidgetStatePropertyAll(
//           BorderSide(width: 0.5, color: Colors.transparent),
//         ),
//         shape: const WidgetStatePropertyAll(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(30)),
//           ),
//         ),
//         padding: const WidgetStatePropertyAll(
//           EdgeInsets.symmetric(vertical: 20, horizontal: 30),
//         ),
//       ),
//       child: const Text(
//         "Ver contenido",
//         style: TextStyle(
//           fontSize: 20,
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }