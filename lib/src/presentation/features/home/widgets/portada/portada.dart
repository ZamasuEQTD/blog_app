
import 'package:blog_app/src/domain/features/home/models/portada.dart';
import 'package:blog_app/src/presentation/common/widgets/bottom_sheet/rounded_bottom_sheet.dart';
import 'package:blog_app/src/presentation/common/widgets/effects/blur/blurear_widget.dart';
import 'package:blog_app/src/presentation/common/widgets/effects/gradient/gradient_effect.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/widget/grupo_seleccionable_list.dart';
import 'package:blog_app/src/presentation/common/widgets/text/titulo_global.dart';
import 'package:blog_app/src/presentation/features/media/extensions/media_extensions.dart';
import 'package:blog_app/src/presentation/features/media/widgets/image/image_overlapped.dart';
import 'package:flutter/material.dart';

import 'features/banderas.dart';
import 'features/tags.dart';

class PortadaDeHiloHome extends StatelessWidget {
  final PortadaHome portada;

  const PortadaDeHiloHome({super.key, required this.portada});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => OpcionesDePortadaHomeBottomSheet.show(context),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 200,
            width: 200,
            child: ImageOverlapped.provider(
                provider: portada.imagen.spoileable.toProvider(),
                boxFit: BoxFit.cover,
                child: _getChild()
              )
          )
        ),
    );
  }

  Widget _getChild() => portada.imagen.esSpoiler? SobreBlur(child: PortadaDeHiloHomeBody(portada: portada)) : PortadaDeHiloHomeBody(portada: portada);
}


class PortadaDeHiloHomeBody extends StatelessWidget {
  final PortadaHome portada;

  const PortadaDeHiloHomeBody({
    super.key, 
    required this.portada
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GradientEffectWidget(
          colors: const [
            Colors.black45,
            Colors.transparent,
            Colors.transparent,
            Colors.black45
          ],
          stops: const [0.0, 0.3, 0.6, 1.0],
        ),
        PortadaDeHiloHomeInformacion(portada: portada),
      ],
    );
  }
}


class PortadaDeHiloHomeInformacion extends StatelessWidget {
  final PortadaHome portada;
  const PortadaDeHiloHomeInformacion({
    super.key, 
    required this.portada
  });

  @override
  Widget build(BuildContext context) {
     return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PortadaDeHiloHomeFeatures(
            portada: portada,
          ),
          TituloGlobal(
            txt: portada.titulo,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            customStyle: const TextStyle(
              color: Colors.white
            ),
          )
        ],
      ),
    );
  }
}

class PortadaDeHiloHomeFeatures extends StatelessWidget {
  final PortadaHome portada;
  const PortadaDeHiloHomeFeatures({
    super.key, 
    required this.portada
  });
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          TagsDePortadaHome(portada: portada),
          BanderasDePortadaHome(portada: portada)
        ],
    );
  }
}


class OpcionesDePortadaHomeBottomSheet extends StatelessWidget {
  final Widget child;
  const OpcionesDePortadaHomeBottomSheet({
    super.key, 
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [child],
    );
  }


  static void show(BuildContext context){
    GruposSeleccionableBottomSheet.show(
      context,
      grupos: [
        GrupoSeleccionable(seleccionables: [
          EliminarItem.fromContext(context)
        ])
      ],
      builder: (child) => OpcionesDePortadaHomeBottomSheet(
        child: child
      ),
    );
  }
}

class GruposSeleccionableBottomSheet extends StatelessWidget {
  final ScrollController? scrollController;
  final List<GrupoSeleccionable> grupos;
  final Widget Function(Widget child)? builder;
  const GruposSeleccionableBottomSheet({
    super.key, 
    this.scrollController, 
    required this.grupos, 
    this.builder
  });

  @override
  Widget build(BuildContext context) {
    if(builder != null) {
      return builder!(_getChild());
    }
    return _getChild();
  }


  Widget _getChild() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: GrupoSeleccionableList(
        seleccionables: grupos,
        controller: scrollController
      ),
    );
  }


  static void show(BuildContext context,{
    required List<GrupoSeleccionable> grupos,
    ScrollController? scrollController,
    Widget Function(Widget child)? builder
  }) {
    RoundedBottomSheetManager.show(
      context: context, 
      child: GruposSeleccionableBottomSheet(
        scrollController: scrollController,
        grupos: grupos,
        builder: builder
      ) 
    );
  }

}