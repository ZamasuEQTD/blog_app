import 'package:blog_app/src/domain/shared/models/spoileable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../domain/features/comentarios/models/comentario.dart';
import 'widgets/features/comentario_features_data.dart';
import 'widgets/media/comentario_media.dart';
import 'widgets/texto_de_comentario.dart';

class ComentarioWidget extends StatelessWidget {
  final Comentario comentario;
  const ComentarioWidget({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _onLongPress,
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromRGBO(233, 233, 233, 1),
            borderRadius: BorderRadius.circular(15)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 8,vertical:5),
        child:  ComentarioContainer(comentario: comentario),
      ),
    );
  }

  void _onLongPress() {

  }
}

class ComentarioContainer extends StatelessWidget {
  const ComentarioContainer({
    super.key,
    required this.comentario,
  });

  final Comentario comentario;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComentarioDataFeatures(comentario: comentario),
        ComentarioMedia(media: comentario.media != null? Spoileable(false, comentario.media!): null),
        TextoDeComentario(texto: comentario.texto)
      ],
    );
  }
}

