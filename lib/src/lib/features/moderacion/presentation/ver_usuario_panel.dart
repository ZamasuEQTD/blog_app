import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../domain/models/usuario.dart';
import 'logic/blocs/ver_usuario_bloc.dart';

class VerUsuarioPanel extends StatelessWidget {
  final String usuario;
  const VerUsuarioPanel({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerUsuarioBloc(usuario),
      child: SliverMainAxisGroup(
        slivers: [
          BlocBuilder<VerUsuarioBloc, VerUsuarioState>(
            builder: (context, state) {
              if (state.usuario == null) {
                return Container();
              }

              return _InformacionDeUsuario(usuario: state.usuario!);
            },
          ),
          SliverToBoxAdapter(
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.error,
                ),
              ),
              child: const Text("Banear usuario"),
            ),
          ),
          const SliverToBoxAdapter(
            child: _SeleccionarHistorial(),
          ),
          BlocBuilder<VerUsuarioBloc, VerUsuarioState>(
            builder: (context, state) {
              if (state.tipoDeHistorial == TipoDeHistorial.comentarios) {
                return Container();
              }
              if (state.tipoDeHistorial == TipoDeHistorial.hilos) {
                return Container();
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}

class _InformacionDeUsuario extends StatelessWidget {
  final Usuario usuario;

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
                  "Unido desde ${usuario.registrado.day}/${usuario.registrado.month}/${usuario.registrado.year}",
                ),
              ],
            ),
          ],
        ),
      ),
    );
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

class HistorialDeComentarios extends StatelessWidget {
  const HistorialDeComentarios({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// import 'package:blog_app/common/logic/extensions/scroll_controller.dart';
// import 'package:blog_app/features/auth/presentation/widgets/bottom_sheet/sesion_requerida_bottomsheet.dart';
// import 'package:blog_app/features/media/presentation/logic/extensions/media_extensions.dart';

// import 'logic/historial_de_comentarios/historial_de_comentarios_bloc.dart';

// class HistorialDeComentarios extends StatefulWidget {
//   const HistorialDeComentarios({super.key});

//   @override
//   State<HistorialDeComentarios> createState() => _HistorialDeComentariosState();
// }

// class _HistorialDeComentariosState extends State<HistorialDeComentarios> {
//   @override
//   void initState() {
//     HistorialDeComentariosBloc bloc = context.read();
//     ScrollController controller = context.read();

//     bloc.add(CargarSiguientePagina());

//     controller.addListener(() {
//       if (controller.isBottom()) {
//         if (bloc.state.status != HistorialDeComentariosStatus.cargando) {
//           bloc.add(CargarSiguientePagina());
//         }
//       }
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HistorialDeComentariosBloc, HistorialDeComentariosState>(
//       builder: (context, state) {
//         Widget builder(BuildContext context, int index) {
//           if (index >= state.comentarios.length &&
//               state.status == HistorialDeComentariosStatus.cargando) {
//             return const ItemHistorialDeComentarioCargando();
//           }
//           return ItemHistorialDeComentario(state.comentarios[index]);
//         }

//         return SliverList.builder(
//           itemCount: state.comentarios.length +
//               (state.status == HistorialDeComentariosStatus.cargando ? 5 : 0),
//           itemBuilder: builder,
//         );
//       },
//     );
//   }
// }

// class ItemHistorialDeComentario extends StatelessWidget {
//   final HistorialDeComentarioItem comentario;
//   const ItemHistorialDeComentario(
//     this.comentario, {
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 80,
//           child: Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: SizedBox(
//                   height: 80,
//                   width: 80,
//                   child: Image(
//                     fit: BoxFit.cover,
//                     image: comentario.hilo.portada.toProvider(),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 width: 5,
//               ),
//               Flexible(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Ha comentado: ${comentario.hilo.titulo}",
//                       maxLines: 2,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w900,
//                       ),
//                     ),
//                     Flexible(child: Text(comentario.comentario)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           height: 2,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             ElevatedButton(
//               style: FlatBtnStyle().copyWith(
//                 shape: WidgetStatePropertyAll(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     side: const BorderSide(
//                       width: 1,
//                       color: Color.fromARGB(255, 237, 232, 232),
//                     ),
//                   ),
//                 ),
//                 padding: const WidgetStatePropertyAll(
//                   EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                 ),
//                 backgroundColor: const WidgetStatePropertyAll(Colors.white),
//               ),
//               onPressed: () => context.push("/hilo/${comentario.hilo.id}"),
//               child: const Text(
//                 "Ver hilo",
//                 style: TextStyle(color: Colors.black, fontSize: 17),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: 2,
//         ),
//       ],
//     );
//   }
// }

// class ItemHistorialDeComentarioCargando extends StatelessWidget {
//   const ItemHistorialDeComentarioCargando({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Skeletonizer.zone(
//       containersColor: const Color(0xfff2f2f2),
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 80,
//             child: Row(
//               children: [
//                 Bone.square(
//                   size: 80,
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                 ),
//                 SizedBox(
//                   width: 5,
//                 ),
//                 Flexible(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Flexible(
//                         child: Bone.text(
//                           words: 20,
//                           borderRadius: BorderRadius.all(Radius.circular(5)),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Flexible(
//                         child: Bone.text(
//                           words: 3,
//                           borderRadius: BorderRadius.all(Radius.circular(5)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.symmetric(vertical: 5),
//             child: const Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Bone(
//                   borderRadius: BorderRadius.all(Radius.circular(20)),
//                   width: 80,
//                   height: 40,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// abstract class HistorialItemCard extends StatelessWidget {
//   const HistorialItemCard({super.key});
// }

// class _HistorialItemCard extends HistorialItemCard {
//   @override
//   Widget build(BuildContext context) {
//     return const Column(
//       children: [
//         Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//               child: SizedBox.square(
//                 dimension: 80,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
