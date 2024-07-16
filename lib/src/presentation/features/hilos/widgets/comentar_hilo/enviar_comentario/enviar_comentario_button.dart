import 'package:blog_app/src/presentation/features/hilos/logic/bloc/comentar_hilo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnviarComentarioButton extends StatelessWidget {
  const EnviarComentarioButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComentarHiloBloc, ComentarHiloState>(
      builder: (context, state) {
        return IconButton.filled(
            onPressed: () => context.read<ComentarHiloBloc>().add(EnviarComentario()),
            icon: state.status == ComentarHiloStatus.enviando? const CircularProgressIndicator() : Icon(Icons.send)
          );
      },
    );
  }
}
