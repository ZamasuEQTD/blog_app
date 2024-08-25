import 'package:equatable/equatable.dart';

class Encuesta extends Equatable {
  final EncuestaId id;
  final List<OpcionDeEncuesta> opciones;

  const Encuesta({required this.id, required this.opciones});

  int votos() {
    int votos = 0;

    for (var opcion in opciones) {
      votos += opcion.votos;
    }
    return votos;
  }

  @override
  List<Object?> get props => [id, opciones];

  Encuesta copyWith({
    EncuestaId? id,
    List<OpcionDeEncuesta>? opciones,
  }) {
    return Encuesta(
      id: id ?? this.id,
      opciones: opciones ?? this.opciones,
    );
  }
}

class OpcionDeEncuesta {
  final OpcionDeEncuestaId id;
  final String opcion;
  final int votos;

  const OpcionDeEncuesta(
      {required this.id, required this.opcion, required this.votos});

  double porcentaje(int total) {
    if (total == 0) {
      return 0;
    }
    return (votos / total) * 100;
  }

  OpcionDeEncuesta copyWith({
    OpcionDeEncuestaId? id,
    String? opcion,
    int? votos,
  }) {
    return OpcionDeEncuesta(
      id: id ?? this.id,
      opcion: opcion ?? this.opcion,
      votos: votos ?? this.votos,
    );
  }
}

typedef EncuestaId = String;

typedef OpcionDeEncuestaId = String;
