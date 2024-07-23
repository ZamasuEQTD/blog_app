class Comentario {
  final ComentarioId id;
  final String texto;
  final ColoresDeComentario color;
  final DatosDeComentario datos;
  final DateTime createdAt;
  final Autor autor;
  const Comentario({
    required this.id, 
    required this.texto, 
    required this.color,
    required this.createdAt,
    required this.datos, 
    required this.autor
    });
}

class DatosDeComentario {
  final String tag;
  final String? tagUnico;
  final String? dados;
  const DatosDeComentario({
    required this.tag, required this.tagUnico, required this.dados
  });
}

class Autor {
  final String nombre;
  final String rango;
  final String rangoCorto;
  const Autor({
    required this.nombre, 
    required this.rango,
    required this.rangoCorto
  });
}

enum ColoresDeComentario {
  rojo,
  amarillo,
  multi
}

typedef ComentarioId = String;