import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class VerUsuarioPanel extends StatelessWidget {
  const VerUsuarioPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
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
            _HistorialDeHilos(),
          ],
        ),
      ),
    );
  }
}

class _SeleccionarHistorial extends StatelessWidget {
  const _SeleccionarHistorial({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: ColoredBox(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: SizedBox(
              child: Row(
                children: [
                  SeleccionarHistorialBtn(
                    onTap: () {},
                    icon: const FaIcon(FontAwesomeIcons.noteSticky,
                        size: 20, color: Colors.black),
                    label: "Posts",
                    seleccionado: true,
                  ),
                  SeleccionarHistorialBtn(
                    onTap: () {},
                    icon: const FaIcon(FontAwesomeIcons.message,
                        size: 20, color: Colors.black),
                    label: "Comentarios",
                    seleccionado: false,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SeleccionarHistorialBtn extends StatelessWidget {
  final String label;
  final Widget icon;
  final bool seleccionado;
  final void Function() onTap;
  const SeleccionarHistorialBtn({
    super.key,
    required this.label,
    required this.icon,
    required this.seleccionado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: !seleccionado
                ? Theme.of(context).scaffoldBackgroundColor
                : null,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HistorialDeHilos extends StatelessWidget {
  const _HistorialDeHilos({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      sliver: SliverList.builder(
        itemCount: 100,
        itemBuilder: (context, index) => const _PostDeUsuarioCreadoHistorial(),
      ),
    );
  }
}

class _InformacionDeUsuario extends StatelessWidget {
  const _InformacionDeUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: ColoredBox(
                color: Colors.white,
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: Center(child: FaIcon(FontAwesomeIcons.user, size: 35)),
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(children: [
              Row(
                children: [
                  Text(
                    "ANONIMO",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text("#bb2638dd-268a"),
                ],
              ),
              Text("Unido desde 15/25/2000")
            ]),
          ],
        ),
      ),
    );
  }
}

class _PostDeUsuarioCreadoHistorial extends StatelessWidget {
  const _PostDeUsuarioCreadoHistorial({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: _HistorialEntry(
        child: Row(
          children: [
            const _HistoriaHiloImagen(),
            const SizedBox(width: 10),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RichText(
                            maxLines: 1,
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: const <TextSpan>[
                                TextSpan(
                                    text:
                                        'Entrassssssssssssssssssssssssssssssssssssssssssssssss',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        overflow: TextOverflow.ellipsis)),
                              ],
                            ),
                          ),
                          const Text("Descripcion....")
                        ]),
                  ),
                  const Icon(Icons.chevron_right)
                ],
              ),
            )
          ],
        ),
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: const SizedBox(
          height: 120,
          width: 110,
          child: Image(
            fit: BoxFit.cover,
            image: NetworkImage(
                "https://static.wikia.nocookie.net/silenthill/images/c/cf/Laura_teddies.jpg/revision/latest?cb=20110918063710&path-prefix=es"),
          )),
    );
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

class AdvetirDeBaneo extends StatelessWidget {
  const AdvetirDeBaneo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Has sido baneado",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const _InformacionDeBaneo(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: ConstrainedBox(
                  constraints: const BoxConstraints(
                      minHeight: 100, minWidth: double.infinity),
                  child: const ColoredBox(
                      color: Colors.white,
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                          child: Text(
                            "No lo vuelvas a hacer\nokk?",
                            style: TextStyle(fontSize: 17),
                          )))),
            ),
          ),
        ],
      ),
    );
  }
}

class _InformacionDeBaneo extends StatelessWidget {
  const _InformacionDeBaneo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
