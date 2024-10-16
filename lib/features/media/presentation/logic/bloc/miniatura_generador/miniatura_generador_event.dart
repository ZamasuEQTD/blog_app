part of 'miniatura_generador_bloc.dart';

sealed class MiniaturaGeneradorEvent extends Equatable {
  const MiniaturaGeneradorEvent();

  @override
  List<Object> get props => [];
}

final class GenerarMiniatura extends MiniaturaGeneradorEvent {
  final Media media;

  const GenerarMiniatura({required this.media});
}
