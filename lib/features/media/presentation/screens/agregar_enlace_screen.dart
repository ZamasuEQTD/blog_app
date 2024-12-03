import 'package:blog_app/features/media/domain/services/youtube_service.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

typedef OnEnlaceAgregado = void Function(String enlace);

class AgregarEnlaceScreen extends StatefulWidget {
  const AgregarEnlaceScreen({super.key});

  @override
  State<AgregarEnlaceScreen> createState() => _AgregarEnlaceScreenState();
}

class _AgregarEnlaceScreenState extends State<AgregarEnlaceScreen> {
  final List<IEnlaceValidator> validadores = [YoutubeEnlaceValidator()];

  final TextEditingController enlace = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Agregar enlace",
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (validadores.every((v) => v.validate(enlace.text))) {
                context.read<OnEnlaceAgregado>()(enlace.text);
                context.pop();
                return;
              }
              context.showFlash(
                builder: (context, controller) {
                  return FlashBar(
                    controller: controller,
                    content: const Text("Enlace invalido"),
                  );
                },
              );
            },
            child: const Text("Aceptar"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: enlace,
              minLines: 5,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText:
                    "Enlace... de momento solamente se aceptan enlaces videos de youtube",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

abstract class IEnlaceValidator {
  bool validate(String enlace);
}

class YoutubeEnlaceValidator extends IEnlaceValidator {
  @override
  bool validate(String enlace) {
    return YoutubeService.EsVideoOrShort(enlace);
  }
}
