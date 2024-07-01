import 'package:blog_app/src/presentation/common/widgets/inputs/flat_input.dart';
import 'package:blog_app/src/presentation/features/auth/common/widgets/auth_label.dart';
import 'package:flutter/material.dart';

class RegistroView extends StatelessWidget {
  const RegistroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RegistroBody(),
    );
  }
}

class RegistroBody extends StatelessWidget {
  const RegistroBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthLabel(text: "Introduce tus datos",),
        Column(
          children: [
            InputFlatField(
              hintText: "Usuario",
            )
          ],
        )
      ],
    );
  }
}