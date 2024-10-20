part of 'miniatura_generador_bloc.dart';

sealed class MiniaturaGeneradorState extends Equatable {
  const MiniaturaGeneradorState();

  @override
  List<Object> get props => [];
}

final class MiniaturaGeneradorInitial extends MiniaturaGeneradorState {}

final class GenerandoMiniatura extends MiniaturaGeneradorState {}

final class MiniaturaGenerada extends MiniaturaGeneradorState {
  final Imagen miniatura;

  const MiniaturaGenerada({required this.miniatura});
}
