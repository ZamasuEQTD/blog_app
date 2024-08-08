import 'dart:collection';

import 'package:blog_app/common/widgets/button/filled_icon_button.dart';
import 'package:flutter/material.dart';

import '../../domain/models/comentario.dart';
import '../../domain/models/hilo.dart';

class HiloScreen extends StatefulWidget {
  static final HashMap<BanderasDeHilo, Widget> _banderas = HashMap();

  const HiloScreen({super.key});

  @override
  State<HiloScreen> createState() => _HiloScreenState();
}

class _HiloScreenState extends State<HiloScreen> {
  final Hilo? hilo = null;

  final HashMap<ComentarioId, GlobalKey> _keys = HashMap();

  @override
  Widget build(BuildContext context) {
    Hilo hilo = this.hilo!;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(7),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
              color: Color.fromRGBO(225, 225, 225, 1),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //banderas
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          BackButton(),
                          ...hilo!.banderas.map((bandera) => OutlinedIcon(
                              child: HiloScreen._banderas[bandera]!))
                        ],
                      ),
                    ),
                    //subcategoria
                    //acciones
                    Row(),
                    //portada
                    //titulo
                    Text(
                      hilo.titulo,
                      style: const TituloStyle(),
                    ),
                    //descripcion
                    Text(
                      hilo.descripcion,
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverList.builder(itemBuilder: (context, index) {
          
        })
      ],
    );
  }
}

class OutlinedIcon extends StatelessWidget {
  final Widget child;
  const OutlinedIcon({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: const Color.fromRGBO(199, 199, 199, 1), width: 1.25)),
      child: child,
    );
  }
}

class TituloStyle extends TextStyle {
  const TituloStyle() : super(fontSize: 29, fontWeight: FontWeight.w900);
}
