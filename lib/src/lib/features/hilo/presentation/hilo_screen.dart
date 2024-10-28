import 'package:blog_app/src/lib/features/app/presentation/widgets/effects/blur/blur_effect.dart';
import 'package:blog_app/src/lib/features/categorias/presentation/subcategoria_tile.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/src/lib/features/hilo/presentation/logic/controllers/ver_hilo_controller.dart';
import 'package:blog_app/src/lib/features/hilo/presentation/widgets/banderas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../comentarios/presentation/widgets/comentario.dart';
import '../../media/presentation/multi_media.dart';
import '../domain/models/hilo.dart';
import 'widgets/acciones.dart';
import 'widgets/comentar_hilo.dart';

class HiloScreen extends StatefulWidget {
  final String id;
  const HiloScreen({super.key, required this.id});

  @override
  State<HiloScreen> createState() => _HiloScreenState();
}

class _HiloScreenState extends State<HiloScreen> {
  late final HiloController controller = Get.put(
    HiloController(id: widget.id),
  );

  @override
  void initState() {
    controller.cargar(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const ComentarHiloBottomSheet(),
      body: Obx(
        () => !(controller.hilo.value == null)
            ? Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: CustomScrollView(
                  controller: controller.scrollController,
                  slivers: [
                    InformacionDeHilo(
                      hilo: (controller.hilo.value!),
                    ),
                    const ComentariosEnHilo(),
                  ],
                ),
              )
            : Container(),
      ),
    );
  }
}

class InformacionDeHilo extends StatelessWidget {
  final Hilo hilo;
  const InformacionDeHilo({super.key, required this.hilo});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
          color: Theme.of(context).colorScheme.onSurface,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BanderasDeHiloRow(hilo: hilo),
                SubcategoriaTile(subcategoria: hilo.categoria),
                HiloAccionesRow(
                  hilo: hilo,
                ),
                Center(
                  child: DimensionableScope(
                    constraints: const BoxConstraints(
                      maxHeight: 500,
                      maxWidth: double.infinity,
                    ),
                    child: MultiMedia(
                      media: hilo.portada.spoileable,
                    ),
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
  final Map<ComentarioId, GlobalKey> keys = {};
  final HiloController controller = Get.find();
  @override
  void initState() {
    controller.cargarComentarios();

    context.read<HiloController>().comentariosAgregados.listen(
      (comentarios) {
        for (var element in comentarios) {
          keys[element.id] = GlobalKey();
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (controller) => SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              child: Text(
                "Comentarios ${controller.hilo.value!.comentarios}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemCount: controller.comentarios.value.length,
            itemBuilder: (context, index) {
              return ComentarioCard.comentario(
                key: keys[controller.comentarios.value[index].id],
                comentario: controller.comentarios.value[index],
              );
            },
          ),
        ],
      ),
    );
  }
}

class TituloStyle extends TextStyle {
  const TituloStyle() : super(fontSize: 29, fontWeight: FontWeight.w900);
}

class AlturaController extends ChangeNotifier {
  double altura = 0;

  void cambiar(double altura) {
    this.altura = altura;
    notifyListeners();
  }
}

class HiloScreenCargando extends StatelessWidget {
  const HiloScreenCargando({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MediaSpoileable extends StatelessWidget {
  final Widget child;
  const MediaSpoileable({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        BlurEffect.builder(
          blurear: true,
          builder: (controller, child) {
            if (controller.blurear) {
              return Positioned.fill(
                child: ColoredBox(
                  color: Colors.black.withOpacity(0.3),
                  child: Stack(
                    children: [
                      Positioned.fill(child: child),
                      const _VerContenidoButton(),
                    ],
                  ),
                ),
              );
            }
            return child;
          },
        ),
      ],
    );
  }
}

class _VerContenidoButton extends StatelessWidget {
  const _VerContenidoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: OutlinedButton(
          onPressed: () => context.read<BlurController>().switchBlur(),
          style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(Colors.white.withOpacity(0.15)),
            side: const WidgetStatePropertyAll(
              BorderSide(width: 0.5, color: Colors.transparent),
            ),
            shape: const WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
            ),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            ),
          ),
          child: const FittedBox(
            child: Text(
              "Ver contenido",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HiloContext extends InheritedWidget {
  final String id;

  const HiloContext({
    super.key,
    required this.id,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant HiloContext oldWidget) {
    return id != oldWidget.id;
  }
}
