// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comentar_hilo_bloc.dart';

class ComentarHiloState extends Equatable {
  final String texto;
  final ComentarHiloStatus status;
  final String? taggueo;
  final bool enviando;
  const ComentarHiloState({
    this.status = ComentarHiloStatus.initial,
    this.enviando = false,
    this.texto = "",
    this.taggueo,
  });

  @override
  List<Object?> get props => [texto, taggueo, status, enviando];

  ComentarHiloState copyWith({
    String? texto,
    ComentarHiloStatus? status,
    String? taggueo,
    bool? enviando,
  }) {
    return ComentarHiloState(
      texto: texto ?? this.texto,
      status: status ?? this.status,
      taggueo: taggueo ?? this.taggueo,
      enviando: enviando ?? this.enviando,
    );
  }
}

enum ComentarHiloStatus { initial, enviando, enviado, failure }
