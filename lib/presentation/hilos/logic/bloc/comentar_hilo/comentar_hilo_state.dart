part of 'comentar_hilo_bloc.dart';

class ComentarHiloState extends Equatable {
  final String texto;
  final ComentarHiloStatus status;
  const ComentarHiloState({
    this.texto = "",
    this.status = ComentarHiloStatus.initial,
  });
  
  @override
  List<Object> get props => [];
}

enum ComentarHiloStatus {
  initial,
  enviando,
  enviado,
  failure
}