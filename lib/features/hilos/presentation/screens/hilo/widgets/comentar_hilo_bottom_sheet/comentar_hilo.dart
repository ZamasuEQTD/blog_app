// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';

import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:blog_app/features/media/presentation/widgets/media_box/media_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../common/widgets/button/filled_icon_button.dart';
import '../../../../../../../common/widgets/inputs/decorations/decorations.dart';
import '../../../../../../media/presentation/logic/bloc/bloc/gestor_de_media_bloc.dart';
import '../../../../../../media/presentation/widgets/miniatura/miniatura.dart';
import '../../../../logic/bloc/hilo/comentar_hilo/comentar_hilo_bloc.dart';
import 'comentar_hilo_opciones.dart';

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

class VerMediaBottomSheet extends StatelessWidget {
  final Media media;

  const VerMediaBottomSheet({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MediaBox(
          media: media,
          options: const MediaBoxOptions(
            constraints: BoxConstraints(
              maxHeight: 300,
              maxWidth: double.infinity,
            ),
          ),
        ),
      ],
    );
  }
}

class Normalizer extends StatefulWidget {
  const Normalizer({super.key});

  @override
  State<Normalizer> createState() => _NormalizerState();
}

class _NormalizerState extends State<Normalizer> {
  final GlobalKey key = GlobalKey();
  double height = 0;

  @override
  void initState() {
    Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        setState(() {
          height = Random().nextDouble();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (notification) {
        return true;
      },
      child: Container(
        key: key,
        child: SizedBox(
          height: height,
        ),
      ),
    );
  }
}

class WidgetAlturaController extends ChangeNotifier {
  double height = 0;

  void cambiar(double height) {
    this.height = height;
    notifyListeners();
  }
}
