import 'package:blog_app/src/presentation/common/widgets/inputs/flat_input.dart';
import 'package:blog_app/src/presentation/features/hilos/logic/hilo/hilo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class ComentarioInput extends StatefulWidget {
  const ComentarioInput({super.key});

  @override
  State<ComentarioInput> createState() => _ComentarioInputState();
}

class _ComentarioInputState extends State<ComentarioInput> {
  late final TextEditingController controller = context.read();

  @override
  void initState() {
    controller.addListener(()=> context.read<HiloBloc>().add(CambiarComentario(comentario: controller.text)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      child: Flexible(
        child: KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible) {
            return TextField(
              controller: controller,
              minLines: 1,
              maxLines: !isKeyboardVisible? 1 : 4,
              decoration: FlatInputDecoration(
                hintText: "Escribe tu comentario..."
              ),
          );
        })
      )
    );
  }
}
