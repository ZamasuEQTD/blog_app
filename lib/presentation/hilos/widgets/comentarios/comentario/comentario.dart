
import 'package:blog_app/domain/features/comentarios/entities/comentario.dart';
import 'package:blog_app/presentation/home/widgets/portada/features/tags.dart';
import 'package:flutter/material.dart';

class ComentarioDeHiloWidget extends StatelessWidget {
  final Comentario comentario;
  const ComentarioDeHiloWidget({
    super.key, 
    required this.comentario
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
            color: const Color.fromRGBO(233, 233, 233, 1),
            borderRadius: BorderRadius.circular(15)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 8,vertical:5),
        child: ComentarioColumn(
          comentario: comentario
        ),
    );
  }
}

class ComentarioColumn extends StatelessWidget {
  final Comentario comentario;
  const ComentarioColumn({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InformacionDeAutorDeComentario(comentario: comentario),
        TextoDeComentario(comentario: comentario)
      ],
    );
  }
}

class TextoDeComentario extends StatelessWidget {
  final Comentario comentario;
  const TextoDeComentario({
    super.key, 
    required this.comentario
  });

  @override
  Widget build(BuildContext context) {
    return Text(comentario.texto);
  }
}

class InformacionDeAutorDeComentario extends StatelessWidget {
  final Comentario comentario;
  const InformacionDeAutorDeComentario({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InformacionDeAutor(comentario: comentario),
        ],
      ),
    );
  }
}


class InformacionDeAutor extends StatelessWidget {
  final Comentario comentario;

  const InformacionDeAutor({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(children: [
        const ColorDeAutorComentario(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: const Text(
            "ANONIMO",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Tag.formText(
          label: comentario.datos.tag,
          decoration:TagDeComentarioDecoration()
        ),
        SizedBox(width: 10),
        comentario.datos.tagUnico != null? Tag.formText(label: comentario.datos.tagUnico!) : SizedBox()
      ]),
    );
  }
}


class ColorDeAutorComentario extends StatelessWidget {
  const ColorDeAutorComentario({super.key});

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
            "nombre",
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}

// class TagDeComentario extends StatelessWidget {
//   const TagDeComentario({super.key});

//   @override
//   Widget build(BuildContext context) {
//      return Tag(
//         height: 25,
//         txt: "SFASFAF",
//         color: Colors.white,
//         textStyle: const TextStyle(color: Colors.black),
//       );  
//     }
// }