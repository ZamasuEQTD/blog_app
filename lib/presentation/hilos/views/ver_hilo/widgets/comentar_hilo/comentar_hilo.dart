import 'package:blog_app/common/widgets/button/filled_icon_button.dart';
import 'package:blog_app/common/widgets/inputs/decorations/decorations.dart';
import 'package:blog_app/presentation/hilos/views/ver_hilo/logic/bloc/comentar_hilo/comentar_hilo_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get_it/get_it.dart';

class ComentarHiloBottomSheet extends StatelessWidget {
  const ComentarHiloBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ComentarHiloBloc(GetIt.I.get()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColoredIconButton(
              onPressed: () =>
                  context.read<ComentarHiloBloc>().add(EnviarComentario()),
              icon: const Icon(Icons.attach_email),
            ),
            const SizedBox(width: 6),
            const ComentarioInput(),
            const SizedBox(width: 6),
            const EnviarComentarioButton()
          ],
        ),
      ),
    );
  }
}

class ComentarioInput extends StatefulWidget {
  const ComentarioInput({super.key});

  @override
  State<ComentarioInput> createState() => _ComentarioInputState();
}

class _ComentarioInputState extends State<ComentarioInput> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.addListener(
      ()=> context.read<ComentarHiloBloc>().add(CambiarComentario(comentario: controller.text))
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ComentarHiloBloc, ComentarHiloState>(
      listenWhen: (previous, current) => previous.ultimoTaggueo != current.ultimoTaggueo,
      listener: (context, state) {
        controller.value = TextEditingValue(
          text: "${state.texto}>>${state.ultimoTaggueo}"
        );
      },
      child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: !isKeyboardVisible ? 1 : 4,
            decoration: FlatInputDecoration(
              borderRadius: 15,
              hintText: "Escribe tu comentario..."
            ),
          ),
        );
      })
    );
  }
}

class EnviarComentarioButton extends StatelessWidget {
  const EnviarComentarioButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComentarHiloBloc, ComentarHiloState>(
      builder: (context, state) {
        return ColoredIconButton(
            onPressed: () =>
                context.read<ComentarHiloBloc>().add(EnviarComentario()),
            icon: _getIcon(state));
      },
    );
  }

  Widget _getIcon(ComentarHiloState state) =>
      state.status == ComentarHiloStatus.enviando
          ? const CircularProgressIndicator()
          : const Icon(Icons.send_rounded);
}

class ColoredIconButton extends IconButton {
  const ColoredIconButton(
      {super.key, required super.onPressed, required super.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: CupertinoColors.secondarySystemFill,
        ),
        child: super.build(context));
  }
}
