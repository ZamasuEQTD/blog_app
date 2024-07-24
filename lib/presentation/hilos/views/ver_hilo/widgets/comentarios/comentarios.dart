import 'dart:collection';

import 'package:blog_app/domain/features/comentarios/entities/comentario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/comentarios/comentarios_bloc.dart';
import 'comentario/comentario.dart';

class ListaDeComentarios extends StatefulWidget {
  const ListaDeComentarios({super.key});

  @override
  State<ListaDeComentarios> createState() => _ComentariosDeHiloState();
}

class _ComentariosDeHiloState extends State<ListaDeComentarios> {
  final HashMap<String, GlobalKey> _keys = HashMap();

  @override
  void initState() {
    context.read<ComentariosBloc>().add(CargarComentarios());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ComentariosBloc, ComentariosState>(
      listener: (context, state) {
        for (var c in state.comentarios) {
          if (!_keys.containsKey(c.id)) {
            _keys[c.id] = GlobalKey();
          }
        }
      },
      child: BlocBuilder<ComentariosBloc, ComentariosState>(
          builder: (context, state) {
        List<Comentario> comentarios = state.comentarios;
        return SliverList.builder(
          itemCount: comentarios.length,
          itemBuilder: (context, index) {
            return ComentarioDeHiloWidget(comentario: comentarios[index]);
          },
        );
      }),
    );
  }
}
