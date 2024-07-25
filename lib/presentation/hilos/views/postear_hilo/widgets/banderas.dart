import 'package:blog_app/common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import 'package:blog_app/common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import 'package:blog_app/common/widgets/seleccionable/widget/grupo_seleccionable_list.dart';
import 'package:blog_app/presentation/hilos/views/postear_hilo/logic/bloc/postear_hilo/postear_hilo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfiguracionDeBanderas extends StatelessWidget {
  const ConfiguracionDeBanderas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Banderas",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            BlocBuilder<PostearHiloBloc, PostearHiloState>(
              buildWhen: (previous, current) => previous.banderas != current.banderas,
              builder: _builder,
            )
          ],
        ),
      ),
    );
  }

  Widget _builder(BuildContext context, PostearHiloState state) {
    return SeleccionableSheet(
      grupo: GrupoSeleccionable(seleccionables: [
        CheckboxSeleccionableList(
          value: state.banderas.dados,
          nombre: "Dados",
          onChange: (value) => context.read<PostearHiloBloc>().add(CambiarBanderas(
            dados: value
          ))
        ),
        CheckboxSeleccionableList(
          value: state.banderas.tagUnico,
          nombre: "Tag único activado",
          onChange: (value) => context.read<PostearHiloBloc>().add(CambiarBanderas(
            tagUnico: value
          )),
        )
      ])
    );
  }
}

class PostearHiloSection extends StatelessWidget {
  const PostearHiloSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}