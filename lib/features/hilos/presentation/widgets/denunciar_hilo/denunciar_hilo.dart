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
  final String hilo;
  const DenunciarHiloBottomSheet({super.key, required this.hilo});

  @override
  State<DenunciarHiloBottomSheet> createState() =>
      _DenunciarHiloBottomSheetState();

  static void show(
    BuildContext context, {
    required String hilo,
  }) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => DenunciarHiloBottomSheet(
        hilo: hilo,
      ),
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
                  onPressed: () async {
                    if (denuncia == null) return;

                    IHilosRepository repository =
                        GetIt.I.get<IHilosRepository>();

                    var res = await repository.denunciar(
                      id: widget.hilo,
                      denuncia: denuncia!,
                    );

                    res.fold(
                      (l) {
                        Snackbars.failure(failure: l);
                      },
                      (r) {
                        context.pop();

                        const Snackbars.success(message: "Hilo denunciado");
                      },
                    );
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
