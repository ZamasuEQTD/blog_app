// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/src/lib/features/app/presentation/widgets/bottom_sheet.dart';
import 'package:blog_app/src/lib/features/auth/presentation/widgets/dialog/logic/controlls/auth_controller.dart';
import 'package:blog_app/src/lib/features/hilo/presentation/logic/controllers/ver_hilo_controller.dart';
import 'package:blog_app/src/lib/features/media/domain/igallery_service.dart';
import 'package:blog_app/src/lib/features/media/presentation/multi_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'package:blog_app/src/lib/features/app/presentation/widgets/item_seleccionable.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../app/presentation/widgets/colored_icon_button.dart';
import '../../../app/presentation/widgets/grupo_seleccionable.dart';
import '../../../media/domain/models/media.dart';
import '../../../media/presentation/logic/blocs/gestor_de_media/gestor_de_media_bloc.dart';
import '../../../media/presentation/miniatura.dart';
import '../blocs/comentar_hilo/comentar_hilo_bloc.dart';

class ComentarHiloBottomSheet extends StatefulWidget {
  const ComentarHiloBottomSheet({super.key});

  @override
  State<ComentarHiloBottomSheet> createState() =>
      _ComentarHiloBottomSheetState();
}

class _ComentarHiloBottomSheetState extends State<ComentarHiloBottomSheet> {
  final VerHiloController controller = Get.find();
  final AuthController auth = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        showMaterialModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return const ComentarHiloOpcionesItems();
          },
        );
      },
      child: Obx(
        () => IgnorePointer(
          ignoring: auth.usuario.value == null,
          child: ColoredBox(
            color: Theme.of(context).colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => controller.media.value != null
                        ? Row(
                            children: <Media>[controller.media.value!]
                                .map(
                                  (x) => GestureDetector(
                                    onTap: () {
                                      _showMediaBottomSheet(context, x);
                                    },
                                    child: Miniatura(
                                      key: UniqueKey(),
                                      media: x,
                                    ),
                                  ),
                                )
                                .toList(),
                          )
                        : const SizedBox(),
                  ),
                  Row(
                    children: [
                      ColoredIconButton(
                        onPressed: () {
                          showMaterialModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return BlocProvider.value(
                                value: context.read<GestorDeMediaBloc>(),
                                child: const ComentarHiloOpcionesItems(),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.three_k_rounded),
                      ),
                      const _ComentarInput(),
                      Obx(
                        () => ColoredIconButton(
                          onPressed: () => controller.enviarComentario,
                          icon: const Icon(Icons.send),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showMediaBottomSheet(BuildContext context, Media x) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return RoundedBottomSheet.sliver(
          slivers: [
            SliverToBoxAdapter(
              child: DimensionableScope(
                builder: (context, dimensionable) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 350,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          child: dimensionable,
                        ),
                      ),
                    ],
                  ),
                ),
                child: MultiMedia(media: x),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              sliver: GrupoSeleccionableSliver(
                seleccionables: [
                  VerMediaOpcion.spoiler(),
                  VerMediaOpcion.eliminar(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ComentarInput extends StatelessWidget {
  const _ComentarInput({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: Get.find<VerHiloController>().comentarioController,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: !isKeyboardVisible ? 1 : 4,
          ),
        ),
      ),
    );
  }
}

class ComentarHiloOpcionesItems extends StatelessWidget {
  const ComentarHiloOpcionesItems({super.key});

  @override
  Widget build(BuildContext context) {
    return const RoundedBottomSheet.sliver(
      slivers: [
        GrupoSeleccionableSliver(
          seleccionables: [
            OpcionDeComentario.agregarEnlace(),
            OpcionDeComentario.agregarMedia(),
          ],
        ),
      ],
    );
  }
}

abstract class VerMediaOpcion extends StatelessWidget {
  const VerMediaOpcion._({super.key});

  const factory VerMediaOpcion.spoiler() = _MarcarComoSpoiler;
  const factory VerMediaOpcion.eliminar() = _EliminarMedia;
}

class _MarcarComoSpoiler extends VerMediaOpcion {
  const _MarcarComoSpoiler({super.key}) : super._();
  @override
  Widget build(BuildContext context) {
    return ItemSeleccionable.checkbox(
      onChange: (value) {},
      titulo: "Marcar como spoiler",
      value: true,
    );
  }
}

class _EliminarMedia extends VerMediaOpcion {
  const _EliminarMedia({super.key}) : super._();
  @override
  Widget build(BuildContext context) {
    return ItemSeleccionable.text(
      trailing: ClipOval(
        child: ColoredBox(
          color: Theme.of(context).colorScheme.onSurface,
          child: SizedBox.square(
            dimension: 30,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: FaIcon(
                  FontAwesomeIcons.trash,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Get.find<VerHiloController>().eliminarMedia();
        context.pop();
      },
      titulo: "Eliminar",
    );
  }
}

abstract class OpcionDeComentario extends StatelessWidget {
  const OpcionDeComentario._({super.key});
  const factory OpcionDeComentario({
    required void Function() onTap,
    required String opcion,
  }) = _OpcionDeComentario;

  const factory OpcionDeComentario.agregarEnlace() = _AgregarEnlace;
  const factory OpcionDeComentario.agregarMedia() = _AgregarMediaItem;
}

class _OpcionDeComentario extends OpcionDeComentario {
  final String opcion;
  final void Function() onTap;

  const _OpcionDeComentario({
    required this.opcion,
    required this.onTap,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return ItemSeleccionable.text(titulo: opcion, onTap: onTap);
  }
}

class _AgregarEnlace extends OpcionDeComentario {
  const _AgregarEnlace() : super._();

  @override
  Widget build(BuildContext context) {
    return OpcionDeComentario(onTap: () {}, opcion: "Agregar enlace");
  }
}

class _AgregarMediaItem extends OpcionDeComentario {
  const _AgregarMediaItem({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return OpcionDeComentario(
      onTap: () async {
        IGalleryService service = GetIt.I.get();

        var response = await service.pickFile(extensions: []);

        response.fold((l) => null, (r) {
          if (r != null) {
            Get.find<VerHiloController>().agregarMedia(r);
          }
        });
      },
      opcion: "Agregar desde galeria",
    );
  }
}

class AgregarEnlaces extends StatefulWidget {
  final void Function(String url) onAgregar;
  const AgregarEnlaces({
    super.key,
    required this.onAgregar,
  });

  @override
  State<AgregarEnlaces> createState() => _AgregarEnlacesState();
}

class _AgregarEnlacesState extends State<AgregarEnlaces> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              widget.onAgregar(controller.text);
            },
            child: const Text("Agregar"),
          ),
        ],
      ),
      body: TextField(
        minLines: 5,
        maxLines: 5,
        decoration: const InputDecoration(
          hintText: "Enlace",
        ),
        controller: controller,
      ),
    );
  }
}
