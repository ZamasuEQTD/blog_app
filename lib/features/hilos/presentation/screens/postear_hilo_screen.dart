import 'package:blog_app/common/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/common/widgets/inputs/decorations/decorations.dart';
import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/features/categorias/domain/models/subcategoria.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:blog_app/features/media/domain/usecases/get_gallery_file_usecase.dart';
import 'package:blog_app/features/media/presentation/logic/extensions/media_extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

import '../../../../common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import '../../../../common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import '../../../../common/widgets/seleccionable/widget/grupo_seleccionable_list.dart';
import '../../../categorias/presentation/widgets/subcategoria_background.dart';
import '../logic/bloc/postear_hilo/postear_hilo_bloc.dart';

const EdgeInsets _sectionPadding = EdgeInsets.all(10);

class PostearHiloScreen extends StatelessWidget {
  const PostearHiloScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostearHiloBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Postear hilo",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: const CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              sliver: SliverMainAxisGroup(slivers: [
                _PostearHiloForm(),
                _SeleccionarSubcategoria(),
                _HiloPortada(),
                _BanderasDeHilo()
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class _PostearHiloForm extends StatelessWidget {
  const _PostearHiloForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          TextField(
            onChanged: (value) => context
                .read<PostearHiloBloc>()
                .add(CambiarTitulo(titulo: value)),
            maxLines: 1,
            decoration: FlatInputDecoration(hintText: "titulo"),
          ),
          const SizedBox(height: 10),
          //descripcion
          TextField(
            onChanged: (value) => context
                .read<PostearHiloBloc>()
                .add(CambiarDescripcion(descripcion: value)),
            maxLines: 5,
            decoration: FlatInputDecoration(hintText: "descripcion"),
          ),
        ],
      ),
    );
  }
}

class _BanderasDeHilo extends StatelessWidget {
  const _BanderasDeHilo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostearHiloBloc, PostearHiloState>(
      builder: (context, state) {
        return ItemGrupoSliverList(
            grupo: GrupoSeleccionable(seleccionables: [
          CheckboxSeleccionableList(
              value: state.banderas.dados,
              nombre: "Dados",
              onChange: (value) => context
                  .read<PostearHiloBloc>()
                  .add(CambiarBanderas(dados: value))),
          CheckboxSeleccionableList(
            value: state.banderas.tagUnico,
            nombre: "Tag único activado",
            onChange: (value) => context
                .read<PostearHiloBloc>()
                .add(CambiarBanderas(tagUnico: value)),
          )
        ]));
      },
    );
  }
}

class _SeleccionarSubcategoria extends StatelessWidget {
  const _SeleccionarSubcategoria({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SubcategoriaBackground(
        child: BlocBuilder<PostearHiloBloc, PostearHiloState>(
          buildWhen: (previous, current) =>
              previous.subcategoria != current.subcategoria,
          builder: (context, state) {
            if (state.subcategoria != null) {
              Subcategoria subcategoria = state.subcategoria!;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SubcategoriaImagen(
                          provider: subcategoria.imagen.toProvider()),
                      Text(subcategoria.nombre)
                    ],
                  ),
                  const _CambiarSubcategoriaBtn()
                ],
              );
            }

            return const _SinCategoriaSeleccionada();
          },
        ),
      ),
    );
  }
}

class _CambiarSubcategoriaBtn extends StatelessWidget {
  const _CambiarSubcategoriaBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => SeleccionarSubcategoriaBottomSheet.show(context,
            onSeleccionada: (subcategoria) => context
                .read<PostearHiloBloc>()
                .add(CambiarSubcategoria(subcategoria: subcategoria))),
        icon: const Icon(Icons.chevron_right));
  }
}

class _SinCategoriaSeleccionada extends StatelessWidget {
  const _SinCategoriaSeleccionada({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text("Sin categoria"), _CambiarSubcategoriaBtn()],
    );
  }
}

class _HiloPortada extends StatelessWidget {
  const _HiloPortada({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text("Portada"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Seleccionar portada"),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class SeleccionarSubcategoriaBottomSheet extends StatelessWidget {
  const SeleccionarSubcategoriaBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static show(BuildContext context,
      {required void Function(Subcategoria subcategoria) onSeleccionada}) {}
}

class SeleccionarArchivoBottomSheet extends StatelessWidget {
  final void Function(Either<Failure, Media?>) onGalleryResult;
  const SeleccionarArchivoBottomSheet(
      {super.key, required this.onGalleryResult});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(slivers: [
      ...ItemGrupoSliverList.GenerarSlivers([
        GrupoSeleccionable(seleccionables: [
          SeleccionarMediaDeGaleria(onResult: onGalleryResult),
          SeleccionarMediaDesdeUrl()
        ])
      ])
    ]);
  }

  static void show(BuildContext context,
          {required void Function(Either<Failure, Media?>) onGalleryResult}) =>
      SliverBottomSheet.show(context,
          child:
              SeleccionarArchivoBottomSheet(onGalleryResult: onGalleryResult),
          titulo: "Seleccionar portada");
}

class SeleccionarMediaDeGaleria extends ItemSeleccionableTileList {
  final void Function(Either<Failure, Media?> result) onResult;

  SeleccionarMediaDeGaleria({
    required this.onResult,
  }) : super(
          nombre: "Galeria",
          icon: FontAwesomeIcons.image,
          onTap: () {
            GetGalleryFileUsecase usecase = GetIt.I.get();

            usecase
                .handle(const GetGalleryFileRequest(extensions: []))
                .then(onResult);
          },
        );
}

class SeleccionarMediaDesdeUrl extends ItemSeleccionableTileList {
  SeleccionarMediaDesdeUrl()
      : super(icon: FontAwesomeIcons.link, nombre: "Enlace");
}
