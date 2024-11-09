import 'package:blog_app/src/lib/features/app/presentation/logic/extensions.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/dialogs/bottom_sheet.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/grupo_seleccionable.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/item_seleccionable.dart';
import 'package:blog_app/src/lib/features/auth/presentation/logic/controlls/auth_controller.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/icomentarios_repository.dart';
import 'package:blog_app/src/lib/features/hilo/presentation/logic/controllers/ver_hilo_controller.dart';
import 'package:blog_app/src/lib/features/media/presentation/enlaces/abrir_enlace_externo_bottomsheet.dart';
import 'package:blog_app/src/lib/features/media/presentation/multi_media.dart';
import 'package:blog_app/src/lib/features/moderacion/presentation/ver_usuario_panel.dart';
import 'package:blog_app/src/lib/features/usuarios/domain/models/usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../app/presentation/logic/horarios_service.dart';
import '../../domain/models/comentario.dart';
import 'colores.dart';
import 'tags.dart';

abstract class ComentarioCard extends StatelessWidget {
  const ComentarioCard._({super.key});

  const factory ComentarioCard({
    Key? key,
    required Widget child,
  }) = _ComentarioCard;

  const factory ComentarioCard.comentario({
    Key? key,
    required Comentario comentario,
  }) = _ComentarioCardEntity;
}

class _ComentarioCard extends ComentarioCard {
  final Widget child;

  const _ComentarioCard({super.key, required this.child}) : super._();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          child: child,
        ),
      ),
    );
  }
}

class _ComentarioCardEntity extends ComentarioCard {
  final Comentario comentario;

  const _ComentarioCardEntity({
    super.key,
    required this.comentario,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: comentario,
      builder: (context, child) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onLongPress: () => ComentarioOpcionesBottomSheet.show(context),
        child: ComentarioCard(
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
              const _Texto(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Texto extends StatelessWidget {
  static final RegExp _tag = RegExp(">>[A-Z0-9]{7}");
  static final RegExp _greenText = RegExp("dasdassadas");
  static final RegExp _url = RegExp(
    r'(https:\/\/www\.|http:\/\/www\.|https:\/\/|http:\/\/)?[a-zA-Z0-9]{2,}(\.[a-zA-Z0-9]{2,})(\.[a-zA-Z0-9]{2,})?',
  );

  static final Map<RegExp, Maker> _makers = {
    _url: (context, match) => TextSpan(
          text: match.group(0),
          style: const TextStyle(
            color: CupertinoColors.link,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              showMaterialModalBottomSheet(
                context: context,
                builder: (context) {
                  return AbrirEnlaceExternoBottomSheet(url: match.group(0)!);
                },
              );
            },
        ),
    _greenText: (context, match) => TextSpan(
          text: match.group(0),
          style: const TextStyle(
            color: CupertinoColors.systemRed,
          ),
        ),
    _tag: (context, match) => TextSpan(
          text: match.group(0),
          style: const TextStyle(
            color: CupertinoColors.systemYellow,
          ),
        ),
  };

  const _Texto({super.key});

  @override
  Widget build(BuildContext context) {
    final Comentario comentario = context.read();

    final String texto = comentario.texto;

    final List<TextSpan> spans = [];
    int currentIndex = 0;

    var matches = [
      ..._tag.allMatches(texto),
      ..._greenText.allMatches(texto),
      ..._url.allMatches(texto),
    ]..sort(
        (a, b) => (a.start.compareTo(b.start)),
      );

    for (final match in matches) {
      // Agregar el texto sin resaltar antes de la coincidencia
      spans.add(
        TextSpan(
          style: const TextStyle(color: Colors.black),
          text: texto.substring(currentIndex, match.start),
        ),
      );

      // Agregar el texto resaltado
      spans.add(
        _makers[match.pattern]!(context, match),
      );

      currentIndex = match.end;
    }

    // Agregar el texto restante después de la última coincidencia
    spans.add(
      TextSpan(
        style: const TextStyle(color: Colors.black),
        text: texto.substring(currentIndex),
      ),
    );

    return RichText(
      text: TextSpan(
        children: spans,
        style: const TextStyle(fontSize: 15),
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
            const ColorDeComentario(),
            const SizedBox(
              width: 3,
            ),
            Row(
              children: [
                Text(
                  comentario.op.nombre,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TagsDeComentarios(),
              ],
            ),
          ],
        ),
        Text(
          HorariosService.diferencia(
            utcNow: DateTime.now().toUtc(),
            time: comentario.creado_en,
          ).toString(),
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

typedef Maker = TextSpan Function(BuildContext context, Match match);

class ComentarioOpcionesBottomSheet extends StatelessWidget {
  const ComentarioOpcionesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final Comentario comentario = context.read();
    return RoundedBottomSheet.normal(
      child: Column(
        children: [
          ...[
            const GrupoSeleccionable(
              seleccionables: [
                ItemSeleccionable.text(titulo: "Ocultar"),
                ItemSeleccionable.text(titulo: "Denunciar"),
              ],
            ),
            if (true || (Get.find<HiloController>().hilo.value?.esOp ?? false))
              const GrupoSeleccionable(
                seleccionables: [
                  ItemSeleccionable.text(
                    titulo: "Destacar",
                    leading: FaIcon(
                      FontAwesomeIcons.thumbtack,
                      size: 14,
                    ),
                  ),
                ],
              ),
            if (true ||
                Get.find<AuthController>().usuario.value?.rango is Moderador)
              GrupoSeleccionable(
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
          ].addPadding(),
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
