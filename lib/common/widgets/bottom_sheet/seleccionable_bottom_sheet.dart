import 'package:blog_app/common/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import 'package:blog_app/common/widgets/seleccionable/widget/grupo_seleccionable_list.dart';
import 'package:flutter/material.dart';

class OpcionesDeComentarios extends StatelessWidget {
  final bool op = false;
  const OpcionesDeComentarios({super.key});

  @override
  Widget build(BuildContext context) {
    final List<GrupoSeleccionable> grupos = [];

    return DraggableScrollableSheet(
      builder: (context, controller) => CustomScrollView(
        controller: controller,
        slivers: [...ItemGrupoSliverList.GenerarSlivers(grupos)],
      ),
    );
  }

  static show(BuildContext context) {
    BottomSheetManager.show(context, child: const OpcionesDeComentarios());
  }
}
