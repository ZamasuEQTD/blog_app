import 'package:bloc/bloc.dart';
import 'package:blog_app/domain/features/common/entities/spoileable.dart';
import 'package:blog_app/domain/features/hilo/entities/hilo.dart';
import 'package:blog_app/domain/features/hilo/usecases/postear_hilo_usecase.dart';
import 'package:blog_app/domain/features/media/entities/media.dart';
import 'package:equatable/equatable.dart';

part 'postear_hilo_event.dart';
part 'postear_hilo_state.dart';

class PostearHiloBloc extends Bloc<PostearHiloEvent, PostearHiloState> {
  final PostearHiloUsecase _postearHiloUsecase;

  PostearHiloBloc(this._postearHiloUsecase) : super(const PostearHiloState()) {
    on<CambiarBanderas>(_onCambiarBanderas);
    on<CambiarTitulo>(_onCambiarTitulo);
    on<AgregarMedia>(_onAgregarMedia);
    on<EliminarMedia>(_onEliminarMedia);
    on<PostearHilo>(_onPostearHilo);
    on<SwitchSpoiler>(_onSwitchSpoiler);
  }

  void _onCambiarBanderas(
      CambiarBanderas event, Emitter<PostearHiloState> emit) {
    emit(state.copyWith(
        banderas: state.banderas
            .copyWith(dados: event.dados, tagUnico: event.tagUnico)));
  }

  void _onCambiarTitulo(CambiarTitulo event, Emitter<PostearHiloState> emit) {
    emit(state.copyWith(titulo: event.titulo));
  }

  void _onAgregarMedia(AgregarMedia event, Emitter<PostearHiloState> emit) {
    emit(state.copyWith(portada: Spoileable(false, event.media)));
  }

  void _onEliminarMedia(EliminarMedia event, Emitter<PostearHiloState> emit) {
    emit(state.copyWith(portada: null));
  }

  Future _onPostearHilo(
      PostearHilo event, Emitter<PostearHiloState> emit) async {
    emit(state.copyWith(status: PostearHiloStatus.posteando));

    var result = await _postearHiloUsecase.handle(PostearHiloRequest());

    result.fold(
        (l) => emit(state.copyWith(status: PostearHiloStatus.failure)),
        (r) => emit(
            state.copyWith(status: PostearHiloStatus.posteado, hiloId: r)));
  }

  void _onSwitchSpoiler(SwitchSpoiler event, Emitter<PostearHiloState> emit) {
    emit(state.copyWith(
        portada: state.portada!.copyWith(spoiler: !state.portada!.esSpoiler)));
  }
}
