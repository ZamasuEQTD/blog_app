import 'package:blog_app/domain/features/hilo/entities/hilo.dart';
import 'package:flutter/material.dart';

class FeaturesIconsDeHilo extends StatelessWidget {
  final BanderasDeHilo banderas;

  const FeaturesIconsDeHilo({super.key, required this.banderas});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const BackButton(),
              ..._getIcons(banderas)
                  .map((e) => Row(children: [e, const SizedBox(width: 5)]))
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _getIcons(BanderasDeHilo banderasDeHilo) {
    List<Widget> widgets = [];

    if (banderas.dadosActivado) {
      widgets.add(const IconFeature(iconData: Icons.directions_bus));
    }

    if (banderas.encuesta) {
      widgets.add(const IconFeature(iconData: Icons.directions_bus));
    }

    if (banderas.idUnicoActivado) {
      widgets.add(const IconFeature(iconData: Icons.directions_bus));
    }
    return widgets;
  }
}

class IconFeature extends StatelessWidget {
  final IconData iconData;
  const IconFeature({
    super.key,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: const Color.fromRGBO(199, 199, 199, 1), width: 1.25)),
        height: 30,
        width: 30,
        padding: const EdgeInsets.all(4),
        child: FittedBox(child: Icon(iconData)),
      ),
    );
  }
}
