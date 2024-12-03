import 'package:blog_app/features/app/presentation/widgets/dialog/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/item_seleccionable.dart';
import 'package:blog_app/features/auth/domain/models/usuario.dart';
import 'package:blog_app/features/auth/presentation/logic/controllers/auth_controller.dart';
import 'package:blog_app/features/comentarios/domain/icomentarios_repository.dart';
import 'package:blog_app/features/comentarios/presentation/widgets/comentario/widgets/comentario_texto.dart';
import 'package:blog_app/features/hilos/presentation/screens/hilo_screen/logic/controllers/hilo_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../app/presentation/widgets/seleccionable/grupo_seleccionable.dart';
import '../../../../media/presentation/widgets/multi_media.dart';
import '../../../../moderacion/presentation/ver_usuario_panel.dart';
import '../../../domain/models/comentario.dart';
import 'widgets/comentario_color.dart';
import 'widgets/comentario_tags.dart';

class HiloComentario extends StatelessWidget {
  final Comentario comentario;

  const HiloComentario({super.key, required this.comentario});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ColoredBox(
          color: Theme.of(context).colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            child: Provider.value(
              value: comentario,
              builder: (context, child) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onLongPress: () => ComentarioOpcionesBottomSheet.show(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ComentarioInfoRow(),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      runSpacing: 2,
                      spacing: 5,
                      children: comentario.tags
                          .map(
                            (tag) => GestureDetector(
                              onTap: () {},
                              child: Text(
                                ">>$tag",
                                style: const TextStyle(
                                  color: CupertinoColors.link,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (comentario.media != null)
                      MultiMedia(media: comentario.media!.spoileable),
                    const ComentarioTexto(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ComentarioInfoRow extends StatelessWidget {
  const ComentarioInfoRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Comentario comentario = context.read();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const ComentarioColor(),
            const SizedBox(
              width: 3,
            ),
            Row(
              children: [
                Text(
                  comentario.autor.nombre,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const ComentarioTags(),
              ],
            ),
          ],
        ),
        Text(
          comentario.creado_en.toString(),
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}

class ComentarioOpcionesBottomSheet extends StatelessWidget {
  const ComentarioOpcionesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final Comentario comentario = context.read();
    return RoundedBottomSheet.normal(
      child: Column(
        children: [
          ...[
            GrupoItemSeleccionable.sliver(
              seleccionables: [
                ItemSeleccionable.text(
                  titulo: "Copiar",
                  onTap: () async {
                    await Clipboard.setData(
                      ClipboardData(
                        text: comentario.texto,
                      ),
                    );
                  },
                ),
              ],
            ),
            const GrupoItemSeleccionable(
              seleccionables: [
                ItemSeleccionable.text(titulo: "Ocultar"),
                ItemSeleccionable.text(titulo: "Denunciar"),
              ],
            ),
            if (Get.find<HiloController>().hilo.value?.esOp ?? false)
              GrupoItemSeleccionable(
                seleccionables: [
                  ItemSeleccionable.text(
                    onTap: () async {
                      var result =
                          await GetIt.I.get<IComentariosRepository>().destacar(
                                hilo: Get.find<HiloController>().id,
                                comentario: comentario.id,
                              );
                    },
                    titulo: "Destacar",
                  ),
                ],
              ),
            if (Get.find<AuthController>().usuario.value?.rango is Moderador)
              GrupoItemSeleccionable(
                seleccionables: [
                  ItemSeleccionable.text(
                    onTap: () {
                      IComentariosRepository repository = GetIt.I.get();

                      repository.eliminar(id: comentario.id);
                    },
                    titulo: "Eliminar",
                  ),
                  ItemSeleccionable.text(
                    onTap: () {
                      VerUsuarioPanelBottomSheet.show(context);
                    },
                    titulo: "Ver usuario",
                  ),
                ],
              ),
          ],
        ],
      ).paddingSymmetric(horizontal: 20, vertical: 10),
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Provider.value(
        value: context.read<Comentario>(),
        child: const ComentarioOpcionesBottomSheet(),
      ),
    );
  }
}

class ComentarioHiloBone extends StatelessWidget {
  const ComentarioHiloBone({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ColoredBox(
          color: Theme.of(context).colorScheme.surface,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Bone.square(size: 50),
                    Bone.text(
                      width: 50,
                    ),
                    Bone.text(
                      width: 100,
                    ),
                  ],
                ),
                Bone.multiText(lines: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
