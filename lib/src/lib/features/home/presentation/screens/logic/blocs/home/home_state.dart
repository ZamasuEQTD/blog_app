// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  final String titulo;
  final DateTime? ultimoBump;
  final List<HomePortada> portadas;
  final HomePortadasState portadasState;
  const HomeState({
    this.titulo = "",
    this.ultimoBump,
    this.portadas = const [],
    this.portadasState = const InitialHomePortadasState(),
  });

  @override
  List<Object?> get props => [
        titulo,
        ultimoBump,
        portadas,
        portadasState,
      ];

  HomeState copyWith({
    String? titulo,
    DateTime? ultimoBump,
    List<HomePortada>? portadas,
    HomePortadasState? portadasState,
  }) {
    return HomeState(
      titulo: titulo ?? this.titulo,
      ultimoBump: ultimoBump ?? this.ultimoBump,
      portadas: portadas ?? this.portadas,
      portadasState: portadasState ?? this.portadasState,
    );
  }
}

abstract class HomePortadasState {
  const HomePortadasState();
}

class InitialHomePortadasState extends HomePortadasState {
  const InitialHomePortadasState();
}

class CargandoHomePortadasState extends HomePortadasState {
  const CargandoHomePortadasState();
}

class CargadasHomePortadasState extends HomePortadasState {
  final List<HomePortada> portadas;

  const CargadasHomePortadasState({required this.portadas});
}
