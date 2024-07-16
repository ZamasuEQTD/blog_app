import 'package:blog_app/src/presentation/common/widgets/bottom_sheet/rounded_bottom_sheet.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import 'package:blog_app/src/presentation/features/home/widgets/portada/portada.dart';
import 'package:flutter/material.dart';

class OpcionesDeComentarioButton extends StatelessWidget {
  const OpcionesDeComentarioButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: () => OpcionesDeComentarioBottomSheet.show(context),
      icon: Icon(Icons.attach_email),
    );
  }
}


class OpcionesDeComentarioBottomSheet extends StatelessWidget {
  const OpcionesDeComentarioBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static void show(BuildContext context){
    GruposSeleccionableBottomSheet.show(context, grupos: grupos);
  }
}
List<GrupoSeleccionable> grupos = [
  AgregarMediaGrupo()
];
class AgregarMediaDesdeGaleriaItem extends ItemSeleccionableTileList  {
  AgregarMediaDesdeGaleriaItem():super(
    nombre: "Agregar desde galeria",
    icon: Icons.browse_gallery
  );
}

class AgregarMediaDesdeUrlItem extends ItemSeleccionableTileList{
  AgregarMediaDesdeUrlItem():super(
    nombre: "Agregar url", 
    icon: Icons.link
  );
}

class AgregarMediaGrupo extends GrupoSeleccionable  {
  AgregarMediaGrupo():super(seleccionables: [
    AgregarMediaDesdeGaleriaItem(),
    AgregarMediaDesdeUrlItem()
  ]);
}