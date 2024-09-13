part of 'ver_usuario_bloc.dart';

sealed class VerUsuarioEvent extends Equatable {
  const VerUsuarioEvent();

  @override
  List<Object> get props => [];
}

class CargarUsuario extends VerUsuarioEvent {}

class CambiarTipoDeHistorial extends VerUsuarioEvent {
  final TipoDeHistorial tipo;

  const CambiarTipoDeHistorial({required this.tipo});
}

class CargarSiguientePagina extends VerUsuarioEvent {
  final int pagina;

  const CargarSiguientePagina({required this.pagina});
}
