import 'package:blog_app/src/presentation/common/widgets/inputs/flat_input.dart';
import 'package:flutter/material.dart';

class FiltrosPortadasHome extends StatelessWidget {
  const FiltrosPortadasHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: InputFlatField(hintText: "Titulo")),
        IconButton(onPressed: () {},
        icon: Icon(Icons.abc),
        style: ButtonStyle(
          fixedSize: WidgetStatePropertyAll(Size(30,30)),
          shape: WidgetStatePropertyAll(OvalBorder())
        ),
        )
      ],
    );
  }
}