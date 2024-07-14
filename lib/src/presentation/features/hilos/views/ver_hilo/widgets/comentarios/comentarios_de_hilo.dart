import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:blog_app/src/domain/features/comentarios/models/comentario.dart';
import 'package:blog_app/src/domain/features/comentarios/models/types/comentario_id.dart';
import 'package:blog_app/src/domain/features/hilos/models/types/hilo_id.dart';
import 'package:blog_app/src/domain/features/media/models/fuente_de_archivo.dart';
import 'package:blog_app/src/domain/features/media/models/media.dart';
import 'package:blog_app/src/presentation/features/comentarios/common/bottom_sheet/opciones_de_comentario/opciones_de_comentarios_bottom_sheet.dart';
import 'package:blog_app/src/presentation/features/comentarios/common/logic/bloc/lista/lista_de_comentarios_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../comentarios/widgets/comentario/comentario.dart';
import 'logic/bloc/comentarios_de_hilo/comentarios_de_hilo_bloc.dart';

class ComentariosDeHilo extends StatefulWidget {
  const ComentariosDeHilo({super.key});

  @override
  State<ComentariosDeHilo> createState() => _ComentariosDeHiloState();
}

class _ComentariosDeHiloState extends State<ComentariosDeHilo> {
  final GlobalKey _key = GlobalKey();
  final HashMap<String, GlobalKey> keys = HashMap();
  late final ScrollController scrollController;
  late final ComentariosDeHiloBloc bloc;
  late final ListaDeComentariosBloc comentarios = context.read();

  @override
  void initState() {
    bloc = context.read();

    IComentariosDeHiloHub hub = ComentariosDeHiloHub(comentarios: comentarios.state);

    hub.onEliminarComentario((id) {
      comentarios.add(EliminarComentario(id: id));
      keys.remove(id);
    });

    hub.onHiloComentado((comentario) {
      // comentarios.add(AgregarComentarioAlInicio(comentario: comentario));
      // keys[comentario.id] = GlobalKey();
    });


    scrollController = context.read();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: onNotification,
      child: BlocListener<ComentariosDeHiloBloc, ComentariosDeHiloState>(
        listener: (context, state) {
          for (var c in state.comentarios) {
            keys[c.id] = GlobalKey();
          }
          comentarios.add(AgregarComentarios(comentarios: state.comentarios));
        },
        child: BlocBuilder<ComentariosDeHiloBloc, ComentariosDeHiloState>(
          builder: (context, state) {
            final bool cargando = state.status == ComentariosDeHiloStatus.cargando;          
            return BlocBuilder<ListaDeComentariosBloc, List<Comentario>>(
              builder: (context, state) {
                return ListView.builder(
                  key: _key,
                  controller: context.read(),
                  itemCount: state.length ,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      key: keys[state[index].id],
                      onTap: () {
                        OpcionesDeComentariosBottomSheet.show(context: context,comentario: state[index]);
                      },
                      child: ComentarioWidget(
                        comentario: state[index],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  
  bool onNotification(Object? notification) {
    if (notification is ScrollEndNotification) {
      bloc.add(const CargarComentarios());
    }
    return true;
  }
}


abstract class IComentariosDeHiloHub {
  void onEliminarComentario(void Function(ComentarioId id) on);
  void onHiloComentado(void Function(Comentario comentario) on);
}

class ComentariosDeHiloHub extends IComentariosDeHiloHub {
  final List<Comentario> comentarios;

  ComentariosDeHiloHub({required this.comentarios});
  @override
  void onEliminarComentario(void Function(ComentarioId id) on) {
    // Timer.periodic(Duration(seconds: 3), (timer) {
    //   on(
    //     comentarios[Random().nextInt(comentarios.length)].id
    //   );
    // });
  }

  @override
  void onHiloComentado(void Function(Comentario comentario) on) {
    Timer.periodic(const Duration(seconds: 6), (timer) {
      on(
        Comentario(
            id: Random().nextInt(50000).toString(),
            texto: "texto",
            createdAt: DateTime.now(),
            datos: const DatosDeComentario(
                tag: "FSAFAS", tagUnico: "RDS", dados: "4"),
            media: Video(NetworkMedia("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"))),
      );
    });
  }
}