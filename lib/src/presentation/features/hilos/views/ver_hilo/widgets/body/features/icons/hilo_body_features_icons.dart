import 'package:flutter/material.dart';

import '../../../../../../../../../domain/features/hilos/models/hilo.dart';
import 'hilo_icon_feature.dart';

class HiloIconsFeaturesBar extends StatelessWidget {
  final BanderasDeHilo banderas;
  const HiloIconsFeaturesBar({super.key, required this.banderas});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.only(bottom: 5),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const BackButton(),
              ..._getIcons(banderas).map((e) => Row(children: [e, const SizedBox(width: 5)]))
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _getIcons(BanderasDeHilo banderasDeHilo) {
    List<Widget> widgets = [];

    if(banderas.dadosActivado) {
      widgets.add(const HiloIconFeature(
        iconData:Icons.directions_bus 
      ));
    }
    
    if(banderas.encuesta) {
      widgets.add(const HiloIconFeature(iconData: Icons.directions_bus));
    }

    if(banderas.idUnicoActivado){
      widgets.add(const HiloIconFeature(iconData: Icons.directions_bus));
    }
    return widgets;
  }
}
