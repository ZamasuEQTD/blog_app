import 'package:blog_app/features/app/presentation/widgets/dialog/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/grupo_seleccionable.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/item_seleccionable.dart';
import 'package:blog_app/features/media/presentation/logic/extension/media_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../domain/models/categoria.dart';
import 'controller/categorias_controller.dart';

typedef OnSubcategoriaSeleccionada = void Function(Subcategoria subcategoria);

class SeleccionarSubcategoriaBottomSheet extends StatelessWidget {
  final OnSubcategoriaSeleccionada onSubcategoriaSeleccionada;

  const SeleccionarSubcategoriaBottomSheet({
    super.key,
    required this.onSubcategoriaSeleccionada,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriasController>(
      global: false,
      init: CategoriasController()..cargar(),
      builder: (controller) => Obx(
        () => RoundedBottomSheet.sliver(
          slivers: [
            if (!controller.cargando.value) ...[
              ...controller.categorias.value.map(
                (c) => GrupoItemSeleccionable.sliver(
                  titulo: c.nombre,
                  seleccionables: c.subcategorias
                      .map(
                        (s) => SeleccionarSubcategoriaTile(
                          subcategoria: s,
                          onSubcategoriaSeleccionada:
                              onSubcategoriaSeleccionada,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  static void show(
    BuildContext context, {
    required OnSubcategoriaSeleccionada onSubcategoriaSeleccionada,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SeleccionarSubcategoriaBottomSheet(
        onSubcategoriaSeleccionada: onSubcategoriaSeleccionada,
      ),
    );
  }
}

class SeleccionarSubcategoriaTile extends StatelessWidget {
  final Subcategoria subcategoria;
  final OnSubcategoriaSeleccionada onSubcategoriaSeleccionada;

  const SeleccionarSubcategoriaTile({
    super.key,
    required this.subcategoria,
    required this.onSubcategoriaSeleccionada,
  });

  @override
  Widget build(BuildContext context) {
    return ItemSeleccionable.text(
      titulo: subcategoria.nombre,
      leading: SizedBox.square(
        dimension: 35,
        child: Image(image: subcategoria.imagen.toProvider),
      ),
      onTap: () => onSubcategoriaSeleccionada(subcategoria),
    );
  }
}
