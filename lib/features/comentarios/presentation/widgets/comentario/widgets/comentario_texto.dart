import 'package:blog_app/features/hilos/presentation/screens/hilo_screen/logic/controllers/hilo_controller.dart';
import 'package:blog_app/features/media/presentation/widgets/bottom_sheet/abrir_enlace_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/comentario.dart';
import '../ver_comentario_bottom_sheet.dart';

typedef RegexWidgetBuilder = Widget Function(Match match);

class ComentarioTexto extends StatelessWidget {
  static final RegExp _tag = RegExp(">>[A-Z0-9]{8}");

  static final RegExp _greenText = RegExp(r">\w+");

  static final RegExp _url = RegExp(
    r'(https:\/\/www\.|http:\/\/www\.|https:\/\/|http:\/\/)?[a-zA-Z0-9]{2,}(\.[a-zA-Z0-9]{2,})(\.[a-zA-Z0-9]{2,})?',
  );

  static final Map<RegExp, RegexWidgetBuilder> _builders = {
    _tag: (match) => TagLink(tag: match.group(0)!),
    _url: (match) => Link(url: match.group(0)!),
    _greenText: (match) => Text(
          match.group(0)!,
          style: const TextStyle(color: CupertinoColors.systemGreen),
        ),
  };

  const ComentarioTexto({super.key});

  @override
  Widget build(BuildContext context) {
    final Comentario comentario = context.read();

    final String texto = comentario.texto;

    final List<TextSpan> spans = [];

    int currentIndex = 0;

    var matches = [
      ..._tag.allMatches(texto),
      ..._greenText.allMatches(texto),
      ..._url.allMatches(texto),
    ]..sort(
        (a, b) => (a.start.compareTo(b.start)),
      );

    for (final match in matches) {
      // Agregar el texto sin resaltar antes de la coincidencia
      spans.add(
        TextSpan(
          text: texto.substring(currentIndex, match.start),
        ),
      );

      // Agregar el texto resaltado
      spans.add(
        TextSpan(
          children: [
            WidgetSpan(child: _builders[match.pattern]!(match)),
          ],
        ),
      );

      currentIndex = match.end;
    }

    // Agregar el texto restante después de la última coincidencia
    spans.add(
      TextSpan(
        style: const TextStyle(color: Colors.black),
        text: texto.substring(currentIndex),
      ),
    );

    return RichText(
      text: TextSpan(
        children: spans,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}

class Link extends StatelessWidget {
  final String url;

  const Link({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showMaterialModalBottomSheet(
          context: context,
          builder: (context) {
            return AbrirEnlaceExternoBottomSheet(url: url);
          },
        );
      },
      child: Text(
        url,
        style: const TextStyle(
          color: CupertinoColors.link,
        ),
      ),
    );
  }
}

class TagLink extends StatelessWidget {
  final String tag;

  const TagLink({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String tagNormalized = tag.substring(2);

        var controller = Get.find<HiloController>();

        var comentario = controller.comentariosByTag[tagNormalized];

        if (comentario != null) {
          VerComentarioBottomSheet.show(context, comentario: comentario);
        }
      },
      child: Text(
        tag,
        style: const TextStyle(
          color: CupertinoColors.link,
        ),
      ),
    );
  }
}
