part of 'crear_hilo_bloc.dart';

class CrearHiloState extends Equatable {
  final String titulo;
  final String descripcion; 
  final List<String> encuesta;
  final HiloId? hiloId;
  final PostearHiloStatus status;
  final BanderasDeHilo banderas;
  final Spoileable<Media>? portada;
  const CrearHiloState({
    this.titulo = "", 
    this.descripcion = "",
    this.encuesta = const [],
    this.status = PostearHiloStatus.initial,
    this.hiloId,
    this.banderas = const BanderasDeHilo(
      dados: false,
      tagUnico: false
    ),
    this.portada 
  });
  
  CrearHiloState copyWith({
    String? titulo,
    String? descripcion,
    List<String>? encuesta,
    HiloId? hiloId,
    PostearHiloStatus? status,
    BanderasDeHilo ?banderas,
    Spoileable<Media>? portada
    }) => CrearHiloState(
      titulo: titulo?? this.titulo,
      descripcion: descripcion?? this.descripcion,
      encuesta: encuesta?? this.encuesta,
      banderas: banderas?? this.banderas,
      hiloId: hiloId?? this.hiloId,
      portada: portada?? this.portada,
      status: status?? this.status
    ); 

  @override
  List<Object> get props => [
    titulo,
    descripcion,
    banderas
  ];
}

class BanderasDeHilo extends Equatable{
  final bool dados;
  final bool tagUnico;

  const BanderasDeHilo({
    required this.dados,
    required this.tagUnico
  });

  @override
  List<Object?> get props => [
    dados,
    tagUnico
  ]; 

  BanderasDeHilo copyWith({
    bool? dados,
    bool? tagUnico
  }){
    return BanderasDeHilo(
      dados: dados?? this.dados, 
      tagUnico: tagUnico?? this.tagUnico
    );
  }
}

enum PostearHiloStatus {
  initial,
  posteando,
  posteado,
  failure
}