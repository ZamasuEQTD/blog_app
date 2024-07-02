import 'package:flutter/material.dart';

class TextoDeComentario extends StatelessWidget {
  final String texto;
  const TextoDeComentario({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(texto,style: const TextStyle(fontSize: 18),),
    );
  }
}