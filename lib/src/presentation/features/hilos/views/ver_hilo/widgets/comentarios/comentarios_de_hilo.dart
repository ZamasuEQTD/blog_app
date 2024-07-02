import 'dart:collection';

import 'package:blog_app/src/domain/features/comentarios/models/comentario.dart';
import 'package:blog_app/src/domain/features/hilos/models/types/hilo_id.dart';
import 'package:blog_app/src/domain/features/media/models/fuente_de_archivo.dart';
import 'package:blog_app/src/domain/features/media/models/media.dart';
import 'package:blog_app/src/domain/shared/models/spoileable.dart';
import 'package:blog_app/src/presentation/features/media/widgets/reproductor_de_video/reproductor_de_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../../../comentarios/widgets/comentario/comentario.dart';
import 'logic/bloc/comentarios_de_hilo_bloc.dart';

class ComentariosDeHilo extends StatefulWidget {
  final HiloId id;
  const ComentariosDeHilo({super.key, required this.id});

  @override
  State<ComentariosDeHilo> createState() => _ComentariosDeHiloState();
}

class _ComentariosDeHiloState extends State<ComentariosDeHilo> {
  final GlobalKey _key = GlobalKey();
  final HashMap<String, GlobalKey> keys = HashMap();
  @override
  void initState() {
    ComentariosDeHiloBloc bloc = context.read();
    for (var c in bloc.state.comentarios) {
      keys[c.id] = GlobalKey();
    }
    bloc.stream.listen((state) {
      for (var c in bloc.state.comentarios) {
        if (!keys.containsKey(c.id)) {
          keys[c.id] = GlobalKey();
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ComentariosDeHiloBloc, ComentariosDeHiloState>(
      listenWhen: (previous, current) => previous.comentarios.length != current.comentarios.length ,
      listener: (context, state) {
        
      },
      child: BlocBuilder<ComentariosDeHiloBloc, ComentariosDeHiloState>(
        builder: (context, state) {
          return Column(
            children: [
              TextButton(
                  onPressed: () {
                    ComentariosDeHiloBloc bloc = context.read();
                    bloc.add(AgregarComentario(
                        comentario: Comentario(
                            id: (state.comentarios.length + 1).toString(),
                            texto: "Textooooooo",
                            createdAt: DateTime(99),
                            datos: const DatosDeComentario(
                                tag: "tagg", tagUnico: "False", dados: "5"),
                            media: Video(NetworkMedia(
                                "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")))));
                  },
                  child: const Text("holaaa")),
              ListView.builder(
                key: _key,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.comentarios.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ComentarioWidget(
                      comentario: state.comentarios[index],
                      key: keys[state.comentarios[index].id]);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
