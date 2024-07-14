import 'package:blog_app/src/presentation/common/widgets/inputs/flat_input.dart';
import 'package:blog_app/src/presentation/features/home/logic/bloc/bloc/portadas_home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FiltrosPortadasHome extends StatelessWidget {
  const FiltrosPortadasHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Flexible(child: BusquedaDePortadasPorTitulo()),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.abc),
            style: const ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size(30, 30)),
                shape: WidgetStatePropertyAll(OvalBorder())),
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
        decoration: BusquedaInputDecoration(
          hintText: "Titulo de hilo",
          onTap: () => context
              .read<PortadasHomeBloc>()
              .add(CambiarFiltrosDePortadas(titulo: controller.text)),
        ),
      ),
    );
  }
}
