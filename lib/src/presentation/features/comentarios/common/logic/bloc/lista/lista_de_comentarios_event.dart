part of 'lista_de_comentarios_bloc.dart';

sealed class ListaDeComentariosEvent extends Equatable {
  const ListaDeComentariosEvent();

  @override
  List<Object> get props => [];
}


class AgregarComentarioAlInicio extends ListaDeComentariosEvent {
  final Comentario comentario;

  const AgregarComentarioAlInicio({required this.comentario});
}

class AgregarComentarios extends ListaDeComentariosEvent {
  final List<Comentario> comentarios;

  const AgregarComentarios({required this.comentarios});
}
class EliminarComentario extends ListaDeComentariosEvent {
  final ComentarioId id;

  const EliminarComentario({required this.id});
}

class Reiniciar extends ListaDeComentariosState {}