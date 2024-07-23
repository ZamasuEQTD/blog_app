import 'dart:collection';
import 'dart:developer';

import 'package:blog_app/presentation/home/widgets/portada/features/tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Color picker test group", () {
      test("debe retornar color cuando es válido", () {
      Color color = ColorPicker.pickColor("#",[Colors.red,Colors.blue, Colors.green]);

      expect(color, Colors.green);
    });

    test("debe lanzar exception cuando los colores estan vacios", () {
    expect(() => ColorPicker.pickColor("#", []), throwsA(isA<ArgumentError>()));   
    });

    test("debe lanzar exception cuando el texto esta vacio", () {
    expect(() => ColorPicker.pickColor("", [Colors.red]), throwsA(isA<ArgumentError>()));   
    });

    test("fsa", () {
      final List<Color> colores = [
        Colors.red,
        Colors.green,
        Colors.green,

      ];

      final List<Color> colors = [];
      final List<double> stops = [];
        for (var i = 0; i < colores.length; i++) {
        
        colors.add(colores[i]);

        if( i != 0){
          colors.add(colores[i]);
        }

        var index = i + 1;

        stops.add(index  / colores.length);

        if(index != colores.length ){
          stops.add(index / colores.length );
        }
      }

      log("message");
    });
    test("fsa", () {

      List<String> colors = [
        "1",
        "2",
        "3",
        "4"
      ];
      List<List<String>> patterns = [colors];

      for (var i = 0; i <  colors.length - 1; i++) {
        patterns = [...patterns, [patterns[i].last,...patterns[i].sublist(0, patterns[i].length - 1)]];
      }    

      log(patterns.toString());
    });
  },);
}
