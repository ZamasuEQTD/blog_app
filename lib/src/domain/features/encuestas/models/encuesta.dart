import 'package:equatable/equatable.dart';

class Encuesta {
  final RespuestaId id;
  final List<Respuesta> respuestas;

  const Encuesta({
    required this.id, 
    required this.respuestas
  });

  Encuesta copyWith({
     RespuestaId?id,
    List<Respuesta>? respuestas
  }){
    return Encuesta(id: id??this.id, respuestas: respuestas?? this.respuestas);
  }
}

typedef EncuestaId = String;

typedef RespuestaId = String;

class Respuesta extends Equatable  {
  final RespuestaId id;
  final int votos;
  const Respuesta({
    required this.id, 
    required this.votos
  });
  
  @override
  List<Object?> get props => [
    id,
    votos
  ];

  Respuesta copyWith({
    RespuestaId? id,
    int? votos
  }){
    return Respuesta(id: id?? this.id, votos: votos?? this.votos);
  }
}