import 'package:blog_app/src/presentation/common/widgets/tags/tag.dart';
import 'package:blog_app/src/presentation/features/hilos/logic/bloc/comentarios_bloc.dart';
import 'package:blog_app/src/presentation/features/hilos/logic/hilo/hilo_bloc.dart';
import 'package:flutter/material.dart';

class ComentarioDeHiloWidget extends StatelessWidget {
  final ComentarioHilo comentario;
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
        child: Comentario(
          comentario: comentario
        ),
    );
  }
}

class Comentario extends StatelessWidget {
  final ComentarioHilo comentario;
  const Comentario({super.key, required this.comentario});

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
  final ComentarioHilo comentario;
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
  final ComentarioHilo comentario;
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
  final ComentarioHilo comentario;

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
        const TagDeComentario(),
        const SizedBox(width: 5,),
        const TagDeComentario()
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

class TagDeComentario extends StatelessWidget {
  const TagDeComentario({super.key});

  @override
  Widget build(BuildContext context) {
     return Tag(
        height: 25,
        txt: "SFASFAF",
        color: Colors.white,
        textStyle: const TextStyle(color: Colors.black),
      );  
    }
}