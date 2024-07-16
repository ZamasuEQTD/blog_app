import 'package:blog_app/src/presentation/features/hilos/widgets/comentar_hilo/enviar_comentario/enviar_comentario_button.dart';
import 'package:blog_app/src/presentation/features/hilos/widgets/comentar_hilo/input/comentario_input.dart';
import 'package:blog_app/src/presentation/features/hilos/widgets/comentar_hilo/opciones/opciones_de_comentario_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/comentar_hilo_bloc.dart';

class ComentarHilo extends StatelessWidget {
  const ComentarHilo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ComentarHiloBloc(),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            OpcionesDeComentarioButton(),
            SizedBox(width:6),
            ComentarioInput(),
            SizedBox(width:6),
            EnviarComentarioButton()
          ],
        ),
      ),
    );
  }
}
