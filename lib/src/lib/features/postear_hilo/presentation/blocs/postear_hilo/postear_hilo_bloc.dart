import 'package:blog_app/src/lib/features/categorias/domain/models/subcategoria.dart';
import 'package:blog_app/src/lib/features/hilo/domain/ihilos_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../hilo/domain/models/types.dart';

part 'postear_hilo_event.dart';
part 'postear_hilo_state.dart';

class PostearHiloBloc extends Bloc<PostearHiloEvent, PostearHiloState> {
  final IHilosRepository repository = GetIt.I.get();

  PostearHiloBloc() : super(const PostearHiloState()) {
    on<CambiarBanderas>(_onCambiarBanderas);
    on<CambiarTitulo>(_onCambiarTitulo);
    on<PostearHilo>(_onPostearHilo);
  }

  void _onCambiarBanderas(
    CambiarBanderas event,
    Emitter<PostearHiloState> emit,
  ) {
    emit(
      state.copyWith(
        banderas: state.banderas
            .copyWith(dados: event.dados, tagUnico: event.tagUnico),
      ),
    );
  }

  void _onCambiarTitulo(CambiarTitulo event, Emitter<PostearHiloState> emit) {
    emit(state.copyWith(titulo: event.titulo));
  }

  Future _onPostearHilo(
    PostearHilo event,
    Emitter<PostearHiloState> emit,
  ) async {
    emit(state.copyWith(status: PostearHiloStatus.posteando));

    var result = await repository.postear(
      titulo: state.titulo,
      descripcion: state.descripcion,
    );

    result.fold(
      (l) => emit(state.copyWith(status: PostearHiloStatus.failure)),
      (r) => emit(
        state.copyWith(status: PostearHiloStatus.posteado, hiloId: r),
      ),
    );
  }
}
