// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comentarios_bloc.dart';

class ComentariosState extends Equatable {
  final List<Comentario> comentarios;
  final ComentariosStatus status;
  const ComentariosState({
    this.comentarios = const [],
    this.status = ComentariosStatus.initial,
  });

  @override
  List<Object> get props => [];

  ComentariosState copyWith({
    List<Comentario>? comentarios,
    ComentariosStatus? status,
  }) {
    return ComentariosState(
      comentarios: comentarios ?? this.comentarios,
      status: status ?? this.status,
    );
  }
}

enum ComentariosStatus { initial, cargando, cargados }
