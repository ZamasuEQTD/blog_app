part of 'postear_hilo_bloc.dart';

class PostearHiloState extends Equatable {
  final String titulo;
  final String descripcion;
  final List<String> encuesta;
  final HiloId? hiloId;
  final SubcategoriaEntity? subcategoria;
  final PostearHiloStatus status;
  final BanderasDeHiloState banderas;
  const PostearHiloState({
    this.titulo = "",
    this.descripcion = "",
    this.encuesta = const [],
    this.status = PostearHiloStatus.initial,
    this.hiloId,
    this.subcategoria,
    this.banderas = const BanderasDeHiloState(dados: false, tagUnico: false),
  });

  PostearHiloState copyWith({
    String? titulo,
    String? descripcion,
    List<String>? encuesta,
    HiloId? hiloId,
    PostearHiloStatus? status,
    BanderasDeHiloState? banderas,
  }) =>
      PostearHiloState(
        titulo: titulo ?? this.titulo,
        descripcion: descripcion ?? this.descripcion,
        encuesta: encuesta ?? this.encuesta,
        banderas: banderas ?? this.banderas,
        hiloId: hiloId ?? this.hiloId,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [titulo, descripcion, banderas];
}

class BanderasDeHiloState extends Equatable {
  final bool dados;
  final bool tagUnico;

  const BanderasDeHiloState({required this.dados, required this.tagUnico});

  @override
  List<Object?> get props => [dados, tagUnico];

  BanderasDeHiloState copyWith({bool? dados, bool? tagUnico}) {
    return BanderasDeHiloState(
      dados: dados ?? this.dados,
      tagUnico: tagUnico ?? this.tagUnico,
    );
  }
}

enum PostearHiloStatus { initial, posteando, posteado, failure }