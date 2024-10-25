import 'package:blog_app/src/lib/features/app/presentation/logic/horarios_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "Horarios Service Testss",
    () {
      final DateTime now = DateTime.now().toUtc();

      test(
        "Debe devolver diferencia en segundos",
        () {
          DateTime time = now.add(const Duration(seconds: 10));

          TiempoTranscurrido diferencia =
              HorariosService.diferencia(time: time, utcNow: now);

          expect(
            diferencia,
            const TiempoTranscurrido(
              diferencia: 10,
              tipo: TiposTiempoTranscurrido.segundos,
            ),
          );
        },
      );
      test(
        "Debe devolver diferencia en minutos",
        () {
          DateTime time = now.add(const Duration(minutes: 10));

          TiempoTranscurrido diferencia =
              HorariosService.diferencia(time: time, utcNow: now);

          expect(
            diferencia,
            const TiempoTranscurrido(
              diferencia: 10,
              tipo: TiposTiempoTranscurrido.minutos,
            ),
          );
        },
      );
      test(
        "Debe devolver diferencia en días",
        () {
          DateTime time = now.add(const Duration(days: 10));

          TiempoTranscurrido diferencia =
              HorariosService.diferencia(time: time, utcNow: now);

          expect(
            diferencia,
            const TiempoTranscurrido(
              diferencia: 10,
              tipo: TiposTiempoTranscurrido.dias,
            ),
          );
        },
      );
      test(
        "Debe devolver diferencia de 1 mes",
        () {
          DateTime time = now.add(const Duration(days: 40));

          TiempoTranscurrido diferencia =
              HorariosService.diferencia(time: time, utcNow: now);

          expect(
            diferencia,
            const TiempoTranscurrido(
              diferencia: 1,
              tipo: TiposTiempoTranscurrido.mes,
            ),
          );
        },
      );
      test(
        "Debe devolver diferencia de meses",
        () {
          DateTime time = now.add(const Duration(days: 70));

          TiempoTranscurrido diferencia =
              HorariosService.diferencia(time: time, utcNow: now);

          expect(
            diferencia,
            const TiempoTranscurrido(
              diferencia: 2,
              tipo: TiposTiempoTranscurrido.meses,
            ),
          );
        },
      );
    },
  );
}
