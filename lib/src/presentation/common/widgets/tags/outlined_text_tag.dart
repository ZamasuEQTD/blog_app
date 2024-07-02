import 'package:flutter/material.dart';

import 'tag.dart';

class OutlinedTag extends StatelessWidget {
  final String texto;
  const OutlinedTag({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Tag(
        height: 25,
        txt: texto,
        textStyle: const TextStyle(color: Colors.black),
        color: Colors.white,
        border: Border.all(color: const Color.fromRGBO(199, 199, 199, 1))
    );
  }
}
