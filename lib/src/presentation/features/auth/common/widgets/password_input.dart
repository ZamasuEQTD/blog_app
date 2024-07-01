
import 'package:flutter/material.dart';

import '../../../../common/widgets/inputs/flat_input.dart';

class PasswordFlatInput extends StatefulWidget {
  const PasswordFlatInput({super.key});

  @override
  State<PasswordFlatInput> createState() => _PasswordFlatInputState();
}

class _PasswordFlatInputState extends State<PasswordFlatInput> {
  bool mostrarPassword = false;
  
  @override
  Widget build(BuildContext context) {
    return InputFlatField(
      hintText: "Contraseña",
      obscureText: mostrarPassword,
    );
  }

  void _onToggleMostrarPassword() {
    setState(() {
      mostrarPassword = !mostrarPassword;
    });
  }
}