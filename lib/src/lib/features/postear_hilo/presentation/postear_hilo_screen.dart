import 'package:blog_app/src/lib/features/app/presentation/widgets/grupo_seleccionable.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/item_seleccionable.dart';
import 'package:blog_app/src/lib/features/categorias/presentation/subcategoria_tile.dart';
import 'package:blog_app/src/lib/features/postear_hilo/presentation/blocs/postear_hilo/postear_hilo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../media/domain/igallery_service.dart';
import '../../media/presentation/logic/blocs/gestor_de_media/gestor_de_media_bloc.dart';
import '../../media/presentation/multi_media.dart';

class PostearHiloScreen extends StatelessWidget {
  const PostearHiloScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostearHiloBloc(),
      child: BlocListener<PostearHiloBloc, PostearHiloState>(
        listenWhen: (previous, current) => previous.hiloId != current.hiloId,
        listener: (context, state) {
          context.push("/hilo/${state.hiloId}");
        },
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              const PostearHiloInput.titulo(),
              const PostearHiloInput.descripcion(),
              BlocBuilder<PostearHiloBloc, PostearHiloState>(
                builder: (context, state) {
                  if (state.subcategoria != null) {
                    return SubcategoriaTile(subcategoria: state.subcategoria!);
                  }
                  return const SubcategoriaTile.seleccionar();
                },
              ),
              BlocBuilder<GestorDeMediaBloc, GestorDeMediaState>(
                builder: (context, state) {
                  if (state.medias.isNotEmpty) {
                    return DimensionableScope(
                      constraints: const BoxConstraints(
                        maxHeight: 250,
                      ),
                      child: MultiMedia(media: state.medias[0]),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () async {
                      IGalleryService service = GetIt.I.get();

                      var result = await service.pickFile(
                        extensions: [],
                      );

                      result.fold(
                        (l) => null,
                        (r) {
                          if (r != null) {
                            context.read<GestorDeMediaBloc>().add(
                                  AgregarMedia(
                                    media: r,
                                  ),
                                );
                          }
                        },
                      );
                    },
                    child: const Text(
                      "Agregar portada",
                    ),
                  );
                },
              ),
              const GrupoSeleccionableSliver(
                seleccionables: [
                  BanderasDeHilo.dados(),
                  BanderasDeHilo.idUnico(),
                ],
              ),
            ]
                .map(
                  (e) => SliverPadding(
                    padding: const EdgeInsets.only(
                      bottom: 5,
                    ),
                    sliver: e,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

abstract class PostearHiloInput extends StatelessWidget {
  const PostearHiloInput._({super.key});

  const factory PostearHiloInput({
    Key? key,
    required void Function(String)? onChanged,
  }) = _PostearHiloInput;

  const factory PostearHiloInput.titulo() = _TituloHiloInput;

  const factory PostearHiloInput.descripcion() = _DescripcionHiloInput;
}

class _PostearHiloInput extends PostearHiloInput {
  final void Function(String value)? onChanged;

  const _PostearHiloInput({super.key, required this.onChanged}) : super._();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
    );
  }
}

class _TituloHiloInput extends PostearHiloInput {
  const _TituloHiloInput() : super._();

  @override
  Widget build(BuildContext context) {
    return _PostearHiloInput(
      onChanged: (value) => context.read<PostearHiloBloc>().add(
            CambiarTitulo(
              titulo: value,
            ),
          ),
    );
  }
}

class _DescripcionHiloInput extends PostearHiloInput {
  const _DescripcionHiloInput() : super._();

  @override
  Widget build(BuildContext context) {
    return _PostearHiloInput(
      onChanged: (value) => context.read<PostearHiloBloc>().add(
            CambiarDescripcion(
              descripcion: value,
            ),
          ),
    );
  }
}

abstract class BanderasDeHilo extends ItemSeleccionable {
  const BanderasDeHilo._({super.key}) : super.base();

  const factory BanderasDeHilo.dados() = _DadosSwitchBanderas;

  const factory BanderasDeHilo.idUnico() = _ActivarDesactivarBandera;
}

class _DadosSwitchBanderas extends BanderasDeHilo {
  const _DadosSwitchBanderas() : super._();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostearHiloBloc, PostearHiloState>(
      builder: (context, state) {
        return ItemSeleccionable.checkbox(
          onChange: (value) => context.read<PostearHiloBloc>().add(
                CambiarBanderas(dados: value),
              ),
          titulo: "Dados",
          value: state.banderas.dados,
        );
      },
    );
  }
}

class _ActivarDesactivarBandera extends BanderasDeHilo {
  const _ActivarDesactivarBandera({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostearHiloBloc, PostearHiloState>(
      builder: (context, state) {
        return ItemSeleccionable.checkbox(
          onChange: (value) => context.read<PostearHiloBloc>().add(
                CambiarBanderas(tagUnico: value),
              ),
          titulo: "Id unico",
          value: state.banderas.tagUnico,
        );
      },
    );
  }
}
