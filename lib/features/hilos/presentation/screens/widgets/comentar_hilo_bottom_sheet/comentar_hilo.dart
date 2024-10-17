import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../common/widgets/button/filled_icon_button.dart';
import '../../../../../../common/widgets/inputs/decorations/decorations.dart';
import '../../../../../media/presentation/logic/bloc/bloc/gestor_de_media_bloc.dart';
import '../../../../../media/presentation/widgets/miniatura/miniatura.dart';
import '../../../logic/bloc/hilo/comentar_hilo/comentar_hilo_bloc.dart';
import '../../hilo_screen.dart';

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
                          child: Miniatura(
                            key: UniqueKey(),
                            media: x,
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
                  onPressed: () => ComentarHiloOpciones.show(context),
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
              decoration: FlatInputDecoration(
                borderRadius: 15,
                hintText: "Escribe tu comentario...",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
