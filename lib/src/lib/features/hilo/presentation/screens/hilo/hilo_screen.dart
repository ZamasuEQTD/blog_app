import 'package:blog_app/src/lib/features/app/presentation/extensions/scroll_controller_extensions.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/dialogs/bottom_sheet.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/effects/blur/contenido_censurable.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/item_seleccionable.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/seleccionable/grupo_seleccionable.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/snackbar.dart';
import 'package:blog_app/src/lib/features/baneos/domain/failures/estas_baneado_failure.dart';
import 'package:blog_app/src/lib/features/baneos/presentation/has_sido_baneado_bottomsheet.dart';
import 'package:blog_app/src/lib/features/categorias/domain/models/categoria.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/src/lib/features/encuestas/domain/models/encuesta.dart';
import 'package:blog_app/src/lib/features/encuestas/presentation/encuesta.dart';
import 'package:blog_app/src/lib/features/hilo/presentation/screens/hilo/logic/controllers/ver_hilo_controller.dart';
import 'package:blog_app/src/lib/features/hilo/presentation/screens/hilo/widgets/banderas.dart';
import 'package:blog_app/src/lib/features/media/presentation/extensions/media_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../app/presentation/controllers/altura_controller.dart';
import '../../../../comentarios/presentation/widgets/comentario.dart';
import '../../../../media/presentation/multi_media.dart';
import '../../../domain/models/hilo.dart';
import 'widgets/acciones.dart';
import 'widgets/comentar_hilo.dart';

class HiloScreen extends StatefulWidget {
  final String id;
  const HiloScreen({super.key, required this.id});

  @override
  State<HiloScreen> createState() => _HiloScreenState();
}

class _HiloScreenState extends State<HiloScreen> {
  final ScrollController scroll = ScrollController();
  late final HiloController controller = Get.put(
    HiloController(id: widget.id),
  )..cargar();

  final AlturaController alturaController = AlturaController();

  @override
  void initState() {
    scroll.addListener(
      () {
        if (scroll.IsBottom) {
          controller.cargarComentarios();
        }
      },
    );

    controller.failure.listen((failure) {
      if (failure != null) {
        if (failure is EstasBaneadoFailure) {
          HasSidoBaneadoBottomsheet.show(context, baneo: failure.baneo);
        }
        Snackbars.showFailure(context, failure);

        controller.failure.value = null;
      }
    });

    alturaController.altura.listen((altura) {
      controller.bottom.value = altura;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: Obx(
        () {
          if (controller.hilo.value != null) {
            return ListenableProvider.value(
              value: alturaController,
              child: const ComentarHiloBottomSheet(),
            );
          }
          return const SizedBox();
        },
      ),
      body: Obx(
        () => !(controller.hilo.value == null)
            ? Provider.value(
                value: controller.hilo.value,
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: controller.bottom.value,
                  ),
                  child: CustomScrollView(
                    controller: scroll,
                    slivers: const [
                      //HiloScreenAppBar(),
                      InformacionDeHilo(),
                      ComentariosEnHilo(),
                    ],
                  ),
                ),
              )
            : Container(),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<HiloController>();
    super.dispose();
  }
}

class InformacionDeHilo extends StatelessWidget {
  const InformacionDeHilo({super.key});

