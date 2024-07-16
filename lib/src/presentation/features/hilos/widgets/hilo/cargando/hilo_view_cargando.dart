import 'package:blog_app/src/presentation/features/hilos/widgets/comentarios/cargando/comentarios_cargando.dart';
import 'package:blog_app/src/presentation/features/hilos/widgets/hilo/cargando/body/hilo_cargando.dart';
import 'package:flutter/material.dart';

class HiloViewCargando extends StatelessWidget {
  const HiloViewCargando({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList.list(
          children: const [
            HiloBodyCargando(),
            ComentarioCargando()
          ]
        )
      ],
    );
  }
}

 