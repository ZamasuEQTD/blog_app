import 'dart:developer';

import 'package:blog_app/common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import 'package:blog_app/common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import 'package:blog_app/features/hilos/domain/models/comentario.dart';
import 'package:blog_app/features/hilos/presentation/screens/hilo/widgets/comentario/widgets/colores.dart';
import 'package:blog_app/features/media/presentation/widgets/media_box/media_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../common/domain/services/horarios_service.dart';
import '../../../../../../../common/widgets/media/widgets/spoiler_media.dart';
import '../../abrir_enlace_externo_bottom_sheet.dart';
import 'widgets/tags.dart';

class ComentarioCard extends StatelessWidget {
  final ComentarioModel comentario;
  const ComentarioCard({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffF5F5F5),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                      onTap: () {
                        log(tag);
                      },
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
            const SizedBox(
              height: 5,
            ),
            if (comentario.media != null)
              MediaEnComentario(comentario: comentario),
            TextoDeComentario(
              comentario: comentario,
            ),
          ],
        ),
      ),
    );
  }
}

class ComentarioInfoRow extends StatelessWidget {
  const ComentarioInfoRow({
    super.key,
    required this.comentario,
  });

  final ComentarioModel comentario;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ColorDeComentario(comentario: comentario),
              Row(
                children: [
                  const SizedBox(width: 5),
                  Text(
                    comentario.autor.nombre,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 5),
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
          ),
        ],
      ),
    );
  }
}

class MediaEnComentario extends StatelessWidget {
  const MediaEnComentario({
    super.key,
    required this.comentario,
  });

  final ComentarioModel comentario;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: MultiMediaDisplay(
        media: comentario.media!.spoileable,
        dimensionableBuilder: (child) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: MediaSpoileable(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 400,
                  maxWidth: double.infinity,
                ),
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}

class TextoDeComentario extends StatelessWidget {
  static final RegExp _tag = RegExp(">>[A-Z0-9]{7}");
  static final RegExp _url = RegExp(
    r'(https:\/\/www\.|http:\/\/www\.|https:\/\/|http:\/\/)?[a-zA-Z0-9]{2,}(\.[a-zA-Z0-9]{2,})(\.[a-zA-Z0-9]{2,})?',
  );

  final ComentarioModel comentario;

  String get texto => comentario.texto;

  const TextoDeComentario({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> spans = [];
    int currentIndex = 0;

    var tags = _tag.allMatches(texto).map((x) => (x, true));
    var urls = _url.allMatches(texto).map((x) => (x, false));

    var matches = [
      ...tags,
      ...urls,
    ]..sort(
        (a, b) => (a.$1.start.compareTo(b.$1.start)),
      );

    for (final match in matches) {
      final Match m = match.$1;
      // Agregar el texto sin resaltar antes de la coincidencia
      spans.add(
        TextSpan(
          style: const TextStyle(color: Colors.black),
          text: texto.substring(currentIndex, m.start),
        ),
      );

      // Agregar el texto resaltado
      spans.add(
        TextSpan(
          text: m.group(0),
          style: const TextStyle(
            color: CupertinoColors.link,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              if (!match.$2) {
                AbrirEnlaceExternoBottomSheet.show(
                  context,
                  url: m.group(0).toString(),
                );
              } else {}
            },
        ),
      );

      currentIndex = m.end;
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

class ComentarioCardCargando extends StatelessWidget {
  const ComentarioCardCargando({super.key});
  @override
  Widget build(BuildContext context) {
    return Skeletonizer.zone(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: const BoxDecoration(
          color: Color(0xfff5f5f5),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Row(
                  children: [
                    Bone.square(
                      size: 50,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    const SizedBox(width: 5),
                    Row(
                      children: [
                        Bone(
                          width: 60,
                          height: 16,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Bone(
                          width: 60,
                          height: 16,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Bone.multiText(
              lines: 3,
              borderRadius: BorderRadius.circular(5),
            ),
          ],
        ),
      ),
    );
  }
}
