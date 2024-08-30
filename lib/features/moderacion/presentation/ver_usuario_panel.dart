import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class VerUsuarioPanel extends StatelessWidget {
  const VerUsuarioPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ScrollController(),
      builder: (context, child) => CustomScrollView(
        controller: context.read(),
        slivers: const [
          SliverToBoxAdapter(
            child: _InformacionDeUsuario(),
          ),
          SliverToBoxAdapter(
            child: _SeleccionarHistorial(),
          ),
          _HistorialDeHilos()
        ],
      ),
    );
  }
}

class _SeleccionarHistorial extends StatelessWidget {
  const _SeleccionarHistorial({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.white,
      child: Row(
        children: [],
      ),
    );
  }
}

class _HistorialDeHilos extends StatelessWidget {
  const _HistorialDeHilos({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: context.read(),
      slivers: [
        SliverList.builder(
          itemBuilder: (context, index) =>
              const _PostDeUsuarioCreadoHistorial(),
        )
      ],
    );
  }
}

class _InformacionDeUsuario extends StatelessWidget {
  const _InformacionDeUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(
          height: 100,
          width: 100,
        ),
        Column(children: [
          Row(
            children: [
              Text("ANONIMO"),
              Text("#bb2638dd-268a"),
            ],
          ),
          Text("Unido desde 15/25/2000")
        ]),
      ],
    );
  }
}

class _PostDeUsuarioCreadoHistorial extends StatelessWidget {
  const _PostDeUsuarioCreadoHistorial({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HistorialEntry(
      child: Row(
        children: [
          _HistoriaHiloImagen(),
          Column(children: [
            Row(
              children: [
                Text(
                  "Titulo",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                ),
                Text("06/34/2000")
              ],
            ),
            SizedBox(height: 10),
            Text("Descripcion....")
          ]),
          Icon(Icons.chevron_right)
        ],
      ),
    );
  }
}

class _HistoriaHiloImagen extends StatelessWidget {
  const _HistoriaHiloImagen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: 120,
        width: 90,
        child: Image(
          image: NetworkImage("url"),
        ));
  }
}

class _HistorialEntry extends StatelessWidget {
  final Widget child;
  const _HistorialEntry({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: child),
      ),
    );
  }
}

class _ComentarioDeUsuarioHistorial extends StatelessWidget {
  const _ComentarioDeUsuarioHistorial({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _HistoriaHiloImagen(),
        Column(
          children: [
            Text("Titulo"),
            Row(children: [
              SizedBox(
                  height: 50,
                  width: 50,
                  child: Image(image: NetworkImage("url")))
            ]),
            Text("Comentario....")
          ],
        )
      ],
    );
  }
}
