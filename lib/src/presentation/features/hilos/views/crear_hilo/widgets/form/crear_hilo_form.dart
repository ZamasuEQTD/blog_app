import 'package:flutter/material.dart';

import '../../../../../../common/widgets/inputs/flat_input.dart';

class CrearHiloForm extends StatelessWidget {
  const CrearHiloForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        InputFlatField(
           hintText: "Titulo",
        ),
        SizedBox(height: 5),
        InputFlatField(
          hintText: "Descripcion",
          maxLines: 5,
        ),
      ],
    );
  }
}