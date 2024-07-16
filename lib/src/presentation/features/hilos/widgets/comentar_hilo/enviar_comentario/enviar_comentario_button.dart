import 'package:blog_app/src/presentation/features/hilos/logic/bloc/comentar_hilo_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnviarComentarioButton extends StatelessWidget {
  const EnviarComentarioButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComentarHiloBloc, ComentarHiloState>(
      builder: (context, state) {
        return ColoredIconButton(
            onPressed: () => context.read<ComentarHiloBloc>().add(EnviarComentario()),
            icon: _getIcon(state)
          );
      },
    );
  }

  Widget _getIcon(ComentarHiloState state) => state.status == ComentarHiloStatus.enviando? const CircularProgressIndicator() : const Icon(Icons.send_rounded);
}

class ColoredIconButton extends IconButton {
  const ColoredIconButton({super.key, required super.onPressed, required super.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: CupertinoColors.secondarySystemFill,
        ),
        child: super.build(context)
      );
  }
}
