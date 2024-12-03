import 'package:blog_app/features/media/presentation/widgets/bottom_sheet/abrir_enlace_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/comentario.dart';

typedef Maker = TextSpan Function(BuildContext context, Match match);

class ComentarioTexto extends StatelessWidget {
  static final RegExp _tag = RegExp(">>[A-Z0-9]{7}");

  static final RegExp _greenText = RegExp("dasdassadas");

  static final RegExp _url = RegExp(
    r'(https:\/\/www\.|http:\/\/www\.|https:\/\/|http:\/\/)?[a-zA-Z0-9]{2,}(\.[a-zA-Z0-9]{2,})(\.[a-zA-Z0-9]{2,})?',
  );

  static final Map<RegExp, Maker> _makers = {
    _url: (context, match) => TextSpan(
          text: match.group(0),
          style: const TextStyle(
            color: CupertinoColors.link,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              showMaterialModalBottomSheet(
                context: context,
                builder: (context) {
                  return AbrirEnlaceExternoBottomSheet(url: match.group(0)!);
                },
              );
            },
        ),
    _greenText: (context, match) => TextSpan(
          text: match.group(0),
          style: const TextStyle(
            color: CupertinoColors.systemRed,
          ),
        ),
    _tag: (context, match) => TextSpan(
          text: match.group(0),
          style: const TextStyle(
            color: CupertinoColors.systemYellow,
          ),
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
          style: const TextStyle(color: Colors.black),
          text: texto.substring(currentIndex, match.start),
        ),
      );

      // Agregar el texto resaltado
      spans.add(
        _makers[match.pattern]!(context, match),
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
