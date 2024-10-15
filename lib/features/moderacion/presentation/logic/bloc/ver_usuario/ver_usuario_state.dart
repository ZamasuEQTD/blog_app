// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ver_usuario_bloc.dart';

class VerUsuarioState extends Equatable {
  final VistaDeUsuario? usuario;
  final TipoDeHistorial tipoDeHistorial;
  final UsuarioState usuarioState;

  const VerUsuarioState({
    this.usuario,
    this.tipoDeHistorial = TipoDeHistorial.hilos,
    this.usuarioState = UsuarioState.cargando,
  });

  @override
  List<Object?> get props => [usuario, tipoDeHistorial, usuarioState];

  VerUsuarioState copyWith({
    VistaDeUsuario? usuario,
    TipoDeHistorial? tipoDeHistorial,
    UsuarioState? usuarioState,
  }) {
    return VerUsuarioState(
      usuario: usuario ?? this.usuario,
      tipoDeHistorial: tipoDeHistorial ?? this.tipoDeHistorial,
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
