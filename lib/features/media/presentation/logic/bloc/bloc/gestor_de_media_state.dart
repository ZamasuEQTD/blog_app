// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'gestor_de_media_bloc.dart';

abstract class GestorDeMediaState extends Equatable {
  final List<Media> medias;
  const GestorDeMediaState({
    this.medias = const [],
  });

  @override
  List<Object> get props => [medias];
}

class GestorDeMediaInitialState extends GestorDeMediaState {
  const GestorDeMediaInitialState({super.medias});
}

class GestorDeMediasFailureState extends GestorDeMediaState {
  final Failure error;

  const GestorDeMediasFailureState({super.medias, required this.error});
}
