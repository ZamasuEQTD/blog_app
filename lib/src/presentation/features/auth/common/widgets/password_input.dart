
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/inputs/flat_input.dart';

class ObscuredFlatInput extends StatefulWidget {
  final String? hintText;
  const ObscuredFlatInput({super.key, this.hintText});

  @override
  State<ObscuredFlatInput> createState() => _ObscuredFlatInputState();
}

class _ObscuredFlatInputState extends State<ObscuredFlatInput> {
  bool mostrarPassword = false;
  
  @override
  Widget build(BuildContext context) {
    return InputFlatField(
      maxLines: 1,
      hintText: widget.hintText,
      obscureText: mostrarPassword,
      suffix: IconButton(
        onPressed: _onToggleMostrarPassword,
        icon: Icon(
          mostrarPassword ? CupertinoIcons.eye_slash : CupertinoIcons.eye
        )
      ),
    );
  }

  void _onToggleMostrarPassword() {
    setState(() {
      mostrarPassword = !mostrarPassword;
    });
  }
}