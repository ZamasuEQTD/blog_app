import 'package:blog_app/src/lib/features/app/presentation/widgets/dialogs/bottom_sheet.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/grupo_seleccionable.dart';
import 'package:blog_app/src/lib/features/categorias/presentation/subcategoria_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:go_router/go_router.dart';

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
                (c) => GrupoSeleccionableSliver(
                  seleccionables: c.subcategorias
                      .map(
                        (s) => SubcategoriaTile(
                          subcategoria: s,
                          onTap: () {
                            onSubcategoriaSeleccionada(s);
                            context.pop();
                          },
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
    BuildContext context,
    OnSubcategoriaSeleccionada onSubcategoriaSeleccionada,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SeleccionarSubcategoriaBottomSheet(
        onSubcategoriaSeleccionada: onSubcategoriaSeleccionada,
      ),
    );
  }
}
