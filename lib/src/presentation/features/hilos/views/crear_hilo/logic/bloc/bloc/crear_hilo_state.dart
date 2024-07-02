part of 'crear_hilo_bloc.dart';

class CrearHiloState extends Equatable {
  final String titulo;
  final String descripcion; 
  final BanderasDeHilo banderas;

  const CrearHiloState({
    this.titulo = "", 
    this.descripcion = "", 
    this.banderas = const BanderasDeHilo(
      dados: false,
      tagUnico: false
    )
  });
  
  CrearHiloState copyWith({
    String? titulo,
    String? descripcion,
    BanderasDeHilo? banderas
  }) {
    return CrearHiloState(
      titulo:titulo?? this.titulo,
      descripcion: descripcion?? this.descripcion,
      banderas: banderas?? this.banderas
    );
  }

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