
import 'package:blog_app/domain/features/home/entities/home_portada_de_hilo.dart';
import 'package:blog_app/presentation/home/widgets/portada/features/tag.dart';
import 'package:flutter/material.dart';

class TagsDePortadaHome extends StatelessWidget {
  final HomePortadaDeHilo portada;
  const TagsDePortadaHome({super.key, required this.portada});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextTag(
          portada.subcategoria,
          decoration: const TextTagDecoration(
            decoration: TagDecoration(
              backgroundColor: Colors.white
            )
        )),
        portada.banderas.esNuevo? TextTag("Nuevo",decoration: TextTagDecoration(
          decoration: const TagDecoration(
            backgroundColor: Color(0xffB5E3B8)
          )
        )) : const  SizedBox()
      ],
    );
  }
}


class ColorPicker {

  const ColorPicker._();

  static Color pickColor(String text, List<Color> colors){
    if(text.isEmpty) throw ArgumentError("[text] no puede estar vacia");

    if(colors.isEmpty) throw ArgumentError("[colors] no puede estar vacia");
    
    int n = 0;

    for (var i = 0; i < text.length; i++) {
      n += text.codeUnitAt(i);
    }

    int index =  (n % colors.length); 

    return colors[index];
  }
}
