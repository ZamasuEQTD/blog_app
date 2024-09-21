import 'package:blog_app/common/widgets/inputs/decorations/decorations.dart';
import 'package:flutter/material.dart';

class AgregarEnlaceScreen extends StatelessWidget {
  const AgregarEnlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TextField(
        decoration: FlatInputDecoration(
          hintText: "De momento se aceptan enlaces de Youtube",
        ),
      ),
    );
  }
}
