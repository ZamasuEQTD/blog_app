// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'historial_de_comentarios_bloc.dart';

class HistorialDeComentarioItem {
  final String id;
  final String comentario;
  final HistorialDeComentarioHilo hilo;
  const HistorialDeComentarioItem({
    required this.id,
    required this.comentario,
    required this.hilo,
  });
}

class HistorialDeComentarioHilo {
  final String id;
  final String titulo;
  final Imagen portada;

  HistorialDeComentarioHilo(
      {required this.id, required this.titulo, required this.portada});
}

class HistorialDeComentariosState extends Equatable {
  final List<HistorialDeComentarioItem> comentarios;
  final HistorialDeComentariosStatus status;
  const HistorialDeComentariosState({
    this.comentarios = const [],
    this.status = HistorialDeComentariosStatus.initial,
  });

  @override
  List<Object> get props => [
        comentarios,
        status,
      ];

  HistorialDeComentariosState copyWith({
    List<HistorialDeComentarioItem>? comentarios,
    HistorialDeComentariosStatus? status,
  }) {
    return HistorialDeComentariosState(
      comentarios: comentarios ?? this.comentarios,
      status: status ?? this.status,
    );
  }
}

enum HistorialDeComentariosStatus { initial, cargando, cargados }
