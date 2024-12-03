import 'package:blog_app/features/app/presentation/logic/controller/altura_controller.dart';
import 'package:blog_app/features/app/presentation/theme/styles/button_styles.dart';
import 'package:blog_app/features/app/presentation/widgets/dialog/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/features/app/presentation/widgets/dialog/widgets/titulo.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/grupo_seleccionable.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/item_seleccionable.dart';
import 'package:blog_app/features/app/presentation/widgets/snackbars/snackbar.dart';
import 'package:blog_app/features/hilos/domain/ihilos_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

const denuncias = {
  HiloRazonDenuncia.spam: "Spam",
  HiloRazonDenuncia.contenidoInapropiado: "Contenido inapropiado",
  HiloRazonDenuncia.otro: "Otro",
};

enum HiloRazonDenuncia {
  spam,
  contenidoInapropiado,
  otro,
}

class DenunciarHiloBottomSheet extends StatefulWidget {
  const DenunciarHiloBottomSheet({super.key});

  @override
  State<DenunciarHiloBottomSheet> createState() =>
      _DenunciarHiloBottomSheetState();

  static void show(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => const DenunciarHiloBottomSheet(),
    );
  }
}

class _DenunciarHiloBottomSheetState extends State<DenunciarHiloBottomSheet> {
  HiloRazonDenuncia? denuncia;

  @override
  Widget build(BuildContext context) {
    return RoundedBottomSheet.sliver(
      titulo: const DialogTitulo.text(titulo: "Selecciona el motivo"),
      slivers: [
        GrupoItemSeleccionable.sliver(
          seleccionables: HiloRazonDenuncia.values
              .map(
                (e) => ItemSeleccionable(
                  titulo: Text(denuncias[e]!),
                  trailing: denuncia == e
                      ? const Icon(Icons.check).animate().scale(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.bounceOut,
                          )
                      : null,
                  onTap: () => setState(() => denuncia = e),
                ),
              )
              .toList(),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          sliver: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Snackbars.showSuccess(context, "Hilo denunciado");
                    // IHilosRepository repository =
                    //     GetIt.I.get<IHilosRepository>();
                  },
                  child: const Text("Denunciar"),
                ).marginOnly(bottom: 10),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.pop(),
                  child: const Text("Cancelar"),
                ).withSecondaryStyle(context),
              ),
            ],
          ).paddingSymmetric(horizontal: 10).sliverBox,
        ),
      ],
    );
  }
}
