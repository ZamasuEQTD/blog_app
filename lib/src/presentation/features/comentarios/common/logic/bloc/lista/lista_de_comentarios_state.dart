part of 'lista_de_comentarios_bloc.dart';

sealed class ListaDeComentariosState extends Equatable {
  const ListaDeComentariosState();
  
  @override
  List<Object> get props => [];
}

final class ListaDeComentariosInitial extends ListaDeComentariosState {}
