import 'package:flutter/material.dart';
import '../../../../../../../domain/features/comentarios/models/comentario.dart';
import '../../../../../../common/widgets/tags/tag.dart';

class ComentarioDataFeatures extends StatelessWidget {
  final Comentario comentario;
  const ComentarioDataFeatures({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UserCommentData(comentario: comentario),
        ],
      ),
    );
  }
}


class UserProfilePhoto extends StatelessWidget {
  final String nombre;
  const UserProfilePhoto({
    super.key, 
    required this.nombre
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: 50,
        width: 50,
        color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FittedBox(
          child: Text(
            nombre,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }

}

class UserCommentData extends StatelessWidget {
  final Comentario comentario;

  const UserCommentData({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(children: [
        const UserProfilePhoto(
          nombre: "ANON",
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: const Text(
            "ANONIMO",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        const ComentarioTag(
          tag: "GASSAFA",
        ),
        const SizedBox(width: 5,),
        const ComentarioTag(
          tag: "GAS",
        )
      ]),
    );
  }
}

class ComentarioTag extends StatelessWidget {
  final void Function()? onTap;
  final String tag;
  final Color color;
  const ComentarioTag({super.key, required this.tag, this.onTap,  this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Tag(
        height: 25,
        txt: tag,
        color: color,
        textStyle: const TextStyle(color: Colors.black),
      ),
    );
  }
}
