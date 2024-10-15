import 'package:blog_app/common/logic/extensions/scroll_controller.dart';
import 'package:blog_app/features/auth/presentation/widgets/bottom_sheet/sesion_requerida_bottomsheet.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:blog_app/features/media/presentation/logic/extensions/media_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'logic/historial_de_comentarios/historial_de_comentarios_bloc.dart';

class HistorialDeComentarios extends StatefulWidget {
  const HistorialDeComentarios({super.key});

  @override
  State<HistorialDeComentarios> createState() => _HistorialDeComentariosState();
}

class _HistorialDeComentariosState extends State<HistorialDeComentarios> {
  @override
  void initState() {
    HistorialDeComentariosBloc bloc = context.read();
    ScrollController controller = context.read();

    bloc.add(CargarSiguientePagina());

    controller.addListener(() {
      if (controller.isBottom()) {
        if (bloc.state.status != HistorialDeComentariosStatus.cargando) {
          bloc.add(CargarSiguientePagina());
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistorialDeComentariosBloc, HistorialDeComentariosState>(
      builder: (context, state) {
        return SliverList.builder(
          itemCount: state.comentarios.length,
          itemBuilder: (context, index) =>
              ItemHistorialDeComentario(state.comentarios[index]),
        );
      },
    );
  }
}

class ItemHistorialDeComentario extends StatelessWidget {
  final HistorialDeComentarioItem comentario;
  const ItemHistorialDeComentario(
    this.comentario, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: Image(
                    fit: BoxFit.cover,
                    image: comentario.hilo.portada.toProvider(),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ha comentado: ${comentario.hilo.titulo}",
                      maxLines: 2,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Flexible(child: Text(comentario.comentario)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: FlatBtnStyle().copyWith(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(
                      width: 1,
                      color: Color.fromARGB(255, 237, 232, 232),
                    ),
                  ),
                ),
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
                backgroundColor: const WidgetStatePropertyAll(Colors.white),
              ),
              onPressed: () => context.push("/hilo/${comentario.hilo.id}"),
              child: const Text(
                "Ver hilo",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 2,
        ),
      ],
    );
  }
}
