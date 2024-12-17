import 'package:blog_app/features/app/presentation/logic/extensions/duration_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("tiempoTranscurrido tests", () {
    test("tiempoTranscurrido  debe ser ahora si no ha pasado mas de un minuto",
        () {
      expect(DateTime.now().tiempoTranscurrido, "Ahora");
    });

    test("tiempoTranscurrido  debe ser 1m si ha pasado mas de un minuto", () {
      expect(
        DateTime.now().subtract(const Duration(minutes: 1)).tiempoTranscurrido,
        "1m",
      );
    });

    test("tiempoTranscurrido  debe ser 1hs si ha pasado mas de una hora", () {
      expect(
        DateTime.now().subtract(const Duration(hours: 1)).tiempoTranscurrido,
        "1hs",
      );
    });

    test("tiempoTranscurrido  debe ser 1dias si ha pasado mas de un dia", () {
      expect(
        DateTime.now().subtract(const Duration(days: 1)).tiempoTranscurrido,
        "1dias",
      );
    });

    test("tiempoTranscurrido  debe ser 1meses si ha pasado mas de un mes", () {
      expect(
        DateTime.now().subtract(const Duration(days: 45)).tiempoTranscurrido,
        "1meses",
      );
    });
  });
}
