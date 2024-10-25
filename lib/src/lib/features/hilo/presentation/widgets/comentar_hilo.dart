// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/src/lib/features/app/presentation/widgets/bottom_sheet.dart';
import 'package:blog_app/src/lib/features/media/domain/igallery_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get_it/get_it.dart';

import 'package:blog_app/src/lib/features/app/presentation/widgets/item_seleccionable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../app/presentation/widgets/colored_icon_button.dart';
import '../../../app/presentation/widgets/grupo_seleccionable.dart';
import '../../../media/data/file_picker_gallery_service.dart';
import '../../../media/presentation/logic/blocs/gestor_de_media/gestor_de_media_bloc.dart';
import '../../../media/presentation/miniatura.dart';
import '../blocs/comentar_hilo/comentar_hilo_bloc.dart';

class ComentarHiloBottomSheet extends StatelessWidget {
  const ComentarHiloBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<GestorDeMediaBloc, GestorDeMediaState>(
              builder: (context, state) {
                return Row(
                  children: state.medias
                      .map(
                        (x) => GestureDetector(
                          onTap: () => context
                              .read<GestorDeMediaBloc>()
                              .add(const EliminarMedia()),
                          child: GestureDetector(
                            onTap: () {},
                            child: Miniatura(
                              key: UniqueKey(),
                              media: x,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            const SizedBox(
              height: 5,
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
                ColoredIconButton(
                  onPressed: () =>
                      context.read<ComentarHiloBloc>().add(EnviarComentario()),
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ComentarInput extends StatefulWidget {
  const _ComentarInput({super.key});

  @override
  State<_ComentarInput> createState() => __ComentarInputState();
}

class __ComentarInputState extends State<_ComentarInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.addListener(
      () => context.read<ComentarHiloBloc>().add(
            CambiarComentario(
              comentario: _controller.text,
            ),
          ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ComentarHiloBloc, ComentarHiloState>(
      listenWhen: (previous, current) => previous.taggueo != current.taggueo,
      listener: (context, state) {
        if (state.taggueo != null) {
          _controller.text = '${_controller.text}>>${state.taggueo}';
        }
      },
      child: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: !isKeyboardVisible ? 1 : 4,
            ),
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
      sliver: GrupoSeleccionableSliver(
        seleccionables: [
          OpcionDeComentario.agregarEnlace(),
          OpcionDeComentario.agregarMedia(),
        ],
      ),
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
            context.read<GestorDeMediaBloc>().add(AgregarMedia(media: r));
          }
        });
      },
      opcion: "Agregar desde galeria mi nepe",
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
