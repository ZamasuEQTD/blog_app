// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Encuesta {
  final RespuestaId? respuesta;
  final List<Respuesta> respuestas;

  int get votos => respuestas.map((e) => e.votos).reduce((a, b) => a + b);
  const Encuesta({
    required this.respuestas,
    this.respuesta,
  });

  factory Encuesta.fromJson(Map<String, dynamic> json) {
    return Encuesta(
      respuesta: json['respuesta'],
      respuestas: List.from(json['respuestas'])
          .map((e) => Respuesta.fromJson(e))
          .toList(),
    );
  }

  Encuesta copyWith({
    int? votos,
    RespuestaId? respuesta,
    List<Respuesta>? respuestas,
  }) {
    return Encuesta(
      respuesta: respuesta ?? this.respuesta,
      respuestas: respuestas ?? this.respuestas,
    );
  }

  void sumarVoto(RespuestaId id) {}
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

  factory Respuesta.fromJson(Map<String, dynamic> json) {
    return Respuesta(
      id: json['id'],
      respuesta: json['respuesta'],
      votos: json['votos'],
    );
  }

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
