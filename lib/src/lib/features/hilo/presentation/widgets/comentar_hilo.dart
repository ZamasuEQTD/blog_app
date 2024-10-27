// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/src/lib/features/app/presentation/widgets/bottom_sheet.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/measured_sized.dart';
import 'package:blog_app/src/lib/features/auth/presentation/widgets/sesion_requerida.dart';
import 'package:blog_app/src/lib/features/baneos/domain/models/baneo.dart';
import 'package:blog_app/src/lib/features/baneos/presentation/has_sido_baneado_bottomsheet.dart';
import 'package:blog_app/src/lib/features/media/domain/igallery_service.dart';
import 'package:blog_app/src/lib/features/media/presentation/extensions/media_extensions.dart';
import 'package:blog_app/src/lib/features/media/presentation/multi_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

import 'package:blog_app/src/lib/features/app/presentation/widgets/item_seleccionable.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../app/presentation/widgets/colored_icon_button.dart';
import '../../../app/presentation/widgets/grupo_seleccionable.dart';
import '../../../auth/presentation/blocs/auth/auth_bloc.dart';
import '../../../media/data/file_picker_gallery_service.dart';
import '../../../media/domain/models/media.dart';
import '../../../media/presentation/logic/blocs/gestor_de_media/gestor_de_media_bloc.dart';
import '../../../media/presentation/miniatura.dart';
import '../blocs/comentar_hilo/comentar_hilo_bloc.dart';
import '../hilo_screen.dart';

class ComentarHiloBottomSheet extends StatelessWidget {
  const ComentarHiloBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            showMaterialModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return HasSidoBaneadoBottomsheet(
                  baneo: Baneo(
                    id: "id",
                    moderador: "Codubi",
                    mensaje:
                        "La proxima vez no postes cepita de nenitos... Ok, solo se pueden de nenitas",
                    finaliza: DateTime(2100),
                  ),
                );
              },
            );
          },
          child: IgnorePointer(
            ignoring: state is! SesionIniciada,
            child: AlturaNotifier(
              onSizeChange: (size) {
                context.read<AlturaController>().cambiar(size.height);
              },
              child: ColoredBox(
                color: Theme.of(context).colorScheme.surface,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
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
                                      onTap: () {
                                        _showMediaBottomSheet(context, x);
                                      },
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
                            onPressed: () => context
                                .read<ComentarHiloBloc>()
                                .add(EnviarComentario()),
                            icon: const Icon(Icons.send),
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
      },
    );
  }

  Future<dynamic> _showMediaBottomSheet(BuildContext context, Media x) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<GestorDeMediaBloc>(),
          child: RoundedBottomSheet.sliver(
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
          ),
        );
      },
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
        context.read<GestorDeMediaBloc>().add(
              const EliminarMedia(),
            );
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
