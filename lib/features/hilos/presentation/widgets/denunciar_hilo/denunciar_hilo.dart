import 'package:blog_app/features/app/presentation/widgets/dialog/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/grupo_seleccionable.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/item_seleccionable.dart';
import 'package:flutter/material.dart';

enum Denuncia {
  spam,
  contenidoInapropiado,
  otro,
}

class DenunciarHiloBottomSheet extends StatelessWidget {
  const DenunciarHiloBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedBottomSheet.sliver(
      slivers: [
        GrupoItemSeleccionable.sliver(
          seleccionables: Denuncia.values
              .map(
                (e) => ItemSeleccionable(
                  titulo: Text(e.name),
                  onTap: () {},
                ),
              )
              .toList(),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          sliver: SliverMainAxisGroup(
            slivers: [
              ElevatedButton(
                onPressed: () {},
                child: const Text("Denunciar"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Cancelar"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
