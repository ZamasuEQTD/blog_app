import 'dart:collection';

import 'package:equatable/equatable.dart';

class HorarioService {
  static TiempoTranscurrido diferencia({
    required DateTime utcNow,
    required DateTime time,
  }) {
    final Duration difference = utcNow.difference(time).abs();

    if (difference.inDays.abs() >= 30) {
      int months = (difference.inDays / 30).round().abs();

      if (months == 1) {
        return TiempoTranscurrido(
          diferencia: months,
          tipo: TiposTiempoTranscurrido.mes,
        );
      }
      return TiempoTranscurrido(
        diferencia: months,
        tipo: TiposTiempoTranscurrido.meses,
      );
    } else if (difference.inDays > 0) {
      return TiempoTranscurrido(
        diferencia: difference.inDays,
        tipo: TiposTiempoTranscurrido.dias,
      );
    } else if (difference.inMinutes > 0) {
      return TiempoTranscurrido(
        diferencia: difference.inMinutes,
        tipo: TiposTiempoTranscurrido.minutos,
      );
    } else if (difference.inSeconds > 0) {
      return TiempoTranscurrido(
        diferencia: difference.inSeconds,
        tipo: TiposTiempoTranscurrido.segundos,
      );
    } else {
      return const TiempoTranscurrido(
        diferencia: 0,
        tipo: TiposTiempoTranscurrido.segundos,
      );
    } // Diferencia insignificante
  }
}

class TiempoTranscurrido extends Equatable {
  static final HashMap<TiposTiempoTranscurrido, String> _diferencias =
      HashMap.from({
    TiposTiempoTranscurrido.dias: "d",
    TiposTiempoTranscurrido.meses: "meses",
    TiposTiempoTranscurrido.mes: "mes",
    TiposTiempoTranscurrido.minutos: "min",
    TiposTiempoTranscurrido.segundos: "s",
  });

  final int diferencia;
  final TiposTiempoTranscurrido tipo;

  const TiempoTranscurrido({required this.diferencia, required this.tipo});

  @override
  String toString() => diferencia.toString() + _diferencias[tipo]!;

  @override
  List<Object?> get props => [diferencia, tipo];
}

enum TiposTiempoTranscurrido { segundos, minutos, dias, mes, meses }
