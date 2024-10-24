// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ver_usuario_bloc.dart';

class VerUsuarioState extends Equatable {
  final Usuario? usuario;
  final TipoDeHistorial tipoDeHistorial;
  final UsuarioState usuarioState;

  final List<HistorialHilo> hilos;
  final List<HistorialDeComentario> comentarios;

  const VerUsuarioState({
    this.usuario,
    this.tipoDeHistorial = TipoDeHistorial.hilos,
    this.usuarioState = UsuarioState.cargando,
    this.hilos = const [],
    this.comentarios = const [],
  });

  @override
  List<Object?> get props => [usuario, tipoDeHistorial, usuarioState];

  VerUsuarioState copyWith({
    Usuario? usuario,
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
