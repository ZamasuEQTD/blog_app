import 'package:blog_app/src/presentation/features/hilos/widgets/comentar_hilo/enviar_comentario/enviar_comentario_button.dart';
import 'package:blog_app/src/presentation/features/hilos/widgets/comentar_hilo/input/comentario_input.dart';
import 'package:blog_app/src/presentation/features/hilos/widgets/comentar_hilo/opciones/opciones_de_comentario_button.dart';
import 'package:flutter/material.dart';

class ComentarHilo extends StatelessWidget {
  const ComentarHilo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OpcionesDeComentarioButton(),
        ComentarioInput(),
        EnviarComentarioButton()
      ],
    );
  }
}
