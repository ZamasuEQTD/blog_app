
import 'package:blog_app/common/widgets/button/filled_icon_button.dart';
import 'package:blog_app/common/widgets/inputs/decorations/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/portadas/portadas_home_bloc.dart';

class FiltrosPortadasHome extends StatelessWidget {
  const FiltrosPortadasHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Flexible(
            child: BusquedaDePortadasPorTitulo()
          ),
          const SizedBox(width: 10),
          ColoredIconButton(
            onPressed: () {},
            icon: const Icon(Icons.abc),
          )
        ],
      ),
    );
  }
}

class BusquedaDePortadasPorTitulo extends StatelessWidget {
  const BusquedaDePortadasPorTitulo({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return ClipRRect(
      child: TextField(
        controller: controller,
        maxLines: 1,
        minLines: 1,
        decoration: BusquedaInputDecoration(borderRadius: 10,
          hintText: "Titulo de hilo",
          onTap: () => context
              .read<PortadasHomeBloc>()
              .add(CambiarFiltrosDePortadas(titulo: controller.text)
          ),
        ),
      ),
    );
  }
}
