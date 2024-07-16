import 'dart:developer';

import 'package:blog_app/src/presentation/common/widgets/bottom_sheet/rounded_bottom_sheet.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import 'package:blog_app/src/presentation/features/hilos/widgets/comentar_hilo/enviar_comentario/enviar_comentario_button.dart';
import 'package:blog_app/src/presentation/features/home/widgets/portada/portada.dart';
import 'package:flutter/material.dart';

class OpcionesDeComentarioButton extends StatelessWidget {
  const OpcionesDeComentarioButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredIconButton(
      onPressed: () => DraggableBottomSheet.show(context,builder: (controller) {
        return CustomScrollView(
          controller: controller,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              sliver: SliverGruposSeleccionable(grupos: [
                GrupoSeleccionable(
                  seleccionables: [
                    EliminarItem.fromContext(context),
                    EliminarItem.fromContext(context),
                    EliminarItem.fromContext(context)
                  ]
                )
              ]))
          ],
        );
      },),
      icon: const Icon(Icons.attach_email),
    );
  }
}

class DraggableBottomSheet extends StatelessWidget {
  final Widget child;
  const DraggableBottomSheet({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }

  static void show(BuildContext context,{
    required Widget Function(ScrollController controller) builder
  }) => showModalBottomSheet(
          context: context,
          builder: (context) => DraggableScrollableSheet(
              builder: (context, scrollController) => DraggableBottomSheet(child: builder(scrollController))
          )
        );
}

class SliverGrupoSeleccionableBottomSheet extends StatelessWidget {
  final ScrollController controller;
  final List<GrupoSeleccionable> grupos;
  final Widget Function(SliverGruposSeleccionable child)? builder;

  const SliverGrupoSeleccionableBottomSheet({
    super.key, 
    required this.controller,
    required this.grupos,
    this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      slivers: [
        _getSlivers()
      ],
    );
  }

  Widget _getSlivers() {
    if (builder != null) return builder!(SliverGruposSeleccionable(grupos: grupos));
    return  SliverPadding(
        padding:const EdgeInsets.all(8),
        sliver:  SliverGruposSeleccionable(
          grupos: grupos
        ),
      );
    
  }

  static void show(BuildContext context, {
    required List<GrupoSeleccionable> grupos,
    Widget Function(SliverGruposSeleccionable child)? builder
  }) => DraggableBottomSheet.show(
    context, 
    builder: (controller) => SliverGrupoSeleccionableBottomSheet(
      controller: controller,
      grupos: grupos,
      builder: builder
    ) 
  );
}

class OpcionesDeComentarioBottomSheet extends StatelessWidget {
  final SliverGruposSeleccionable grupos;
  const OpcionesDeComentarioBottomSheet({
    super.key, 
    required this.grupos, 
  });

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(slivers: [
      grupos
    ]);
  }

  static void show(BuildContext context) {
    SliverGrupoSeleccionableBottomSheet.show(
      context, 
      grupos: [
        GrupoSeleccionable(seleccionables: [
        EliminarItem.fromContext(context),
        EliminarItem.fromContext(context)
      ])],
      builder: (child) => OpcionesDeComentarioBottomSheet(grupos: child)
    );
  }
}

class SliverGruposSeleccionable extends StatelessWidget {
  final List<GrupoSeleccionable> grupos;
  const SliverGruposSeleccionable({super.key, required this.grupos});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: grupos.length,
        itemBuilder: (context, index) => SliverGrupoSeleccionableSheet(grupo: grupos[index])
      );
  }
}

class SliverGrupoSeleccionableSheet extends StatelessWidget {
  final GrupoSeleccionable grupo;

  const SliverGrupoSeleccionableSheet({super.key, required this.grupo});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColoredBox(
        color: Colors.white,
        child:Column(
          children: List.generate(grupo.seleccionables.length, (index) =>  _seleccionableTile(grupo.seleccionables[index]),),
        ),
      ),
    );
  }

  Widget _seleccionableTile(ItemSeleccionable seleccionable) {
    return ListTile(
      onTap: seleccionable.onTap,
      leading: seleccionable.leading,
      trailing: seleccionable.trailing,
      title: Text(
        seleccionable.nombre,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ).merge(seleccionable.style),
      ),
    );
  }
}

List<GrupoSeleccionable> grupos = [AgregarMediaGrupo()];

class AgregarMediaDesdeGaleriaItem extends ItemSeleccionableTileList {
  AgregarMediaDesdeGaleriaItem() : super(nombre: "Agregar desde galeria", icon: Icons.browse_gallery);
}

class AgregarMediaDesdeUrlItem extends ItemSeleccionableTileList {
  AgregarMediaDesdeUrlItem() : super(nombre: "Agregar url", icon: Icons.link);
}

class AgregarMediaGrupo extends GrupoSeleccionable {
  AgregarMediaGrupo()
      : super(seleccionables: [
          AgregarMediaDesdeGaleriaItem(),
          AgregarMediaDesdeUrlItem()
        ]);
}
