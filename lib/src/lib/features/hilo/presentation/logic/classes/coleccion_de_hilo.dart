import 'package:blog_app/src/lib/features/hilo/presentation/widgets/portada.dart';
import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class ColeccionDeHilo extends StatelessWidget {
  const ColeccionDeHilo({super.key});
}

class ColeccionDeHiloLoaded extends ColeccionDeHilo {
  final Portada portada;

  const ColeccionDeHiloLoaded({
    super.key,
    required this.portada,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push("/hilo/${portada.id}"),
      child: PortadaView.portada(portada: portada),
    );
  }
}

class ColeccionDeHiloBone extends ColeccionDeHilo {
  const ColeccionDeHiloBone({super.key});

  @override
  Widget build(BuildContext context) {
    return const PortadaView.bone();
  }
}
