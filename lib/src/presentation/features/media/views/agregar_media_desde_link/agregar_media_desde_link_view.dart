import 'package:blog_app/src/presentation/common/widgets/inputs/flat_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgregarMediaDesdeLinkView extends StatelessWidget {
  const AgregarMediaDesdeLinkView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: const Icon(CupertinoIcons.chevron_back,color: Colors.black,),
        actions: [TextButton(onPressed: () {}, child: const Text("Guardar"))],
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: InputFlatField(
              maxLines: 7, 
              minLines: 7,
              hintText: "Ingresa tu link"
            ),
          )
      ],),
    );
  }
}