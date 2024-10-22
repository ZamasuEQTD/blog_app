// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:blog_app/common/widgets/inputs/decorations/decorations.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/item_seleccionable.dart';

import '../../../app/presentation/widgets/colored_icon_button.dart';
import '../../../media/presentation/logic/blocs/gestor_de_media/gestor_de_media_bloc.dart';
import '../../../media/presentation/miniatura.dart';
import '../blocs/comentar_hilo/comentar_hilo_bloc.dart';

class ComentarHiloBottomSheet extends StatelessWidget {
  const ComentarHiloBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<GestorDeMediaBloc, GestorDeMediaState>(
              builder: (context, state) {
                return Row(
                  children: state.medias
                      .map(
                        (x) => GestureDetector(
                          onTap: () => context
                              .read<GestorDeMediaBloc>()
                              .add(const EliminarMedia()),
                          child: GestureDetector(
                            onTap: () {},
                            child: Miniatura(
                              key: UniqueKey(),
                              media: x,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            Row(
              children: [
                ColoredIconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.three_k_rounded),
                ),
                const _ComentarInput(),
                ColoredIconButton(
                  onPressed: () =>
                      context.read<ComentarHiloBloc>().add(EnviarComentario()),
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ComentarInput extends StatefulWidget {
  const _ComentarInput({super.key});

  @override
  State<_ComentarInput> createState() => __ComentarInputState();
}

class __ComentarInputState extends State<_ComentarInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.addListener(
      () => context.read<ComentarHiloBloc>().add(
            CambiarComentario(
              comentario: _controller.text,
            ),
          ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const InputDecorationTheme();
    return BlocListener<ComentarHiloBloc, ComentarHiloState>(
      listenWhen: (previous, current) => previous.taggueo != current.taggueo,
      listener: (context, state) {
        if (state.taggueo != null) {
          _controller.text = '${_controller.text}>>${state.taggueo}';
        }
      },
      child: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: !isKeyboardVisible ? 1 : 4,
            ),
          ),
        ),
      ),
    );
  }
}

abstract class OpcionDeComentario extends StatelessWidget {
  const OpcionDeComentario._({super.key});
  const factory OpcionDeComentario({
    required void Function() onTap,
    required String opcion,
  }) = _OpcionDeComentario;
}

class _OpcionDeComentario extends OpcionDeComentario {
  final String opcion;
  final void Function() onTap;

  const _OpcionDeComentario({
    required this.opcion,
    required this.onTap,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return ItemSeleccionable.text(titulo: opcion, onTap: onTap);
  }
}

class _AgregarEnlace extends OpcionDeComentario {
  const _AgregarEnlace() : super._();

  @override
  Widget build(BuildContext context) {
    return OpcionDeComentario(onTap: () {}, opcion: "Agregar enlace");
  }
}

class AgregarMedia extends OpcionDeComentario {
  const AgregarMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return OpcionDeComentario(onTap: () {}, opcion: "Agregar desde galeria");
  }
}
