import 'package:blog_app/presentation/home/widgets/portada/features/tags.dart';
import 'package:flutter/material.dart';
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
  },);
}
