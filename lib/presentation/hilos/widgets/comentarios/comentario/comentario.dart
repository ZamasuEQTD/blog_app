
import 'dart:async';
import 'dart:collection';

import 'package:blog_app/domain/features/comentarios/entities/comentario.dart';
import 'package:blog_app/presentation/home/widgets/portada/features/tag.dart';
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
        ColorDeAutorComentario(comentario: comentario),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            comentario.autor.nombre,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        TextTag(comentario.datos.tag),
        SizedBox(width: 10),
        comentario.datos.tagUnico != null? TagUnicoDeComentario(comentario.datos.tagUnico!) : SizedBox()
      ]),
    );
  }
}



class TagUnicoDeComentario extends TextTag {
  static final List<Color> colors = [];

  TagUnicoDeComentario(super.tag, {super.key}) : super(
    decoration: TextTagDecoration(
      decoration: TagDecoration(
        backgroundColor: ColorPicker.pickColor(tag, colors)
      )
    )
  );
}

class ColorDeAutorComentario extends StatelessWidget {

  final Comentario comentario;
  const ColorDeAutorComentario({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          children: [
            ColorDeComentario(color: comentario.color),
            FittedBox(
              child: Text(
                comentario.autor.rangoCorto,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorDeComentario extends StatelessWidget {
  final ColoresDeComentario color;
  const ColorDeComentario({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    switch (color) {
      case ColoresDeComentario.rojo:
        return ColoredBox(color: Colors.red);
      case ColoresDeComentario.multi:
        return MultiColor();
      default:
        throw ArgumentError("[color] invalido");
    }
  }
}

class MultiColor extends LinearGradientAnimation {

  static const List<Color> multiColors = [];

  const MultiColor({super.key}) : super(colors: multiColors);
}

class LinearGradientAnimation extends StatefulWidget {
  final List<Color> colors;
  final int? duration;
  final bool reverse;
  const LinearGradientAnimation({
    super.key, 
    required this.colors,
    this.reverse = false,
    this.duration, 
  });

  @override
  State<LinearGradientAnimation> createState() => _LinearGradientAnimationState();
}

class _LinearGradientAnimationState extends State<LinearGradientAnimation> {
  final List<double> stops = [];
  late final List<List<Color>> patterns;
  int pattern = 0;
  @override
  void initState() {
    final int duration = widget.duration ?? (widget.colors.length * 100);

    for (var i = 0; i < widget.colors.length; i++) {

      var index = i + 1;

      stops.add(index  / widget.colors.length);

      if(index != widget.colors.length ){
        stops.add(index / widget.colors.length );
      }
    }

    List<List<Color>> patterns = [widget.colors];

    for (var i = 0; i < widget.colors.length - 1; i++) {
      patterns = [...patterns, [patterns[i].last, ...patterns[i].sublist(0, patterns[i].length - 1)]];
    }    

    this.patterns = widget.reverse ? patterns.reversed.toList() : patterns;

    Timer.periodic(Duration(milliseconds: duration ~/ widget.colors.length), (timer) {
      setState(() {
        if(pattern < this.patterns.length - 1 ){
          pattern++;
        } else {
          pattern = 0;
        }
      });
    },);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(child: DecoratedBox(decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _getColors(patterns[pattern]),
          stops: stops, 
          begin: Alignment.topCenter, 
          end: Alignment.bottomCenter, 
        )
      )
    ));
  }

  List<Color> _getColors(List<Color> pattern){
    List<Color> colors = [];

      for (var i = 0; i < pattern.length; i++) {
        colors.add(pattern[i]);

        if(i > 0) {
          colors.add(pattern[i]);
        }
      }
  
    return  colors;
  }
}

