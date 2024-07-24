import 'package:blog_app/common/widgets/inputs/decorations/decorations.dart';
import 'package:flutter/material.dart';

class IngresarInputView extends StatelessWidget {
  final void Function(BuildContext context, TextEditingController controller) onTap;
    
  const IngresarInputView({
    super.key, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () => onTap(context, controller),
              child: Text("Guardar")
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(7),
          child: TextField(
            maxLines: 5,
            controller: controller,
            decoration: FlatInputDecoration(
              hintText: "Ingresa un link"
          ),
        ),
      )
    );
  }
}