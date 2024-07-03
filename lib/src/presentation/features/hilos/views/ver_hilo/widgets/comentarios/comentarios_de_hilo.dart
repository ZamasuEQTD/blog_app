import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:blog_app/src/domain/features/comentarios/models/comentario.dart';
import 'package:blog_app/src/domain/features/comentarios/models/types/comentario_id.dart';
import 'package:blog_app/src/domain/features/hilos/models/types/hilo_id.dart';
import 'package:blog_app/src/domain/features/media/models/fuente_de_archivo.dart';
import 'package:blog_app/src/domain/features/media/models/media.dart';
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
  @override
  void initState() {
    this.bloc = context.read();
    ListaDeComentariosBloc bloc = context.read();

    IComentariosDeHiloHub hub = ComentariosDeHiloHub(comentarios: bloc.state);

    hub.onEliminarComentario((id) {
      bloc.add(EliminarComentario(id: id));
      keys.remove(id);
    });

    hub.onHiloComentado((comentario) {
      bloc.add(AgregarComentarioAlInicio(comentario: comentario));
      keys[comentario.id] = GlobalKey();
    });


    scrollController = context.read();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) => onNotification(notification),
      child: BlocListener<ComentariosDeHiloBloc, ComentariosDeHiloState>(
        listenWhen: (previous, current) => current.status == ComentariosDeHiloStatus.cargados,
        listener: (context, state) {
          for (var c in state.comentarios) {
            keys[c.id] = GlobalKey();
          }
        },
        child: BlocBuilder<ComentariosDeHiloBloc, ComentariosDeHiloState>(
          builder: (context, state) {
            final bool cargando = state.status == ComentariosDeHiloStatus.cargando;          
            return BlocBuilder<ListaDeComentariosBloc, List<Comentario>>(
              builder: (context, state) {
                return ListView.builder(
                  key: _key,
                  physics: context.read(),
                  itemCount: state.length + (cargando ? 5 : 0),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if(state.length < index){
                      return Container();
                    }
                    return ComentarioWidget(
                      comentario: state[index], key: keys[state[index].id]
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
    Timer.periodic(Duration(seconds: 3), (timer) {
      on(
        comentarios[Random().nextInt(comentarios.length)].id
      );
    });
  }

  @override
  void onHiloComentado(void Function(Comentario comentario) on) {
    // TODO: implement onHiloComentado
  }
}