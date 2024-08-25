import 'package:blog_app/common/widgets/inputs/decorations/decorations.dart';
import 'package:blog_app/features/categorias/domain/models/subcategoria.dart';
import 'package:blog_app/features/media/presentation/logic/extensions/media_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import '../../../../common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import '../../../../common/widgets/seleccionable/widget/grupo_seleccionable_list.dart';
import '../../../categorias/presentation/widgets/subcategoria_background.dart';
import '../logic/bloc/postear_hilo/postear_hilo_bloc.dart';

class PostearHiloScreen extends StatelessWidget {
  const PostearHiloScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Postear hilo",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                //titulo
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
                //portada
                //subcategoria
                const _Subcategoria(),
                //banderas
                const _Banderas()
              ],
            ),
          ),
        ));
  }
}

class _Subcategoria extends StatelessWidget {
  const _Subcategoria({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SubcategoriaBackground(
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
              const _SeleccionarSubcategoria()
            ],
          );
        }

        return const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Sin categoria"), _SeleccionarSubcategoria()],
        );
      },
    ));
  }
}

class _SeleccionarSubcategoria extends StatelessWidget {
  const _SeleccionarSubcategoria({super.key});

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

class _Banderas extends StatelessWidget {
  const _Banderas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Banderas",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            BlocBuilder<PostearHiloBloc, PostearHiloState>(
              buildWhen: (previous, current) =>
                  previous.banderas != current.banderas,
              builder: (context, state) {
                return SeleccionableSheet(
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
            )
          ],
        ),
      ),
    );
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
