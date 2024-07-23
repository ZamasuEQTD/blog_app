import 'package:blog_app/common/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/common/widgets/media/widgets/image/image_overlapped.dart';
import 'package:blog_app/common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import 'package:blog_app/common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import 'package:blog_app/domain/features/home/entities/home_portada_de_hilo.dart';
import 'package:blog_app/presentation/media/logic/extensions/media_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/effects/blur/blurear_widget.dart';
import '../../../../common/widgets/effects/gradient/gradient_effect.dart';
import 'features/banderas.dart';
import 'features/tags.dart';

class HomePortada extends StatelessWidget {
  final HomePortadaDeHilo portada;
  const HomePortada({
    super.key, 
    required this.portada
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DraggableSeleccionableBottomSheet.show(context, 
        grupos: [
          GrupoSeleccionable(seleccionables: [
            CheckboxSeleccionableList(nombre: "Eliminar",onChange: (value) {}, value: false),
            ItemSeleccionableTileList( 
              icon: CupertinoIcons.add,
              nombre: "Agregar"
            ),
          ]),
          GrupoSeleccionable(seleccionables: [
            EliminarItem.fromContext(context),
            EliminarItem.fromContext(context),
            EliminarItem.fromContext(context),
            EliminarItem.fromContext(context)
          ])
        ]);
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 200,
            width: 200,
            child: ImageOverlapped.provider(
                provider: portada.portada.spoileable.toProvider(),
                boxFit: BoxFit.cover,
                child: _getChild()
              )
          )
        ),
    );
  }
  Widget _getChild() => portada.portada.esSpoiler? SobreBlur(child: PortadaDeHiloHomeBody(portada: portada)) : PortadaDeHiloHomeBody(portada: portada);
}



class PortadaDeHiloHomeBody extends StatelessWidget {
  final HomePortadaDeHilo portada;

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
  final HomePortadaDeHilo portada;
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
          Text(
            portada.titulo,
            maxLines: 2,
            style:const TituloDePortadaTextStyle()
          )
        ],
      ),
    );
  }
}


class TituloDePortadaTextStyle extends TextStyle {
  const TituloDePortadaTextStyle(): super(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    overflow: TextOverflow.ellipsis,
    color: Colors.white
  );
}


class PortadaDeHiloHomeFeatures extends StatelessWidget {
  final HomePortadaDeHilo portada;
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
