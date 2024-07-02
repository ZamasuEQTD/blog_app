import 'dart:collection';
import 'dart:math' as math;

import 'package:blog_app/src/domain/features/hilos/models/hilo.dart';
import 'package:blog_app/src/domain/features/media/models/fuente_de_archivo.dart';
import 'package:blog_app/src/domain/features/media/models/media.dart';
import 'package:blog_app/src/domain/shared/models/spoileable.dart';
import 'package:blog_app/src/presentation/features/hilos/views/ver_hilo/widgets/body/hilo_body.dart';
import 'package:blog_app/src/presentation/features/hilos/views/ver_hilo/widgets/comentarios/comentarios_de_hilo.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import 'widgets/comentarios/logic/bloc/comentarios_de_hilo_bloc.dart';

class VerHiloView extends StatelessWidget {
  const VerHiloView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: VerHiloBody(),
    );
  }
}

class VerHiloBody extends StatelessWidget {
  const VerHiloBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        HiloBody(
          hilo: getHilo()
        ),
        BlocProvider(
          create: (context) =>ComentariosDeHiloBloc()..add(const CargarComentarios()),
          child: const ComentariosDeHilo(id: ""),
        )
      ],
    ));
  }

  Hilo getHilo() {
    return Hilo(
              "afa",
              "gasgas",
              "Gasga",
              DateTime.now(),
              const BanderasDeHilo(true, false, false),
              EstadoDeHilo.activo,
              Spoileable(
                  false,
                  Imagen(NetworkMedia(
                      "https://i.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=3840&format=pjpg&auto=webp&s=5b5e42b4826eb6d0f9411dcb3c319e5d9f0ee28e"))));
  }
}
