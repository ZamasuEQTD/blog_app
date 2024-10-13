// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ver_usuario_bloc.dart';

class VerUsuarioState extends Equatable {
  final List<PortadaEntity> hilos;
  final VistaDeUsuario? usuario;
  final TipoDeHistorial tipoDeHistorial;
  final HistorialState historialState;
  final UsuarioState usuarioState;

  const VerUsuarioState({
    this.hilos = const [],
    this.usuario,
    this.tipoDeHistorial = TipoDeHistorial.hilos,
    this.historialState = HistorialState.cargando,
    this.usuarioState = UsuarioState.cargando,
  });

  @override
  List<Object?> get props =>
      [hilos, usuario, tipoDeHistorial, historialState, usuarioState];

  VerUsuarioState copyWith({
    List<PortadaEntity>? hilos,
    VistaDeUsuario? usuario,
    TipoDeHistorial? tipoDeHistorial,
    HistorialState? historialState,
    UsuarioState? usuarioState,
  }) {
    return VerUsuarioState(
      hilos: hilos ?? this.hilos,
      usuario: usuario ?? this.usuario,
      tipoDeHistorial: tipoDeHistorial ?? this.tipoDeHistorial,
      historialState: historialState ?? this.historialState,
      usuarioState: usuarioState ?? this.usuarioState,
    );
  }
}

final class VerUsuarioInitial extends VerUsuarioState {}

enum TipoDeHistorial { comentarios, hilos }

enum HistorialState { cargando, cargados }

enum UsuarioState {
  cargado,
  cargando,
}
