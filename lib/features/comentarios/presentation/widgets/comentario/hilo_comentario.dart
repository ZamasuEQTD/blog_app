import 'package:blog_app/features/comentarios/presentation/widgets/comentario/opciones_de_comentario.dart';
import 'package:blog_app/features/comentarios/presentation/widgets/comentario/widgets/comentario_texto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../media/presentation/widgets/multi_media.dart';
import '../../../domain/models/comentario.dart';
import 'widgets/comentario_color.dart';
import 'widgets/comentario_tags.dart';

class HiloComentario extends StatelessWidget {
  final Comentario comentario;

  const HiloComentario({super.key, required this.comentario});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ColoredBox(
          color: Theme.of(context).colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            child: Provider.value(
              value: comentario,
              builder: (context, child) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onLongPress: () => OpcionesDeComentarioBottomSheet.show(
                  context,
                  comentario: comentario,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ComentarioInfoRow(),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      runSpacing: 2,
                      spacing: 5,
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
                    const SizedBox(
                      height: 5,
                    ),
                    if (comentario.media != null)
                      comentario.media!.spoileable.widget,
                    const ComentarioTexto(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ComentarioInfoRow extends StatelessWidget {
  const ComentarioInfoRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Comentario comentario = context.read();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const ComentarioColor(),
            const SizedBox(
              width: 3,
            ),
            Row(
              children: [
                Text(
                  comentario.autor.nombre,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const ComentarioTags(),
              ],
            ),
          ],
        ),
        Text(
          comentario.creado_en.toString(),
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}

class HiloComentarioSkeleton extends StatelessWidget {
  const HiloComentarioSkeleton({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ColoredBox(
          color: Theme.of(context).colorScheme.surface,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Bone.square(size: 50),
                    Bone.text(
                      width: 50,
                    ),
                    Bone.text(
                      width: 100,
                    ),
                  ],
                ),
                Bone.multiText(lines: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
