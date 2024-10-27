// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:blog_app/src/lib/features/app/presentation/widgets/grupo_seleccionable.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/item_seleccionable.dart';
import 'package:blog_app/src/lib/features/categorias/presentation/subcategoria_tile.dart';
import 'package:blog_app/src/lib/features/postear_hilo/presentation/blocs/postear_hilo/postear_hilo_bloc.dart';

import '../../media/domain/igallery_service.dart';
import '../../media/presentation/logic/blocs/gestor_de_media/gestor_de_media_bloc.dart';
import '../../media/presentation/multi_media.dart';

class PostearHiloScreen extends StatelessWidget {
  const PostearHiloScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PostearHiloBloc(),
        ),
        BlocProvider(
          create: (context) => GestorDeMediaBloc(),
        ),
      ],
      child: BlocListener<PostearHiloBloc, PostearHiloState>(
        listenWhen: (previous, current) => previous.hiloId != current.hiloId,
        listener: (context, state) {
          context.push("/hilo/${state.hiloId}");
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: const BackButton(
              color: Colors.black,
            ),
            title: const Text(
              "Postear hilo",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Postear",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const PostearHiloInput.titulo(),
                      const PostearHiloInput.descripcion(),
                      BlocBuilder<PostearHiloBloc, PostearHiloState>(
                        builder: (context, state) {
                          if (state.subcategoria != null) {
                            return SubcategoriaTile(
                              subcategoria: state.subcategoria!,
                            );
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
                      // const GrupoSeleccionableSliver(
                      //   seleccionables: [
                      //     BanderasDeHilo.dados(),
                      //     BanderasDeHilo.idUnico(),
                      //   ],
                      // ),
                    ]
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: 5,
                            ),
                            child: e,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
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
    int? maxLines,
    int? minLines,
    required String hintText,
    required void Function(String)? onChanged,
  }) = _PostearHiloInput;

  const factory PostearHiloInput.titulo() = _TituloHiloInput;

  const factory PostearHiloInput.descripcion() = _DescripcionHiloInput;
}

class _PostearHiloInput extends PostearHiloInput {
  final String hintText;
  final int? maxLines;
  final int? minLines;
  final void Function(String value)? onChanged;

  const _PostearHiloInput({
    super.key,
    this.maxLines,
    this.minLines,
    this.onChanged,
    required this.hintText,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      maxLines: maxLines,
      minLines: minLines,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}

class _TituloHiloInput extends PostearHiloInput {
  const _TituloHiloInput() : super._();

  @override
  Widget build(BuildContext context) {
    return _PostearHiloInput(
      hintText: "Titulo",
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
      maxLines: 5,
      minLines: 5,
      hintText: "Descripcion",
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
