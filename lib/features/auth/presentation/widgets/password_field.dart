import 'package:flutter/material.dart';

import '../../../../common/widgets/inputs/decorations/decorations.dart';

class PasswordField extends StatefulWidget {
  final String hintText;
  final void Function(String value) onChanged;
  const PasswordField({
    super.key,
    required this.hintText,
    required this.onChanged,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: widget.onChanged,
        decoration: FlatPasswordDecoration(
          hintText: widget.hintText,
          isObscure: obscure,
          onTap: () {
            setState(() {
              obscure = !obscure;
            });
          },
        ));
  }
}
