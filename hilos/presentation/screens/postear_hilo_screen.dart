import 'package:flutter/material.dart';

class PostearHiloScreen extends StatelessWidget {
  const PostearHiloScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            //titulo
            TextField(),
            SizedBox(height: 10),
            //descripcion
            TextField(
              maxLines: 5,
            )
            //portada
            //subcategoria
          ],
        ),
      ),
    ));
  }
}
