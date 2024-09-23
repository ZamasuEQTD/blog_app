import 'package:blog_app/common/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/common/widgets/seleccionable/widget/grupo_seleccionable_list.dart';
import 'package:blog_app/features/categorias/domain/models/categoria.dart';
import 'package:blog_app/features/categorias/domain/models/subcategoria.dart';
import 'package:blog_app/features/categorias/presentation/widgets/categorias.dart';
import 'package:flutter/material.dart';

class SeleccionarSubcategoriaBottomsheet extends StatelessWidget {
  const SeleccionarSubcategoriaBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    List<Categoria> categorias = [];
    return SliverMainAxisGroup(
      slivers: [
        ...ItemGrupoSliverList.GenerarSlivers(categorias.generarGrupos())
      ],
    );
  }

  static void show(BuildContext context,
          {required void Function(Subcategoria subcategoria) onSeleccionada}) =>
      SliverBottomSheet.show(
        context,
        child: const SeleccionarSubcategoriaBottomsheet(),
      );
}
