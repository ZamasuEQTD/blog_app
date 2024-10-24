// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Encuesta {
  final int votos;
  final bool haVotado;
  final List<Respuesta> respuestas;

  const Encuesta({
    required this.votos,
    required this.haVotado,
    required this.respuestas,
  });

  Encuesta copyWith({
    int? votos,
    bool? haVotado,
    List<Respuesta>? respuestas,
  }) {
    return Encuesta(
      votos: votos ?? this.votos,
      haVotado: haVotado ?? this.haVotado,
      respuestas: respuestas ?? this.respuestas,
    );
  }
}

class Respuesta extends Equatable {
  final RespuestaId id;
  final String respuesta;
  final int votos;

  const Respuesta({
    required this.id,
    required this.respuesta,
    required this.votos,
  });

  double porcentaje(int total) {
    if (total == 0) {
      return 0;
    }
    return (votos / total) * 100;
  }

  @override
  List<Object?> get props => [id, respuesta, votos];

  @override
  String toString() => respuesta;

  Respuesta copyWith({
    RespuestaId? id,
    String? respuesta,
    int? votos,
  }) {
    return Respuesta(
      id: id ?? this.id,
      respuesta: respuesta ?? this.respuesta,
      votos: votos ?? this.votos,
    );
  }
}

typedef RespuestaId = String;
typedef EncuestaId = String;