  @override
  Widget build(BuildContext context) {
    final Hilo hilo = context.read();

    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
          color: Color(0xffF1F1F1),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BanderasDeHiloRow(),
                SubcategoriaDeHiloTile(subcategoria: hilo.categoria),
                const HiloAccionesRow(),
                const EncuestaView(
                  encuesta: Encuesta(
                    respuesta: null,
                    respuestas: [
                      Respuesta(
                        id: "pep",
                        respuesta: "Ma\nsha ",
                        votos: 0,
                      ),
                      Respuesta(
                        id: "peep",
                        respuesta: "Sidako",
                        votos: 0,
                      ),
                      Respuesta(
                        id: "sp",
                        respuesta: "La tigresa",
                        votos: 0,
                      ),
                      Respuesta(
                        id: "peep",
                        respuesta: "Franchesca",
                        votos: 0,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: DimensionableScope(
                    constraints: const BoxConstraints(
                      maxHeight: 500,
                      maxWidth: double.infinity,
                    ),
                    builder: (context, dimensionable) {
                      Widget child = dimensionable;

                      if (hilo.portada.esSpoiler) {
                        child = ContenidoCensurable(child: dimensionable);
                      }

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: child,
                      );
                    },
                    child: hilo.portada.spoileable.widget,
                  ),
                ),
                Text(
                  hilo.titulo,
                  style: const TituloStyle(),
                ),
                Text(
                  hilo.descripcion,
                  style: const TextStyle(fontSize: 18),
                ),
              ]
                  .map(
                    (w) => Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: w,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class ComentariosEnHilo extends StatefulWidget {
  const ComentariosEnHilo({super.key});

  @override
  State<ComentariosEnHilo> createState() => _ComentariosEnHiloState();
}

class _ComentariosEnHiloState extends State<ComentariosEnHilo> {
  final Map<ComentarioId, GlobalKey> comentariosKeys = {};

  final Map<ComentarioId, GlobalKey> comentariosDestacadoKeys = {};

  final HiloController controller = Get.find()..cargarComentarios();

  @override
  void initState() {
    controller.ultimoComentarioAgregado.listen(
      (comentario) {
        if (comentario != null) {
          if (comentario.destacado) {
            comentariosDestacadoKeys[comentario.id] = GlobalKey();
          } else {
            comentariosKeys[comentario.id] = GlobalKey();
          }
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: Text(
              "Comentarios ${controller.hilo.value!.comentarios}",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ).marginSymmetric(vertical: 10, horizontal: 5),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 10),
            sliver: SliverList.builder(
              itemCount: controller.comentarios.value.length,
              itemBuilder: (context, index) {
                final comentario = controller.comentarios.value[index];

                var key = comentario.destacado
                    ? comentariosDestacadoKeys[comentario.id]
                    : comentariosKeys[comentario.id];

                return ComentarioCard.comentario(
                  key: key,
                  comentario: controller.comentarios.value[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TituloStyle extends TextStyle {
  const TituloStyle() : super(fontSize: 29, fontWeight: FontWeight.w900);
}

class HiloScreenCargando extends StatelessWidget {
  const HiloScreenCargando({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HiloOpciones extends StatelessWidget {
  const HiloOpciones({super.key});

  @override
  Widget build(BuildContext context) {
    final HiloController controller = Get.find();
    return RoundedBottomSheet.sliver(
      slivers: [
        GrupoItemSeleccionable.sliver(
          seleccionables: [
            ItemSeleccionable.text(
              titulo: "Denunciar",
              onTap: () {},
            ),
          ],
        ),
        if (controller.hilo.value!.esOp)
          const GrupoItemSeleccionable.sliver(
            seleccionables: [
              ItemSeleccionable.text(titulo: "Desactivar notificaciones"),
            ],
          ),
        GrupoItemSeleccionable.sliver(
          seleccionables: [
            ItemSeleccionable.text(
              titulo: "Ver usuario",
              onTap: () {
                showMaterialModalBottomSheet(
                  context: context,
                  builder: (context) {
                    //return const VerUsuarioPanel(usuario: "");
                    return const SizedBox();
                  },
                );
              },
            ),
            const ItemSeleccionable.text(titulo: "Eliminar"),
          ],
        ),
      ],
    );
  }
}

class HiloScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HiloScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(Get.find<HiloController>().hilo.value!.titulo),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SubcategoriaDeHiloTile extends StatelessWidget {
  final Subcategoria subcategoria;
  const SubcategoriaDeHiloTile({super.key, required this.subcategoria});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 10,
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox.square(
                  dimension: 30,
                  child: Image(image: subcategoria.imagen.toProvider),
                ),
              ),
              const SizedBox(width: 10),
              Text(subcategoria.nombre),
            ],
          ),
        ),
      ),
    );
  }
}
