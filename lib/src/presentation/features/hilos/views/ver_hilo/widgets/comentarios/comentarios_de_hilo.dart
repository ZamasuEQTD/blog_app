import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:blog_app/src/domain/features/comentarios/models/comentario.dart';
import 'package:blog_app/src/domain/features/comentarios/models/types/comentario_id.dart';
import 'package:dartz/dartz_unsafe.dart';
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
    bloc = context.read();

    bloc.stream.listen((state) { 
      for (var c in state.comentarios) { 
        if(!keys.containsKey(c.id)){
          keys[c.id] = GlobalKey();
        }
      }
    });

    scrollController = context.read();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) => onNotification(notification),
      child: BlocBuilder<ComentariosDeHiloBloc, ComentariosDeHiloState>(
        bloc: bloc,
        builder: (context, state) {
          final bool cargando = state.status == ComentariosDeHiloStatus.cargando;          
          return ListView.builder(
                key: _key,
                controller: scrollController,
                itemCount: state.comentarios.length + (cargando ? 5 : 0),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if(state.comentarios.length < index){
                    return Container();
                  }
                  return ComentarioWidget(
                    comentario: state.comentarios[index], key: keys[state.comentarios[index].id]
                  );
                },
              );
        },
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