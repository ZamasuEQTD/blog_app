import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../app/presentation/logic/horarios_service.dart';
import '../../domain/models/comentario.dart';
import 'colores.dart';
import 'tags.dart';

abstract class ComentarioCard extends StatelessWidget {
  const ComentarioCard._({super.key});

  const factory ComentarioCard({
    Key? key,
    required Widget child,
  }) = _ComentarioCard;

  const factory ComentarioCard.comentario({
    Key? key,
    required Comentario comentario,
  }) = _ComentarioCardEntity;
}

class _ComentarioCard extends ComentarioCard {
  final Widget child;

  const _ComentarioCard({super.key, required this.child}) : super._();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ColoredBox(
          color: Theme.of(context).colorScheme.onSurface,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _ComentarioCardEntity extends ComentarioCard {
  final Comentario comentario;

  const _ComentarioCardEntity({
    super.key,
    required this.comentario,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return ComentarioCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ComentarioInfoRow(comentario: comentario),
          Wrap(
            runSpacing: 2,
            spacing: 3,
            children: comentario.tags
                .map(
                  (tag) => GestureDetector(
                    onTap: () {},
                    child: Text(
                      ">>$tag",
                      style: const TextStyle(
                        color: CupertinoColors.link,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          if (comentario.media != null)
            _Texto(
              comentario: comentario,
            ),
        ],
      ),
    );
  }
}

class _Texto extends StatelessWidget {
  static final RegExp _tag = RegExp(">>[A-Z0-9]{7}");
  static final RegExp _greenText = RegExp(">>[A-Z0-9]{7}");
  static final RegExp _url = RegExp(
    r'(https:\/\/www\.|http:\/\/www\.|https:\/\/|http:\/\/)?[a-zA-Z0-9]{2,}(\.[a-zA-Z0-9]{2,})(\.[a-zA-Z0-9]{2,})?',
  );

  static final Map<RegExp, Maker> _makers = {
    _tag: (context, match) => TextSpan(
          text: match.group(0),
          style: const TextStyle(
            color: CupertinoColors.link,
          ),
          recognizer: TapGestureRecognizer()..onTap = () {},
        ),
    _greenText: (context, match) => TextSpan(
          text: match.group(0),
          style: const TextStyle(
            color: CupertinoColors.activeGreen,
          ),
        ),
    _url: (context, match) => TextSpan(
          text: match.group(0),
          style: const TextStyle(
            color: CupertinoColors.activeGreen,
          ),
        ),
  };

  final Comentario comentario;

  String get texto => comentario.texto;

  const _Texto({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
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
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

class ComentarioInfoRow extends StatelessWidget {
  const ComentarioInfoRow({
    super.key,
    required this.comentario,
  });

  final Comentario comentario;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ColorDeComentario(comentario: comentario),
            const SizedBox(
              width: 3,
            ),
            Row(
              children: [
                Text(
                  comentario.op.nombre,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TagsDeComentarios(comentario: comentario),
              ],
            ),
          ],
        ),
        Text(
          HorariosService.diferencia(
            utcNow: DateTime.now().toUtc(),
            time: comentario.creado_en,
          ).toString(),
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

typedef Maker = TextSpan Function(BuildContext context, Match match);
