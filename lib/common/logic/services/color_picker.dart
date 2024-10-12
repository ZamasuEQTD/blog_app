import 'package:flutter/material.dart';

class ColorPicker {
  const ColorPicker._();

  static Color pickColor(String text, List<Color> colors) {
    if (text.isEmpty) throw ArgumentError("[text] no puede estar vacia");

    if (colors.isEmpty) throw ArgumentError("[colors] no puede estar vacia");

    int n = 0;

    for (var i = 0; i < text.length; i++) {
      n += text.codeUnitAt(i);
    }

    int index = (n % colors.length);

    return colors[index];
  }
}
