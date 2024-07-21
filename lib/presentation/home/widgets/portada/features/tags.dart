
import 'package:blog_app/domain/features/home/entities/home_portada_de_hilo.dart';
import 'package:flutter/material.dart';

class TagsDePortadaHome extends StatelessWidget {
  final HomePortadaDeHilo portada;
  const TagsDePortadaHome({super.key, required this.portada});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Tag(
          label: Text(portada.subcategoria),
          decoration: TagPortadaHomeDecoration(
            backgroundColor: Colors.red
          ),
        ),
        Tag.formText(
          label: "Nuevo",
          decoration: TagPortadaHomeDecoration(
            backgroundColor: Colors.red,
          ),
        )
      ],
    );
  }
}

class Tag extends Chip {
  Tag({
    super.key,
    TagDecoration  decoration = const TagDecoration(),   
    required super.label,
  }) : super(
    shape: decoration.shape,
    backgroundColor: decoration.backgroundColor,
    labelStyle: decoration.textStyle
  );

  Tag.formText({
    super.key,
    required String label,
    TagDecoration  decoration = const TagDecoration(),   
  }) : super(
    label: Text(label),
    shape: decoration.shape,
    backgroundColor: decoration.backgroundColor,
    labelStyle: decoration.textStyle
  );
}

class TagDecoration { 
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final OutlinedBorder? shape;
  const TagDecoration({
    this.backgroundColor,
    this.shape,
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white
    ),
  });

  TagDecoration copyWith({
    Color? backgroundColor,
    TextStyle? textStyle,
    OutlinedBorder? shape,
  }){
    return TagDecoration(
      backgroundColor : backgroundColor?? this.backgroundColor,
      textStyle : textStyle?? this.textStyle,
      shape : shape?? this.shape,
    );
  }
}

class RoundedTagDecoration extends TagDecoration {
  RoundedTagDecoration({
    super.backgroundColor,
    super.textStyle,
    double radius = 10
  }) : super(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius)
    )
  );
}

class TagPortadaHomeDecoration extends RoundedTagDecoration {
  TagPortadaHomeDecoration({
    required super.backgroundColor
  }) : super(
    radius: 5,
    textStyle: const TextStyle(
    )
  );
}

class TagDeComentarioDecoration extends RoundedTagDecoration {
  TagDeComentarioDecoration({
    super.backgroundColor  = Colors.white,
    super.textStyle
  });
}

class TagUnicoDeComentarioDecoration  extends RoundedTagDecoration {
  static final List<Color> colors = [];

  TagUnicoDeComentarioDecoration(String tag): super(
    backgroundColor: ColorPicker.pickColor(tag, colors)
  );
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
